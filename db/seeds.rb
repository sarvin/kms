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

chapter_list = [
  ['Smiths Station', 'alabama', 'For more information email the KMS at <a href="mailto:kmssmithsstation@gmail.com">kmssmithsstation@gmail.com</a>' ],
  ['San Andreas', 'california', 'For more information email the KMS at <a href="mailto:kmsmcsanandres@gmail.com">kmsmcsanandres@gmail.com</a>'],
  ['Ft Brooke', 'florida', 'For more information email the KMS at <a href="mailto:KMSFTB@gmail.com">KMSFTB@gmail.com</a>'],
  ['Low Country', 'georgia', 'For more information email the KMS at <a href="mailto:lowcountrykmsmc@gmail.com">lowcountrykmsmc@gmail.com</a>'],
  ['Sandhills', 'north carolina', 'For more information email the KMS at <a href="mailto:kmsmcsandhills@gmail.com">kmsmcsandhills@gmail.com</a>'],
  ['Cross Timbers', 'texas', 'For more information email the KMS at <a href="mailto:kmscrosstimbers@gmail.com">kmscrosstimbers@gmail.com</a>'],
  ['Tacoma', 'washington', 'For more information email the KMS at <a href="mailto:Kmstacoma@gmail.com">Kmstacoma@gmail.com</a>']
]

chapter_list.each do |chapter_name, state_name, page_body|
  chapter = Chapter.find_by(name: chapter_name)

  if chapter
	puts "Chapter found with name: #{chapter_name}"
  else chapter
	puts "Creating Chapter with name: #{chapter_name}"
	chapter = Chapter.new

	chapter.name = chapter_name

	state = State.find_by(name: state_name)
	chapter.state_id = state.id

	chapter.save
  end

  page = chapter.page
  if page
	puts "Page already associated with chapter"
  else
	page = chapter.build_page

	page.body = page_body
	page.save
  end
end
