# Bootstrap-O-Matic

Use [http://colormind.io/](http://colormind.io/) & [http://bebraw.github.io/colorjoe/](http://bebraw.github.io/colorjoe/), to generate Bootstrap 4 configurations.

<img width="1440" alt="image" src="https://user-images.githubusercontent.com/325384/120947012-06094700-c704-11eb-9e9b-c3b8b6bc15e1.png">


## Setup & Running Locally

Clone down the repo, install [Docker](https://hub.docker.com/editions/community/docker-ce-desktop-mac/) & run:

```bash
$ docker-compose build
$ docker-compose run --rm web bin/setup
$ docker-compose up
```

This will build the docker image, then setup the `bin/setup` file which will run `bundle`, `yarn` & create the database.

Then navigate your browser to https://127.0.0.1:3000/ to see your site.

### Running one of commands

To run a one off command, run it within the web service, e.g:

```bash
$ docker-compose run --rm web rails db:migrate
```

### Restoring a database

If you have an existing database dump in a file called `latest.dump`, you can restore it by turning on just the postgres service in one terminal tab, and running `pg_restore` in a secondary tab:

```bash
$ docker-compose up postgres
$ pg_restore --verbose --clean --no-acl --no-owner -j 2 -h localhost -d App_development --username postgres latest.dump
```

## Tests

The template comes preconfigured with [RSpec](https://rspec.info/) for tests, and comes with a [GitHub Action](https://github.com/Ruby-Starter-Kits/Docker-Rails-Template/blob/master/.github/workflows/tests.yml) to run them when you push to GitHub.

You can run RSpec locally by running:

```bash
$ docker-compose -f docker-compose.ci.yml run --rm test
```

## Linting

This app uses [Standard](https://github.com/testdouble/standard) for Ruby and includes a [GitHub Action](https://github.com/Ruby-Starter-Kits/Docker-Rails-Template/blob/master/.github/workflows/standard.yml) to check future commits are up to standard.

## Usage

Feel free to use these as a starting point for your own Ruby on Rails project!

## Resources

* [Ruby on Rails Guides](https://guides.rubyonrails.org/)
* [Ruby on Rails API Documentation](https://api.rubyonrails.org/)
* [Heroku](https://www.heroku.com/)
* [Docker-Rails-Generator](https://github.com/Ruby-Starter-Kits/Docker-Rails-Generator)

## License

[MIT](https://opensource.org/licenses/MIT)

Copyright (c) 2020-present, [Mike Rogers](https://mikerogers.io/)
