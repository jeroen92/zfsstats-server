# ZFS-Stats server
During the last half year I incidentally worked on this project out of personal interest. First of all to learn some programming and second, because I wanted to gain insight of my ZFS SAN performance. Since everything is working pretty nice and stable so far, I would like to share this project with the community.

You can try out a live demo at [zfsstats.jeroen92.nl](zfsstats.jeroen92.nl)

## Overview

In order to use this server application, you'll need the [client scripts](https://github.com/jeroen92/zfsstats-clientscripts) too. 

*So far, the clientscripts are tested and developed only for OpenIndiana. In case there's enough interest I might port it to FreeBSD and/or Linux too.*

## How to use

### Prerequisites

The following software should be installed:

- MongoDB server
- Ruby
- Rails gem

### Installation

1. Clone this git repository

	`git clone https://github.com/jeroen92/zfsstats-server.git`
	
2. Install required Ruby gems

	`cd zfsstats-server && bundle install --deployment`
	
3. Review production database configuration

	`nano config/mongoid.yml`
	
4. Seed the database

	`RAILS_ENV=production rake db:seed`
	
5. Install a webserver to server static content. Best way to do this is by installing Passenger

	Install prerequisites
	
	`apt-get install libcurl4-openssl-dev apache2-mpm-worker apache2-threaded-dev libapr1-dev libaprutil1-dev`
	
	Start Passenger installation
	
	`sudo gem install passenger && sudo passenger-install-apache2-module`

	Then, follow the instructions shown.
	
6. When that's done, your application should be running when starting apache2.

	You might need to precompile the assets first
	
	`RAILS_ENV=production bundle exec rake assets:precompile`
	
	Then reload Apache webserver
	
	`sudo service apache2 reload`

That's all so far. Now you can start to setup your ZFS servers with the [client scripts](https://github.com/jeroen92/zfsstats-clientscripts).
