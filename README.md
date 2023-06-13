# Cardo DevOps Technical Test - Alberto Ayllon

#### Assumption

The code within this repository creates the necessary infrastructure to run a simple static web site, it also
uploads the html and assets files to the web server.

## Technical stack

This solution is based on AWS cloud provider. As storage for web content two S3 bucket are used, one for html files and
one more for assets (images in this case). As content delivery network CloudFront is used with a very basic configuration.

Bucket content is encrypted using AWS managed keys and it content in only available through the CDN.
The CDN is configured to serve request in the address https://web.mycardo.com

To create the infrastructure and upload the web content Terraform has been used. 

#### Terraform modules

The following modules has been created:
- s3-bucket: Creates the s3 buckets to store html and assets files.
- ssl-certificate: Creates the certificate for the domain name web.mycardo.com
- static-website: mainly creates the CloudFront distribution with two origins one for html files and one more for the assets.
- deploy-web: configuration to copy website files to S3 buckets.


- tf-remote-state: Is not directly related with the project, but it contains the necessary configuration to create and S3 bucket and a Dynamodb table to do remote state tracking

## Deployment

#### Clone the git repository: 

`git clone git@github.com:aayllon/my-cardo-test.git`

#### Crete the remote tracking state infrastructure:

`cd tf-remote-state`

`terraform init`

`terraform apply`

#### Deploy staging environment

`cd ../`

`cd staging`

`terraform init`

`terraform apply`

## Reflection  

I have tried to do the best I could with this test, but I know there are many things in it than can be done much better, some of them are:

- Not to use aws cli command to copy files to s3 bucket.
- Better implementation of the different environment
- In some cases I know that I broke the DRY principle, for example in the s3 buckets creation.
- Use user managed keys to encrypt s3 content instead the ones managed by AWS.
- Use versioned modules


