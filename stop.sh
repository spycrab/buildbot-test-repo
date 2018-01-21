#!/bin/bash
# Stops buildbot-master
cd master && buildbot stop && cd .. || exit 1

