#!/usr/bin/env python3

import os
from urllib.request import urlopen
from os.path import expanduser
import xml.etree.ElementTree as et

url = os.environ['U']
loc = os.environ['L']
db = os.environ['D']

file = open(db, 'r')
existing = file.readlines()
file.close()

resp = urlopen(url)
feed = resp.read().decode('latin-1')
resp.close()

root = et.fromstring(feed)

for item in root[0].findall('item'):
    url = item.find('link').text
    name = url.split('/')[-1]

    if name + '\n' in existing:
        continue

    resp = urlopen(url)
    torrent = resp.read()
    resp.close()

    file = open(loc + '/' + name, "wb")
    file.write(torrent)
    file.close()

    file = open(db, 'a')
    file.write(name + '\n')
    file.close()
