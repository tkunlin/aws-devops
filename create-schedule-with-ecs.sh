#!/bin/bash
## This script can use awscli to create aws scheduler 

# disable expansion to get the parameter from command line, like cron fomrat (0 12 ? * * *))
set -f 


SCHEDULE_NAME=$1
CRON_TIME=$2
TASK_DEFINITION_NAME=$3
echo $SCHEDULE_NAME
echo $CRON_TIME
echo "--schedule-expression 'cron($CRON_TIME)'"
echo $TASK_DEFINITION_NAME

# aws scheduler create-schedule --name $schedule_name --schedule-expression 'cron(15 19 * * ? *)'  --schedule-expression-timezone Asia/Taipei --target '{"Arn": "arn:aws:ecs:us-west-2:111111111111:cluster/billing-uat-job","EcsParameters": {"EnableECSManagedTags": true,"EnableExecuteCommand": false,"LaunchType": "FARGATE","NetworkConfiguration": {"awsvpcConfiguration": {"AssignPublicIp": "DISABLED","SecurityGroups": ["sg-052031cd3d90057b9"],"Subnets": ["subnet-0a8cd931897f61be9","subnet-0e3bfe4f24cdd9a79"]}},"TaskCount": 1,"TaskDefinitionArn": "arn:aws:ecs:us-west-2:111111111111:task-definition/billing_uat_cur_parquet_td"}, "RoleArn": "arn:aws:iam::863203846708:role/billing-eventbridge-scheduler-ecs-role" }' --flexible-time-window '{ "Mode": "OFF"}'



aws scheduler create-schedule --name $SCHEDULE_NAME --schedule-expression "cron($CRON_TIME)"  --schedule-expression-timezone Asia/Taipei --target '{"Arn": "arn:aws:ecs:us-west-2:111111111111:cluster/billing-uat-job","EcsParameters": {"EnableECSManagedTags": true,"EnableExecuteCommand": false,"LaunchType": "FARGATE","NetworkConfiguration": {"awsvpcConfiguration": {"AssignPublicIp": "DISABLED","SecurityGroups": ["sg-052031cd3d90057b9"],"Subnets": ["subnet-0a8cd931897f61be9","subnet-0e3bfe4f24cdd9a79"]}},"TaskCount": 1,"TaskDefinitionArn": "arn:aws:ecs:us-west-2:111111111111:task-definition/'$TASK_DEFINITION_NAME'"}, "RoleArn": "arn:aws:iam::863203846708:role/billing-eventbridge-scheduler-ecs-role" }' --flexible-time-window '{ "Mode": "OFF"}'

# Enable expansion to get the parameter from command line, like cron fomrat (0 12 ? * * *))
set +f 
