#!/bin/bash
apt-get update -y
apt-get install -y r-base gdebi-core libcurl4-openssl-dev libssl-dev libxml2-dev

wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-latest-amd64.deb
gdebi --non-interactive rstudio-server-latest-amd64.deb

Rscript ~/sales-analytics/R/scripts/deploy/aws_setup.R
(crontab ~/sales-analytics/deploy/cron/crontab.txt)
