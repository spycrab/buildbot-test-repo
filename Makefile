# Makefile for setting up / maintaining buildbot

### OPTIONS

# Buildbot
BUILDBOT_MASTER_DEPENDENCIES=buildbot buildbot-www buildbot-grid-view buildbot-console-view buildbot-waterfall-view
BUILDBOT_WORKER_DEPENDENCIES=buildbot-worker

# pip
PIP_OPTIONS=--user --quiet


### Targets


deps: worker_deps master_deps

master_deps:
	pip install ${BUILDBOT_MASTER_DEPENDENCIES} ${PIP_OPTIONS}

worker_deps:
	pip install ${BUILDBOT_WORKER_DEPENDENCIES} ${PIP_OPTIONS}

# Common commands
start:
	cd master && buildbot start
stop:
	cd master && buildbot stop
restart:
	cd master && buildbot restart

init: deps
	buildbot upgrade-master master

create-workers:
	python tools/create-workers.py

.PHONY: deps master_deps worker_deps start stop restart init
