require './lib/BatGuard'
require 'spec_helper'

RSpec.describe BatGuard::User do
  let(:username) { 'testuser' }
  let(:password) { 'testpassword' }
  let(:user) { BatGuard::User.new(username, password) }

  it 'authenticates with correct password' do
    expect(user.authenticate(password)).to be(true)
  end

  it 'does not authenticate with incorrect password' do
    expect(user.authenticate('wrongpassword')).to be(false)
  end

  it 'generates a JWT token' do
    token = user.generate_jwt
    expect(token).not_to be_empty
  end

  it 'decodes JWT token to get the user' do
    token = user.generate_jwt
    decoded_user = BatGuard::User.from_jwt(token)
    expect(decoded_user).to be_instance_of(BatGuard::User)
    expect(decoded_user.username).to eq(username)
  end
end
