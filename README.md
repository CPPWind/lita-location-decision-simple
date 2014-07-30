# lita-location-decision-simple

[![Build Status](https://travis-ci.org/anithri/lita-location-decision-simple.svg?branch=master)](https://travis-ci.org/anithri/lita-location-decision-simple)
[![Code Climate](https://codeclimate.com/github/anithri/lita-location-decision-simple.png)](https://codeclimate.com/github/anithri/lita-location-decision-simple)
[![Coverage Status](https://img.shields.io/coveralls/anithri/lita-location-decision-simple.svg)](https://coveralls.io/r/anithri/lita-location-decision-simple?branch=master)


**lita-location-decision-simple** is a handler for [Lita](https://github.com/jimmycuadra/lita) that helps you make a
decision about places to go.


It is based on [lita-location-decision](https://github.com/webdestroya/lita-location-decision) which in turn is 
heavily based on the similarly named [hubot plugin](https://github.com/github/hubot-scripts/blob/master/src/scripts/location-decision-maker.coffee).

The changes were made to simplify the command syntax

## Installation

Add lita-location-decision to your Lita instance's Gemfile:

``` ruby
gem "lita-location-decision-simple"
```

## Usage

``` text
remember <location> in <group> - store a location in a group
forget <location> in <group> - forget a location in a group
wipe all in <group> - wipe all locations in a group
list all for <group> - list all locations in a group
pick from <group> - randomly pick from all locations in a group

```

## License

[MIT](http://opensource.org/licenses/MIT)
