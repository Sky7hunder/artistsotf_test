(1..20).each do |i|
	User.create(
		first_name: "First#{i}",
		last_name: "Last#{i}",
		birthday: Date.new(1990, 1, i),
		address: "#{i} Park Ave S, New York"
	)
end
