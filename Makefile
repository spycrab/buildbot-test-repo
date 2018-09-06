# Makefile for setting up / maintaining buildbot

### OPTIONS

# Buildbot
BUILDBOT_MASTER_DEPENDENCIES=buildbot buildbot-www buildbot-grid-view buildbot-console-view buildbot-waterfall-view
BUILDBOT_WORKER_DEPENDENCIES=buildbot-worker

# pip
PIP_OPTIONS=--user --quiet

# Python executables
PYTHON=python3
PIP=pip3


### Targets

all: help

deps: worker_deps master_deps

master_deps:
	${PIP} install ${BUILDBOT_MASTER_DEPENDENCIES} ${PIP_OPTIONS}

worker_deps:
	${PIP} install ${BUILDBOT_WORKER_DEPENDENCIES} ${PIP_OPTIONS}

# Common commands
start:
	cd master && buildbot start
stop:
	cd master && buildbot stop
restart:
	cd master && buildbot restart

worker-passwords.json:
	@echo "ERROR: You have to create a valid worker-passwords.json before you can run this command"
	@false

init: worker-passwords.json deps
	buildbot upgrade-master master

create-workers: worker-passwords.json
	python3 tools/create-workers.py

clean:
	rm -vf *.tar.gz

help:
	@echo "make help - Shows this"
	@echo "make init - Sets up a buildbot server and its dependencies"
	@echo "     make worker_deps - Only install dependencies for workers"
	@echo "make create-workers - Creates worker-NAME.tar.gz archives for you to deploy"
	@echo "make clean - Remove worker archives"
	@echo "make start - Starts the server"
	@echo "make stop - Stops the server"
	@echo "make restart - Restarts the server"

.PHONY: deps master_deps worker_deps start stop restart init clean help all
