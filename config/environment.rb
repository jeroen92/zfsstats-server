# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
ZfsstatsRails::Application.initialize!

APP_VERSION = `git describe --always` unless defined? APP_VERSION