#!/bin/bash

echo "Building and pushing docker image to ECR"

docker build . -t demo --platform linux/amd64
docker tag demo:latest 061379176831.dkr.ecr.eu-west-1.amazonaws.com/demo:latest
docker push 061379176831.dkr.ecr.eu-west-1.amazonaws.com/demo:latest

echo "Deploying to AWS using serverless"

serverless deploy