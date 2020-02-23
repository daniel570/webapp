#!/bin/bash

curVer=$(cat helm-charts/appdb-chart/templates/deployment-webapp.yaml | cut -d "/" -f 3 | grep 1.0)

echo "$curVer" > version.txt
