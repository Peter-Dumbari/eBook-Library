#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
# DISABLE_DATABASE_ENVIRONMENT_CHECK=1 RAILS_ENV=production rails db:reset
bundle exec rake db:migrate