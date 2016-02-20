#!/usr/bin/python3
# -*- coding: utf-8 -*-
import os
import re
from glob import glob

from requests import head


def main():
    url = 'https://plex.tv/downloads/latest/1'
    url = head(
        url,
        params={
            'channel': '8',
            'build': 'linux-ubuntu-x86_64',
            'distro': 'ubuntu',
            'X-Plex-Token': 'MeExhsuHRt8ioCdztwN2'},
        allow_redirects=True).url
    match = re.search(r'plexmediaserver_([\d|.]+)-([\da-f]+)_amd64.deb', url)
    path = '/usr/overlay/media-tv/plex-media-server/'
    old = glob(path + '*.ebuild')[0]
    new = re.sub(r'[\d|.]+(?<!\.)', match.group(1), old)
    if old == new:
        return
    print("New plex version: %s" % match.group(1))
    input_lines = None
    with open(old, 'r') as infile:
        input_lines = infile.readlines()
    with open(new, 'w') as output:
        for line in input_lines:
            if re.match('MY_REV', line):
                output.write('MY_REV="%s"\n' % match.group(2))
            else:
                output.write(line)
    os.remove(old)

if __name__ == '__main__':
    main()
