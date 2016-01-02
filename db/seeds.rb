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

page_list = [
  ['home', 'Official Website of the Killer Mans Sons Motorcycle Club', 'The club is independent, and not affiliated with or sponsored by any motorcycle manufacturer, group or other ORGANIZATION. The club was founded to promote motorcycling and camaraderie amongst active duty and former members of the 75th Ranger Regiment, active combat attachments, and immediate Gold Star Family members. The goal of the Killer Mans Sons Motorcycle Club is to generate an increased level of enthusiasm for riding motorcycles and to support members of the 75th Ranger Regiment, Ranger Families and other charitable organizations. All members must be a current or former member of the 75th Ranger Regiment; personnel attached to the Regiment who served in a direct combat role (tacp, eod, etc) from other units and immediate Gold Star Family members.
					<p> For more history visit the U.S. Army Ranger Association’s Website: <a href="http://www.ranger.org/">Ranger.org</a>'],
  ['history', 'Our History', 'One of the strongest of human desires over the years is the desire to belong. To feel like you have a place to be yourself. To have people you can depend on. Those who have served in the military, and specifically the special operations world, know this feeling. Members of the 75th Ranger Regiment know this feeling. Unfortunately, too many also know what it is like to leave that place, that sense of belonging, that Brotherhood.
For years Rangers have ridden together, into battle and recreationally. Robert Rogers Rangers riding into battle on horseback, World War II Rangers riding through the countryside on their motorcycles after returning home from years in theatre, or modern day Rangers riding helicopters into the dusty horizons of the middle east. We ride together. For those who have ended their time in service, the desire to ride with our Brothers has diminished not at all. Nor has the camaraderie we felt standing shoulder to shoulder as we watched a fallen Brother make the journey home. This Brotherhood is borne out of risking our lives for the benefit of others, by defending our country, and by helping those we care about.
This camaraderie and feeling of belonging has been found in few places throughout the years. It is not something that everyone, or even a large number of people, ever experience. And for those who have experienced it, it is not something you ever wish to leave. Which has led us to where we are today. The Killer Man’s Sons Motorcycle Club was officially founded on the first of February 2012, but as you can probably guess we trace our origins back a bit further. We encourage and cultivate this sense of Brotherhood by spending time together, taking care of each other, and taking care of the Fallen and their families.
Our Name
You may wonder where our name comes from. It originated from a running cadence popular with members of the 75th Ranger Regiment that goes a bit like this:
I am a man of death
Killing commies right and left
I’m not the Killer man, I’m the Killer Man’s Son
But I’ll do the killin’ ’til the Killer Man comes
Our Colors
The colors that we carry are of paramount importance to us. They are a combination of elements that mean a great deal to us as Rangers and as people:
Killer Man’s Sons: Our club’s top rocker contains our club name.
Established 1974: The Killer Man’s Sons are not territorial, which is why our bottom rocker bears these words as opposed to a state or region. After the Vietnam conflict, division and brigade commanders determined that the U.S. Army needed elite, rapidly deployable light infantry, so in 1974 General Creighton Abrams constituted the 1st Ranger Battalion; eight months later, the 2nd Ranger Battalion was constituted, and in 1984 the 3rd Ranger Battalion and their regimental headquarters were created. In 1986, the 75th Ranger Regiment was formed and their military lineage formally authorized. The “Established 1974″ on our bottom rocker refers to the founding of the modern American Ranger, though the history of Rangers in service to the United States goes back centuries. For more history visit the U.S. Army Ranger Association’s Website: http://www.ranger.org/
Back Patch: The Skull-Skulls have long been associated with death and mortality. Whether it is your own or a close friend, volunteering to be a Ranger is volunteering to be acquainted with death and loss. We wear a skull to remind us of the sacrifice that our fallen Brothers made before they went to the Creator.
The Raven-The Ranger Regiment is an airborne infantry unit. The Raven on our patch signifies death as well, but a death visited upon our enemies from the air. Whether it is running off of a helicopter or jumping onto an airfield from 600 feet. Death from Above.
The Roman Numeral II-This number, found inside the silhouette of the Raven represents the two original modern Ranger Battalions that began in 1974.
The Dagger-Knifing through the Skull is the Killer Man’s Sons Dagger. To us it represents the Special Operations world, the “Tip of the Spear” so to speak.
The Reticle-To the left of the Dagger can be found half of a rifle scope Reticle. This reminds us of the precision and care that must be practiced in all things. Attention to detail must be paid.
The Reticle Dots-The three Dots on the Reticle represent the three modern day Ranger Battalions.
The Sun-The Sun symbol was taken from the Chinese flag. It represents the cooperation between the 5307th Composite Unit (Provisional), more famously known as “Merrill’s Marauders”, and Chinese forces during World War II.
The Star-The Star represents the Star of Burma, the country in which the Marauders campaigned during World War II.
The Lightning Bolt-The Lightning Bolt is representative of the strike tactics used by the Marauders as well as the fast and decisive tactics used by modern day Rangers.
The Diamond-The Diamond containing the letters “MC” denote that the Killer Man’s Sons are a motorcycle club and are reminiscent of the Ranger Diamond used during World War II to identify Ranger units.']
]

page_list.each do |title, sub_title, body|
  page = Page.find_by(title: title)

  if page
	puts "page already found with title #{title}"
  else
	page = Page.new
	page.title = title
	page.sub_title = sub_title
	page.body = body
	page.save
  end
end
