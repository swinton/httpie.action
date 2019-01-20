#!/bin/sh

set -e

sh -c "pipenv run http $*"
