# Sentry on Docker Compose

This is a production ready setup of
[Sentry](https://github.com/getsentry/sentry) with Postgres and Redis using
[Docker Compose](https://github.com/docker/fig). Originally created by [Turistforeningen](https://github.com/Turistforeningen/sentry), updated to be more flexible and updated for newest version of Sentry.

![Docker Compose container overview](https://docs.google.com/drawings/d/1OB0R9QUec7hytx73EYHJcmLzj2m6bMNWnNv-nePAg24/pub?w=766&h=216)

## What are the requirements?

* [Docker](https://github.com/docker/docker) >= `v1.3`
* [Docker Compose](https://github.com/docker/fig) >= `v1.1.0-rc2`


## Configuration

The `sentry.conf.py` and `config.yml` holds all the Sentry configurations. Your secret stuff,
however, has to be put into an environment file called `environment.sh` in a `secrets/` folder (which is ignored by .gitignore). Mainly, you need

* SECRET_KEY

for sentry. Fill in email config knobs in config.yml, and update SENTRY_URL_PREFIX in `sentry.conf.py`.


## Building

The compose file relies on an image named `sentry_image`, and to build it, run:

```
sudo docker build --rm=true -t sentry_image ./
```


## Installation

First, lets bring up the stack via compose:

```
docker-compose up -d
```

After that, run SQL migrations to get the database up and running. This will also ask you to create a user; at this point, create one user that has admin privileges.

```
sudo docker-compose run www upgrade
```

If you later want to add more users or didn't did it the first time around, run:

```
docker-compose run www createuser
```


## Troubleshooting

To see logs, you can run:

```
sudo docker-compose logs -f sentry
sudo docker-compose logs -f sentry_celery_beat
sudo docker-compose logs -f sentry_celery_worker
```

to see the logs of the varous sentry components.


## TODO

* Dockerize the www container to wait for postgres db to be up and running
* Deal with C_FORCE_ROOT=true, which is warned against

## [MIT Licensed](https://github.com/Turistforeningen/sentry/blob/master/LICENSE)

