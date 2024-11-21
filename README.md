# SonarQube Juiced

### Juiced?
This project gives developers a "Juiced" start to development. So, if you are standing up SonarQube in AWS, everything you need is here!

### Instructions

Prerequisites: These instructions assume you have terraform installed, have a basic understand of AWS and terraform, and an AWS account to work in.

1. Go to AWS, and get your AWS CLI keys (or generate them if you do not have them)
  - You may need to create a user in IAM and give that user the necessary permissions
  - Once you have a user, click into the user's summary (Just click the username)
  - Create an access key for this user (There should be a button on the screen to do this)
  - Copy the Access Key and Secret Key into your environment (most likely, your local machine)
    - AWS looks for a `credentials` file at the location `~/.aws/` (so the full filepath is
      `~/.aws/credentials`). You can update the sample_aws_credentials file in the root of this
      repo, rename it to `credentials` and move it to that location
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
