#!/bin/bash

mysqlcheck -uroot  -pYOURPASS --auto-repair --check --all-databases
mysqlcheck -uroot  -pYOURPASS --auto-repair -o --all-databases

 