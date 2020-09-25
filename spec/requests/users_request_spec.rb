require 'rails_helper'

RSpec.describe "Users", type: :request do
  it 'should create  user' do
    post  '/users', params: {email:''}
    body = JSON.parse(response.body)
    expect(response.status).to eq 422
    expect(body['errors']['password'][0]).to eq '密码不能为空'
    expect(body['errors']['password'].length).to eq 1
    expect(body['errors']['email'][0]).to  eq '邮箱不能为空'
    expect(body['errors']['password'].length).to eq 1
    expect(body['errors']['password_confirmation'][0]).to eq '请填写确认密码'
    expect(body['errors']['password'].length).to eq 1
  end
  it 'should not get current user' do
    get '/me'
    expect(response).to have_http_status :not_found
    expect(response.body.blank?).to be true
  end
  it 'should get current user' do
    user = User.create! email:'12@qq.com', password: '123456',password_confirmation:'123456'
    post '/sessions', params: { email:'12@qq.com', password: '123456' }
    get '/me'
    body = JSON.parse(response.body)
    expect(response).to have_http_status :ok
    expect(user.id).to eq body['resource']['id']
  end
end
