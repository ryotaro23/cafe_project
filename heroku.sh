heroku login

heroku container:login

heroku create heroku-rails-helhel

heroku container:push web

heroku addons:create heroku-postgresql:hobby-dev
heroku run rails db:migrate

heroku container:release web

heroku open