# SonarQube - Juiced
This repository contains all the necessary Terraform code to stand up a SonarQube Environment in AWS, using ECS Fargate.

Why Juiced? Because all the heavy lifting to stand up a SonarQube environment, is provided here. It's Juiced!

### The Method to the Madness
<b>Software should be clean, simple, and easy.</b> Especially for Software like platform and infrastructure code, which is needed for every project, good documentation, combined with quality code, and you can quickly have a <b>gold standard environment</b>, in minutes. On top of this, getting from zero to Hello World in complicated software environments, is often overlooked for the challenge it can be. Providing a playbook for common tasks, are the thoughts behind "Juiced" repositories such as this one.

### Instructions

Prerequisites: These instructions assume you have terraform installed, have a basic understand of AWS and terraform, and an AWS account to work in.

1. Go to AWS, and get your AWS CLI keys (or generate them if you do not have them)
  - You may need to create a user in IAM and give that user the necessary permissions
  - Once you have a user, click into the user's summary (Just click the username)
  - Create an access key for this user (There should be a button/link on the screen to do this)
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
   <br>NOTE: it may take sonarqube another few minutes to spin up, and you may need to add http:// to the front of the url. The default username and password for
         sonarqube is always admin for both

### Costs
This environment costs about $30-40 per month. You can right size components of this terraform (like the RDS instance) to reduce costs.

Additionally to save costs, you can tear the environment down at any point, with a `$ terraform destroy` if you are in the `src/` directory. When 
you need to write code again, just run `$ terraform apply`!

### Contributions
Feel free to clone or fork the repository and contribute.
<br>Or contact Wil Sprouse (wilsprouse@gmail.com) for any inquiries
