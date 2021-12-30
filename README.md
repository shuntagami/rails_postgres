# shuntagami/rails_postgres

This is a dockerized Rails6 application template.

## keywords

- Database: **PostgreSQL**
- Test: **Rspec**
- CI: **Github Actions**
- Webpacker (Asset Pipeline/Sprockets is disabled)
- OpenAPI
- API schema test: **committee-rails**

## How to use

### Development build by docker-compose

```bash
$ make all
```

### FYI: Development build without docker-compose

```bash
$ docker network create rails-network # Create a network of rails-network
$ docker build -t postgres docker/postgres/. # Buiid a postgres image.
$ docker run --name postgres --net rails-network -d --env-file ./docker/postgres/.env -v db-data:/var/lib/postgresql/data postgres # Run a postgres image with a specific network and env-file.
$ docker build --target development -t my-api . # Build a rails-app image of my-api.
$ docker run --rm --name rails_postgres --env-file .env --net rails-network -d -p 3000:3000 -v $(pwd):/opt/app my-api # Run a rails-app image with a specific network and env-file.
```

### Health check

```bash
$ curl localhost:3000/api/_healthcheck
{"message":"OK"}
```

### Production build

```bash
$ make image.build # build docker image for production.
$ make image.push # push to docker registry.
```

You can pull my image from docker hub.

- https://hub.docker.com/repository/docker/shuntagami/rails_postgres
