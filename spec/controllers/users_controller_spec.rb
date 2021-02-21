# spec/requests/users_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { build(:user) }
  let(:valid_attributes) do
    attributes_for(:user, name: user.name, email: user.email, title: user.title, phone: user.phone, status: user.status)
  end

  describe 'create' do
    context 'when valid request' do
      before { post 'users#create', params: valid_attributes }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when invalid request' do
      before { post '/users', params: {} }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end
    end
  end
end