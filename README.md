# **Bingeable.io**

Looking for a new show to binge watch?

Bingeable.io has a list of the top 100 TV shows, updated daily, and powered by [The Movie Database API](https://developers.themoviedb.org/3/getting-started/introduction).

Click from the list to view not just complete show details, but also includes a direct link to that show's page on JustWatch.com for current available streaming options.

Don't see your favorite show in the top 100 list?

Use the "Search" feature to look up any show by name!

All of this available with no need to create a user account.

Icing on the cake: Bust your side laughing at the randomly generated banner message every time you visit the homepage :)

Built with love using Ruby on Rails; check it out [here](http://www.bingeable.io/)!

## Table of Contents

* [Technologies Used](#technologies)
* [Problem](#problem)
* [Solution](#solution)
* [Trade-Offs](#trade-offs)
* [Installation](#installation)
* [Testing](#Testing)
* [Contacts](#contacts)

## Technologies Used

* Back-to-Front-end: [Ruby on Rails v5.1.6](https://guides.rubyonrails.org/), Ruby v2.4.0p0
* Database: [PostgreSQL](https://www.postgresql.org/about/)(production),
[SQLite Version 3](https://www.sqlite.org/version3.html) (development)
* API: [The Movie Database API](https://developers.themoviedb.org/3/getting-started/introduction)
* Libraries: [bootstrap-sass](https://github.com/twbs/bootstrap-sass#a-ruby-on-rails), [jquery-rails](https://github.com/rails/jquery-rails)
* Dependencies: [HTTParty](https://github.com/jnunemaker/httparty), [Figaro](https://github.com/laserlemon/figaro)
* Hosting: [Heroku](https://www.heroku.com/)

## Problem

* Functional requirements:

  * Landing page must list popular tv shows

  * Search bar that produces a list of shows whose titles match the search

  * Click any show title and go to page with more info about that show

* Technical requirements:

  * Create a full-stack application with a backend that communicates with the movie API.

  * The front-end should be intuitive to use.

  * Accompany code with a full test suite.

  * Deploy site to a web host (e.g. on Amazon EC2, Heroku, Netlify, Google AppEngine, etc.).



## Solution

Ruby on Rails was my first choice to get this app built quickly and reliably because the Rails framework relies on [convention over configuration](https://en.wikipedia.org/wiki/Convention_over_configuration). I also love how Rails will show you errors in the browser. You can quickly create views that communicate intuitively with corresponding controller files and the actions defined within.

Handling the API was easy using the [HTTParty gem](https://github.com/jnunemaker/httparty):

* add `gem 'httparty'` to the Gemfile,
* after adding any gem, in the terminal, within the project directory, run `$ bundle install`,
* `include HTTParty` at the top of the controller file just under the class declaration,
* then, `response = HTTParty.get(url with api environment variable)` to retrieve a JSON object saved to `response` you then can iterate over, reference, and get data you need to display.

Once I had the JSON object from the Movie DB API stored in `response`, I saved each value that I needed to display to an instance variable key, that could then be referenced from the view thanks to Rails convention.

Example:

* `tvshows_controller.rb - show method`:

 `@show["number_of_seasons"] = response["number_of_seasons"].to_s unless response["number_of_seasons"].nil?`

* then in `tvshows/show.html.erb`:

 `<p>Seasons: <%= @show["number_of_seasons"].to_s %></p>`

The Movie DB has EXCELLENT documentation and even has a "Try it out" tool you can practice with to be sure you are formatting the url correctly before feeding it to `HTTParty.get(...)` in your project. Here's the three `GET` requests I used to build this app, all you need is your own API key to start making calls to their database:

* [`GET /discover/tv`](https://developers.themoviedb.org/3/discover/tv-discover) for the index view (top 100 shows)

* [`GET /search/tv`](https://developers.themoviedb.org/3/discover/tv-discover) for the search tv shows by name feature

* [`GET /tv/{tv_id}`](https://developers.themoviedb.org/3/discover/tv-discover) for the search tv shows by name feature

Here's additional resources I found very useful while building this project:

* [StackOverflow: Using `link_to` with `image_tag`](https://stackoverflow.com/questions/5387122/link-to-image-tag-with-inner-text-or-html-in-rails)

* [StackOverflow: Sending parameters with `link_to`](https://stackoverflow.com/questions/2124862/link-to-send-parameters-along-with-the-url-and-grab-them-on-target-page)

* [Medium article "How to keep your credentials a secret when working with Rails."](https://medium.com/@thejasonfile/hide-your-api-keys-hide-your-skype-api-keys-884427746f9c)

* [Bootstrap `.card` (but also see `.jumbotron` `.container`, `col-xsm-12`, `Alerts`...the list goes on lol)](https://getbootstrap.com/docs/4.0/components/card/)

* [Treehouse Blog: "It's time to HTTParty!"](https://blog.teamtreehouse.com/its-time-to-httparty)

* [Google fonts](https://fonts.google.com/)

## Trade-Offs

I had one week to complete this project, so naturally there are certain features, refactoring, and tests that I'm excited to implement in the future,

Specifically:

* Refactor HTTParty calls to be outside the index, show, and search methods and live within a private method

* No Models are not used in this Rails project. One use would be if there was a User model, users could store a "Wishlist" of shows they discover and keep track of what they've watched, enjoyed, and rate those shows accordingly

Additional Movie DB API calls I would like to add in the future:

* top 100 movies, movie search

* attach reviews to movies/shows

* actor/actress bio displays, actor search

* Autocomplete functionality within search

## Installation

* [Install Rails 5](http://installrails.com/) if you do not already have it installed on your system.

In your terminal:

* `$ mkdir bingeable` creates a folder for the project

* `$ cd bingeable` to navigate into the new directory

* `$ git clone https://github.com/Neidley/Bingeable.git` to clone the project on your local system

* `$ cd bingeable` to navigate into the repository

* `$ bundle install` to install necessary dependencies. (note any errors if you need to download/update any global dependencies)

* `$ rails s` to start the server (should be localhost:3000 but see terminal response to be sure)

* navigate to `localhost:3000` in your browser

* yay! you should be running the app locally on your system : )

* Press `CTRL + C` in your terminal to stop the server

## Testing

* in your terminal, make sure you are within the project directory. if you run `$ ls` + ENTER you should see

 `
 bingeable yourname$ ls`

 `Gemfile		Rakefile	config		lib		public		 
 tmp
 Gemfile.lock	app		config.ru	log		spec		 
 vendor
 README.md	bin		db		package.json	test`

* `rspec spec/controllers/tvshows_controller_spec.rb` to run tests

## Contacts

[Andrew Neidley](neidz44@gmail.com) is the project maintainer. Feel free to contact him with questions, concerns or features you would like to see added!
