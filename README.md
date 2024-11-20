# SonarQube Juiced

### Juiced?
This project gives developers a "Juiced" start to development, if they are standing up SonarQube in AWS. Everything needed is here.


### Instructions

1. Get your AWS CLI keys
  - Create a user in IAM
  - Give it the necessary permissions
  - Click the user you created
  - Create an access key for this user (There should be a button on the screen to do this)
  - AWS looks for a credentials file at the location `~/.aws/credentials`. You can update 
    the sample_aws_credentials file in this repo, and move it to that location
2. cd into src/ directory
3. run `$ terraform plan`
4. run `$ terraform apply`
