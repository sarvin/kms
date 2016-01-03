# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Compile CSS for home controller
%w(home states).each do |controller|
	Rails.application.config.assets.precompile += ["#{controller}.js.coffee", "#{controller}.css"]
end

Rails.application.configure do
	### Newline like below for each asset we need added
	config.assets.precompile += %w( foundation.js )
	config.assets.precompile += %w( foundation.css )
end
