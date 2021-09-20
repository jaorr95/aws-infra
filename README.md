# aws-infra
Repo for infrastructure automation in aws

## Instructions to run test locally

### Requirements

* terraform => v0.13.5
* go => 1.16

### Steps

* Set up aws credentials
    * `export AWS_SECRET_ACCESS_KEY=value`
    * `export AWS_ACCESS_KEY_ID=value`
* Go to test directory
    * `cd test`
* Install modules
    * `go mod download`
* Execute tests
    * `go test -v`
