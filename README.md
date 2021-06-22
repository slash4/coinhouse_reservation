# README

* Ruby version
2.6.5

* Rails version
6.0.1

* Configuration & Database creation/initialization
`docker-compose run --rm web rails db:create`
`docker-compose run --rm web rails db:migrate`
`docker-compose run --rm web rails db:seed`

Seed contains minimal data to start the app. To create more random data, use rails console (see below) and type `FactoryBot.create :model_name`

* How to run the test suite
`docker-compose run --rm web rspec`

* Services 
web server (access it on localhost:3000) : `docker-compose up web`
console (aka rails command line) : `docker-compose run --rm web rails c`
graphiql (embedded in the webserver. Access it on localhost:3000/graphiql)
worker (process async tasks via redis & sidekiq) : `docker-compose up worker`
postgres web admin (access it on localhost:8080) : `docker-compose up adminer`

To start every service available : `docker-compose up`

* GraphQL samples
You can find some working samples for GraphQL queries in samples.md


