# README

## APIs I could integrate with

- http://colormind.io/ 

## Nice JS libaries

- http://bebraw.github.io/colorjoe/

## Setup AWS

    eb create -d -db.engine postgres  -db.size 5 --database.instance db.t2.micro --envvars SECRET_KEY_BASE=`rake secret`,ASSET_HOST=https://cdn.styleguide-o-matic.mikerogers.io/,CSS_HOST=cdn.styleguide-o-matic.mikerogers.io,EARLY_HINTS=true,LANG=en_US.UTF-8

## Deploying to AWS

    eb deploy
