# README

* Ruby version
2.6.5

* Configuration & Database creation/initialization
`docker-compose run --rm web rails db:create`
`docker-compose run --rm web rails db:migrate`
`docker-compose run --rm web rails db:seed`

Seed contains minimal data to start the app. To create more random data, use `docker-compose run --rm web rails c` and `FactoryBot.create :user/:workshop/:office_hour`

* How to run the test suite
`docker-compose run --rm web rspec`

* Services 
web server (access it on localhost:3000) : `docker-compose up web`
graphiql (embedded in the webserver. Access it on localhost:3000/graphiql)
worker (process async tasks via redis & sidekiq) : `docker-compose up worker`
postgres web admin (access it on localhost:8080) : `docker-compose up adminer`

To start every service available : `docker-compose up`


