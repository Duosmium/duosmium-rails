# Development

This is a fairly standard Rails 6 app; views are in `app/views`, 
CSS/JS (handled by Webpacker) are in `app/javascript`, 
and controllers are in `app/controllers`.

When testing in development, run:

* `bin/rails server -e development` to start the Rails server
* `bin/webpack-dev-server` to start the Webpacker dev server (for CSS/JS)
* `bin/rails dev:cache` to enable caching for Rails (speeds up load time)