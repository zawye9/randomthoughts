#!/bin/bash
read -p 'Profile:' profile
while read p; do
  echo "$p"
  aws ec2 create-tags --resources $p --tags Key=kokoyewin,Value=testingBankingnext --profile=$profile
done <rtb.txt
