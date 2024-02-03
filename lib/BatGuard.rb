# frozen_string_literal: true

require_relative "BatGuard/version"
require 'bcrypt'
require 'json'
require 'digest/sha2'
require 'base64'

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

    def generate_jwt(secret_key)
      header = { alg: 'HS256', typ: 'JWT' }
      payload = { username: username }

      encoded_header = base64_url_encode(header.to_json)
      encoded_payload = base64_url_encode(payload.to_json)
      signature = calculate_signature(encoded_header, encoded_payload, secret_key)

      "#{encoded_header}.#{encoded_payload}.#{signature}"
    end

    def self.from_jwt(token, secret_key)
      encoded_header, encoded_payload, signature = token.split('.')
      header = JSON.parse(base64_url_decode(encoded_header))
      payload = JSON.parse(base64_url_decode(encoded_payload))

      # Verify the signature
      calculated_signature = calculate_signature(encoded_header, encoded_payload, secret_key)
      return nil unless calculated_signature == signature

      new(payload['username'], nil) if payload && payload['username']
    rescue JSON::ParserError
      nil
    end

    private

    def calculate_signature(encoded_header, encoded_payload, secret_key)
      data = "#{encoded_header}.#{encoded_payload}"
      Base64.urlsafe_encode64(Digest::SHA256.digest("#{data}.#{secret_key}"))
    end

    def base64_url_encode(str)
      Base64.urlsafe_encode64(str).tr('=', '')
    end

    def base64_url_decode(str)
      str += '=' * (4 - str.length % 4)
      Base64.urlsafe_decode64(str)
    end
  end

  class Authorization
    def self.authorize(token, secret_key, required_roles = [])
      user = User.from_jwt(token, secret_key)
      return false unless user

      # Check if user has the required roles
      required_roles.empty? || (user_roles & required_roles).any?
    end

    private

    def self.user_roles
      # TODO: Define roles for your users or retrieve them from your user model
      ['user', 'admin']
    end
  end
end
