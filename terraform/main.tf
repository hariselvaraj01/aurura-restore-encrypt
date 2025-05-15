provider "aws" {
  region = var.region
}

resource "aws_rds_cluster" "aurora_restore" {
  cluster_identifier      = var.restore_db_instance_identifier
  engine                  = "aurora-mysql"
  engine_mode             = "provisioned"
  snapshot_identifier     = var.snapshot_identifier
  database_name           = var.db_name
  master_username         = var.db_user
  master_password         = var.db_password
  skip_final_snapshot     = true
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  identifier              = "${var.restore_db_instance_identifier}-instance"
  cluster_identifier      = aws_rds_cluster.aurora_restore.id
  instance_class          = "db.r6g.large"
  engine                  = "aurora-mysql"
  publicly_accessible     = true
}
