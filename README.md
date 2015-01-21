# Anymocker

[![Build Status](https://travis-ci.org/leopku/anymocker.svg?branch=master)](https://travis-ci.org/leopku/anymocker)

An API mocker, powered by [padrino](http://padrinorb.com/)

## Features

- Mock APIs of yxxpay
- Mock request and mock response of callback, notify
- Modify request, callback and notify dymanicly

## Requirement

- Ruby 2.2.0 (ruby 2.1.0+ recommended)
- Sqlite3

## Installation

```bash
bundle install
```

## Quick Start

### First Run

```bash
padrino rake db:seed
```

Fill email and password for Admin

### Start Server

```bash
padrino s
```

### View in Browser

`http://localhost:3000`

## TODO

- [x] yxxpay
- [ ] axxpay
- [x] highlight

## License

MIT
