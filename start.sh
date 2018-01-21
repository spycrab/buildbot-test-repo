#!/bin/bash
# Starts buildbot-master
cd master && buildbot start && cd .. || exit 1

