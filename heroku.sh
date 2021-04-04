heroku login

heroku container:login

heroku create heroku-rails-helhel

# ~~~~~~~~表示されなかったらここから~~~~~~~~
heroku container:push web

heroku container:release web

# ~~~~~~~~~~~~~ここまで実行する~~~~~~~~~~~~

heroku addons:create heroku-postgresql:hobby-dev

heroku run rails db:migrate

# 初期データの投入にはRAILS_ENVを指定してやる必要がある
# heroku run RAILS_ENV=test rails db:seed

# precompile
heroku run rake assets:precompile RAILS_ENV=production

heroku open


# Error R14 (Memory quota exceeded)
# heroku config:set WEB_CONCURRENCY=1
# heroku restart
