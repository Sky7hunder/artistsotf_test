require 'ffaker'

FactoryBot.define do
	factory :user do
	  first_name { FFaker::Name.first_name }
	  last_name { FFaker::Name.last_name }
    birthday { FFaker::Time.date }
    address { FFaker::Address.street_address }
	end
end
