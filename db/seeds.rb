require 'ffaker'

(1..20).each do |i|
	User.create(
		first_name: FFaker::Name.first_name,
		last_name: FFaker::Name.last_name,
		birthday: FFaker::Time.date,
		address: FFaker::Address.street_address
	)
end
