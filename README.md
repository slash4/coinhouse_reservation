# README

* Ruby version
2.6.5

* Configuration & Database creation/initialization
docker-compose run --rm web rails db:create
docker-compose run --rm web rails db:migrate
docker-compose run --rm web rails db:seed

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)
web server (access it on localhost:3000) : `docker-compose up web`
worker (process async tasks via redis & sidekiq) : `docker-compose up worker`
postgres web admin (access it on localhost:8080) : `docker-compose up adminer`
graphiql (started with web server. Access it on localhost:3000/graphiql)

To start every service available : `docker-compose up`


