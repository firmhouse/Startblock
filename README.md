# Startblock

Startblock is the base Rails application used at
[Firmhouse](http://firmhouse.com).

## Installation

First install the startblock gem:

    $ gem install startblock

Then run:

    $ startblock projectname

this will create a Rails app in `projectname` using the latest version of Rails.

## Gemfile

To see the latest and greatest gems, look at Startblock' [Gemfile](templates/Gemfile.erb).

## Other goodies

Startblock also comes with:

* The `./bin/setup` convention for new developer setup based on the
  rails 4.2 standard.
* Rails' flashes set up and in application layout
* An automatically-created `SECRET_KEY_BASE` environment variable in all
  environments
* Mixpanel integration
* A basic README

## Dependencies

Startblock requires Ruby 2.1.5.

Some gems included in Startblock have native extensions. You should have GCC
installed on your machine before generating an app with Startblock.

Use [Command Line Tools for XCode](https://developer.apple.com/downloads/index.action)
for Lion (OS X 10.7) or Mountain Lion (OS X 10.8).

PostgreSQL needs to be installed and running for the `db:create` rake task.

## Issues

If you have problems, please create a
[GitHub Issue](https://github.com/firmhouse/startblock/issues).

## Credits

This gem is cloned from the [Suspenders][suspenders] project and formatted to
the wishes we have at Firmhouse. The main idea of this gem goes out to the amazing people at
[Thoughtbot][thoughtbot].

[thoughtbot]: http://thoughtbot.com
[suspenders]: http://github.com/thoughtbot/suspenders


## License

The original Suspenders gem is Copyright © 2008-2014 thoughtbot. It is free software, and may be
redistributed under the terms specified in the LICENSE file.
