# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'us_state_table.csv'))
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
	#puts row.to_hash

	state = State.new
	state.name = row['name']
	state.abbreviated_name = row['abbreviation']
	state.census_division_name = row['census_division_name']
	state.save

	puts "#{state.name}, #{state.abbreviated_name} saved"
end
