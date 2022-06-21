
## Badges

[![.github/workflows/release.yaml](https://github.com/sonikro/nodejs-api-aws-terraform-gha/actions/workflows/release.yaml/badge.svg?branch=main)](https://github.com/sonikro/nodejs-api-aws-terraform-gha/actions/workflows/release.yaml)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

# nodejs-api-aws-terraform-gha

This project is a sample NodeJS API with Typescript, and is being used to demonstrate the process of developing and deploying an application to production.

## Tech Stack

**Server:** Node, Express, Typescript, Jest

**Infrastructure-as-Code**: Terragrunt, Terraform

**CI/CD**: Github Actions

**Cloud**: AWS

**Cloud Resources**: ECS, ECR, Load Balancers, VPC, Route53, Cloudwatch, IAM

## Run Locally

Clone the project

```bash
  git clone https://github.com/sonikro/nodejs-api-aws-terraform-gha.git
```

Go to the project directory

```bash
  cd nodejs-api-aws-terraform-gha
```

Install dependencies

```bash
  yarn
```

Start the server

```bash
  yarn start
```

## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

`PORT` | Default to 8080
## Running Tests

To run tests, run the following command

```bash
  yarn test
```

## API Reference

#### Get all customers
```http
  GET /customer
```

#### Create a Customer

```http
  POST /customer
  {
		"id": "1",
		"email": "some@email.com",
		"name": "Some name"
  }
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `body`      | `json` | Customer being added|

## Github Secrets 

To run this Github Actions workflow, your repository needs 2 secrets:

`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`

These secrets should be of an user that has all the necessary permissions to deploy the application to AWS


> :warning: **Deploying this to your AWS Account will incurr costs**:
