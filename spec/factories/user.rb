require 'ffaker'

FactoryBot.define do
	factory :user do
	  sequence(:first_name) { |n| "First#{n}" }
	  sequence(:last_name) { |n| "Last#{n}" }

    birthday { FFaker::Time.date }
    address { FFaker::Address.street_address }
	end
end
