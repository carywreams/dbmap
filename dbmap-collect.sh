#!/usr/bin/env bash
sed 's/SCHEMA_NAME/'$1'/g' dbmap-raw.sql | mysql >> $1.gvData
