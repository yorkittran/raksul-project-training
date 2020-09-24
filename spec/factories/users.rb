# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'anh.tt@raksul.com' }
    fullname { 'AnhTT' }
    password { '12341234' }
  end
end
