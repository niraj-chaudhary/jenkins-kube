#!/bin/bash
sed "s/tagVersion/$1/g" pods.yml > python-app-pod.yml
