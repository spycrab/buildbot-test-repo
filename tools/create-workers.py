# Licensed under a MIT License
# See LICENSE
# (c) spycrab, 2017

import os
import json

CONFIG = json.load(open('config.json'))
WORKERS = json.load(open('workers.json'))
WORKER_PASSWORDS = json.load(open('worker-passwords.json'))

for worker in WORKERS:
    worker_dir = '{}-worker'.format(worker)
    print('----- Creating worker {}...'.format(worker))
    print('-- Initializing...')
    os.spawnvp(os.P_WAIT, 'buildbot-worker', ['','create-worker', worker_dir, CONFIG['MASTER_ADDRESS'], worker, WORKER_PASSWORDS[worker]])
    print('-- Setting information...')
    admin_file = open('{}/info/admin'.format(worker_dir), 'w')
    description_file = open('{}/info/description'.format(worker_dir), 'w')
    host_file = open('{}/info/host'.format(worker_dir), 'w')

    admin = WORKERS[worker]['admin']
    description = WORKERS[worker]['description']
    host = WORKERS[worker]['host']
    
    print(admin, file=admin_file)
    print(description, file=description_file)
    print(host, file=description_file)

    print('Admin:', admin)
    print('Description:', description)
    print('Host Description:', host)

    print('-- Packaging {}...'.format(worker_dir)) 
    os.spawnvp(os.P_WAIT, 'tar', ['', '-czf', '{}.tar.gz'.format(worker_dir), worker_dir])

    print('-- Cleaning up...')
    os.spawnvp(os.P_WAIT, 'rm', ['', '-r', worker_dir])

    print('=====> Created {}.tar.gz'.format(worker_dir))
