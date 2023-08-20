#!/usr/bin/env bash

grep " 404 " $HOME/bash/apache_logs | awk ' { print $1, $6, $7 } ' > not_found.txt

