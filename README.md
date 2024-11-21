# SonarQube Juiced

### Juiced?
This project gives developers a "Juiced" start to development, if they are standing up SonarQube in AWS. Everything needed is here.

### Instructions

0. These instructions assume you have terraform installed, have a basic understand of AWS, and an AWS account to work in.

1. Go to AWS, and get your AWS CLI keys
  - You may need to create a user in IAM, otherwise skip to "Create an access key..." (Step 4)
  - Give it the necessary permissions
  - Click the user you created
  - Create an access key for this user (There should be a button on the screen to do this)
  - AWS looks for a credentials file at the location `~/.aws/credentials`. You can update 
    the sample_aws_credentials file in this repo, and move it to that location
2. Depending on how you want to store your state, you may need to update `src/backend.tf`. 
   By default, it is set up for local state storage.
3. cd into src/ directory
4. run `$ terraform init`
5. run `$ terraform plan`
  - If this output is what you are expecting (ie, no errors, and the number of resources to be deployed looks correct), you are good to move on to the next step
6. run `$ terraform apply`. This will take 5-10 minutes, and it will output the dns name for you to use to access SonarQube
   NOTE: it may take sonarqube another few minutes to spin up, and you may need to add http:// to the front of the url. Your starting username and password for
         sonarqube is always admin and admin

### Costs
This environment costs about $30-40 per month. You can right size components of this terraform (like the RDS instance) to reduce costs.

Additionally, you can tear the environment down with a `$ terraform destory` if you are in the `src/` directory
