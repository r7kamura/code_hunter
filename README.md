# Code Hunter
Hunt out weak spots in your rails application with 2 static metrics tools:

* [Brakeman](https://github.com/presidentbeef/brakeman) - A static analysis security vulnerability scanner for Rails
* [RailsBestPractices](https://github.com/railsbp/rails_best_practices) - A code metric tool for rails projects

## Installation

```
$ gem install code_hunter
```

## Usage
```
$ code_hunter --help
Usage: code_hunter [options]
        --application-path=          (default:   ./) rails application root path
        --format=                    (default: yaml) output format (yaml or json)

$ code_hunter --application-path /path/to/rails/root
...
...
---
- :service: brakeman
  :line: 8
  :path: config/routes.rb
  :message: All public methods in controllers are available as actions in routes.rb
    near line 8
  :sha1: 81887a2fb6efaa9dae59425ce7537c7905516ed0
  :author: Ryo Nakamura
  :email: r7kamura@gmail.com
  :modified_at: 1357783853
- :service: rails_best_practices
  :line: 9
  :path: config/routes.rb
  :message: ! 'restrict auto-generated routes examples (only: [])'
  :sha1: 81887a2fb6efaa9dae59425ce7537c7905516ed0
  :author: Ryo Nakamura
  :email: r7kamura@gmail.com
  :modified_at: 1357783853

$ code_hunter --application-path /path/to/rails/root --format json
...
...
[{"service":"brakeman","line":8,"path":"config/routes.rb","message":"All public methods in controllers are available as actions in routes.rb near line 8","sha1":"81887a2fb6efaa9dae59425ce7537c7905516ed0","author":"Ryo Nakamura","email":"r7kamura@gmail.com","modified_at":1357783853},{"service":"rails_best_practices","line":9,"path":"config/routes.rb","message":"restrict auto-generated routes examples (only: [])","sha1":"81887a2fb6efaa9dae59425ce7537c7905516ed0","author":"Ryo Nakamura","email":"r7kamura@gmail.com","modified_at":1357783853}]
```

## Requirements
* Ruby >= 1.9
