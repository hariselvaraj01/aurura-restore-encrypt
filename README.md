# Aurora MySQL Restore & Column Encryption Pipeline

This project automates the process of:

1. Restoring an AWS Aurora MySQL cluster from a snapshot
2. Spinning up a new instance
3. Dynamically encrypting selected column(s) in a table using a stored procedure

> Ideal for engineers, DBAs, or DevOps teams who want to replicate production data securely for staging, dev, or analytics.

---

## Features

- **Terraform-based provisioning** of Aurora MySQL from a snapshot
- Dynamic MySQL stored procedure for column-level encryption
- Support for encrypting **multiple columns** in one call
- Simple Bash script for post-restore column encryption
- Ready-to-use structure for cloning or extending

---

## Prerequisites

- AWS CLI configured with appropriate RDS permissions
- Terraform installed (`brew install terraform`)
- MySQL client installed (`brew install mysql`)
- Access to an Aurora MySQL snapshot

---

## Setup Guide

### 1. Clone the Repository

```bash
git clone git@github.com:yourusername/aurora-restore-encrypt.git
cd aurora-restore-encrypt
```

---

### 2. Configure Terraform

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values:
# - AWS region
# - Snapshot identifier
# - Cluster & DB name
# - Admin username/password
```

---

### 3. Deploy Aurora MySQL Cluster

```bash
terraform init
terraform apply
```

After deployment, note the `db_cluster_endpoint` shown in Terraform output.

---

### 4. Run Column Encryption

```bash
cd ../scripts
chmod +x run_encryption.sh

./run_encryption.sh <db-host> <db-name> <db-user> <db-pass> <table-name> <columns> <encryption-key>
```

**Example:**

```bash
./run_encryption.sh mycluster.cluster-xyz.us-east-1.rds.amazonaws.com mydb admin YourPassword123 users "email,password" mysecretkey
```

This will encrypt the `email` and `password` columns in the `users` table.

---

## File Structure


aurora-restore-encrypt/
├── terraform/
│   ├── main.tf                 # RDS cluster and instance definition
│   ├── variables.tf            # Input variable definitions
│   ├── terraform.tfvars.example  # Example input values
├── scripts/
│   ├── run_encryption.sh       # Bash script to trigger encryption
│   └── encrypt_column_proc.sql # MySQL procedure to encrypt columns
├── README.md
└── LICENSE (MIT)---

## Notes

- Encryption uses `AES_ENCRYPT()` and `TO_BASE64()` â ensure columns are `VARCHAR` or `TEXT`
- Column names are passed as a comma-separated list
- For better security, store passwords in environment variables or use AWS Secrets Manager

---

## License

This project is licensed under the [MIT License](LICENSE).

---

## Future Enhancements

- Automatic detection of latest snapshot
- Support for column **decryption**
- GitHub Actions CI/CD pipeline for Terraform

---

## Contributing

Contributions welcome! Feel free to open issues or submit PRs.
