#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <deploy|update|delete>"
    exit 1
fi
# Assign the argument to a variable
action=$1
# Define the CloudFormation template file and stack name
template_file="cloudFormation/bootstrap.yaml"
stack_name="awstfbootstrap"

# Check if the action is "deploy"
if [ "$action" == "deploy" ]; then
    echo "Deploying CloudFormation stack..."
    # Deploy the CloudFormation stack using the AWS CLI
    aws cloudformation create-stack --stack-name $stack_name --template-body file://$template_file --capabilities CAPABILITY_NAMED_IAM
    # Wait for the stack creation to complete
    aws cloudformation wait stack-create-complete --stack-name $stack_name
    echo "Stack deployment completed successfully."
# Check if the action is "delete"
elif [ "$action" == "delete" ]; then
    echo "Deleting CloudFormation stack..."
    # Delete the CloudFormation stack using the AWS CLI
    aws cloudformation delete-stack --stack-name $stack_name
    # Wait for the stack deletion to complete
    aws cloudformation wait stack-delete-complete --stack-name $stack_name
    echo "Stack deletion completed successfully."
# Check if the action is "update"
elif [ "$action" == "update" ]; then
    echo "Updating CloudFormation stack..."
    # Update the CloudFormation stack using the AWS CLI
    aws cloudformation update-stack --stack-name $stack_name --template-body file://$template_file --capabilities CAPABILITY_NAMED_IAM
    # Wait for the stack update to complete
    aws cloudformation wait stack-update-complete --stack-name $stack_name
    echo "Stack update completed successfully."
else
    echo "Invalid action. Please use 'deploy' or 'delete'."
    exit 1
fi

