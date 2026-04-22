#!/bin/bash

count=0
while [ $count -lt 2 ]; do
  echo "Hello stranger"
  sleep 2
  ((count++))
done
