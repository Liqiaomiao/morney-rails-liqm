require 'rails_helper'

RSpec.describe User, type: :model do
  context 'before publication' do  # (almost) plain English
    it 'create user' do   #
      user = User.create email: 'lisa@qq.com', password: '123456', password_confirmation: '123456'
      expect(user.password_digest).to_not eq '123456'  # test code
    end
    it 'delete user' do
      user = User.create email: 'lisa@qq.com', password: '123456', password_confirmation: '123456'
      expect{
        User.destroy_by id: user.id
      }.to change {User.count}.by(-1)
    end
    it 'Email is required when creating' do
      user = User.create email: ''
      expect(user.errors.details[:email][0][:error]).to eq(:blank)
    end
    it 'Email cannot be occupied when created' do
      user = User.create email: 'lisa@qq.com', password: '123456', password_confirmation: '123456'
      user =  User.create email: 'lisa@qq.com', password: '123456', password_confirmation: '123456'
      expect(user.errors.details[:email][0][:error]).to eq(:taken)
    end
    it 'Email to users after created' do
      x = spy('xxx')
      allow(UserMailer).to receive(:welcome_email).and_return(x)
      User.create! email: '1@qq.com', password: '123456', password_confirmation: '123456'
      expect(UserMailer).to have_received(:welcome_email)
      expect(x).to have_received(:deliver_now)

    end
  end
end
