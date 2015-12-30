# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

state_name = []

csv_text = File.read(Rails.root.join('lib', 'seeds', 'us_state_table.csv'))
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
	#puts row.to_hash
	# FYI: We're not doing case sensitive searching
	state = State.find_by name: row['name'].downcase

	unless state
		puts "State not found in database. Creating new state with name #{row['name']}"
		state = State.new
		state.name = row['name'].downcase
	end

	state.abbreviated_name = row['abbreviation']
	state.census_division_name = row['census_division_name']
	state.save

	puts "#{state.name}, #{state.abbreviated_name} saved"

	state_name.push(state.name)
end

# Check for rows exising in table that don't exist in CSV file
states_to_remove = State.where.not(name: state_name)
states_to_remove.each { |state_to_remove| state_to_remove.destroy}
