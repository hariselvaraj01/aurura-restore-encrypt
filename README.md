# Aurora MySQL Restore & Encrypt Pipeline

This project automates the process of:
1. Restoring an AWS Aurora MySQL database from a snapshot
2. Running a dynamic encryption procedure on selected table columns

## Usage

- Customize `terraform.tfvars` with your parameters
- Run `terraform apply`
- Execute `scripts/run_encryption.sh` with DB parameters
