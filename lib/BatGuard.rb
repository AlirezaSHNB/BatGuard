# frozen_string_literal: true

require_relative "BatGuard/version"
require 'my_auth_gem/user'

module BatGuard
  class Error < StandardError; end
  class User
    include BCrypt

    attr_accessor :username, :password_hash

    def initialize(username, password)
      @username = username
      @password_hash = Password.create(password)
    end

    def authenticate(password)
      Password.new(password_hash) == password
    end
  end
end
