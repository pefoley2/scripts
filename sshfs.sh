#!/bin/bash
sshfs -o follow_symlinks,reconnect grace: `dirname $0`/grace
