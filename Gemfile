source 'http://rubygems.org'
gem 'rails', '3.1.3'

# postgresql connector
gem 'pg', '~>0.12.2'

# layout of all forms
gem 'formtastic'#, '1.2.3'

# used for layout only of application
gem 'nifty-generators', '0.4.6'

# authentication
gem 'devise', '~>2.0.0' 

#xml parser
gem 'nokogiri', '1.5.0'

# json parser
gem 'json', '1.5.1'

# authorisation
gem 'declarative_authorization', '0.5.3'

# paginate all index views
gem 'will_paginate','3.0.pre2'



# using jquery for ajax, not prototype > rails g jquery:install
gem 'jquery-rails', '~>1.0.12' #, '0.2.7'

#helps with I18n not used at present
gem 'routing-filter', '0.2.3'

# acts as tree provides access to parents and children without coding more than parent_id (i.e. no has_many needed)
gem 'acts_as_tree','0.1.1'

=begin
 haml contains sass
 to start sass to automatically update calm.scss (when you save calm.scss) to donotedit/calm.css
 $>sass --watch calm.scss:donotedit/calm.scss
=end
#gem 'haml', '3.0.25'
# converts ruby objects to js objects
#gem 'lucy', '0.2.1'
=begin
 depends on lucy. Allows you to use rails translations in js
 e.g. I18n.t('activerecord.errors.template.header', {count:4, model:'pony'}) // "4 errors prohibited this pony from being saved"
 It makes a locales.js file in the default javascripts directory.
 This file contains a copy of all translations in the application
 Beware of including the faker gem as this has lots of translation files: you'll be getting lots of garbage translations in real locales that you don't want
=end
#gem 'babilu', '0.2.2'
# paperclip uploads a file and writes the file name etc to the database
gem 'paperclip', '2.3.11'

#gem 'psych'
#Eliminates need to use sql by give extra functions/operators for querying in activerecord
#gem "meta_where"
# Allows QBE with activerecord
#gem "meta_search"
# this gem checks RI in a belongs_to relationship (create th FK anyway)
# Didn't have good i18n and seemed tio double up error messages, so copied the validation to our validations.rb and modified,
#gem "validates_existence"

gem "redis" #, :git => "git://github.com/ezmobius/redis-rb.git"
# foreigner is a gem that allows the insertion of foreign keys into migrations.
# Doesn't work with automigrate. Too bad.
#gem "foreigner"
# for 3.1
gem 'execjs'
gem 'therubyracer'
# in place editing
gem 'best_in_place'

# for doing searches with criteria. Replaces meta_where for rails 3.1
gem 'squeel'

group :development, :test do
  gem 'rspec-rails', '2.8.0'
  # webrat or capybara can be used to simulate a browser. rspec doesn't care which one.
  gem 'capybara', :git =>'git://github.com/jnicklas/capybara.git'
  #gem 'webrat','0.7.3'
 # gem 'cucumber'
  #gem 'cucumber-rails'
  gem 'database_cleaner'
  
  gem 'launchy'
  gem 'autotest', '4.4.6'
    # rspec advises not to install autotest-rails (but says nothing about autotest-rails-pure). rspec advises only autotest
  gem 'autotest-rails-pure','4.1.2'
  # test server for rspec
  gem 'spork', '~> 0.9.0'

  # will document model according to migrations (actually according to schema)
  #gem 'annotate-models', '1.0.4'
  gem 'annotate'
=begin
 debug that works with ruby 1.9
 place
 debugger
 in code to create breakpoint
 start webrick >rails s --debugger
 then use list, p(rint) var_name, step, next( same as step except skips functions),
c(ontinue) etc to look at code at breakpoint break to set a breakpoint, where for stack, restart,
display/undisplay
=end
  gem 'ruby-debug19', '0.11.6'
=begin
 generate test data
 exclude faker except when you need to use it as it will turn up lots of fake locales and translations in:
  1. locales.js (via babilu)
  2. rake i18n:missing translations
=end
  #gem 'faker'

  # generate test data
  gem 'factory_girl_rails', '1.0.1'

end # end group dev, test
group :assets do
    gem 'sass-rails', " ~> 3.1.0"
    gem 'coffee-rails', "~> 3.1.0"
    gem 'uglifier'
end
#group :development do
  
  # for shared deployment
  #gem 'heroku', '1.19.1'

#end