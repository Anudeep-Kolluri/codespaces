module vpc {
    source = "../modules/vpc"
}


resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "my-db-subnet-group"
  description = "Database subnet group for RDS"
  subnet_ids  = [
    module.vpc.subnet_a_id,
    module.vpc.subnet_b_id
  ]

  tags = {
    Name = "my-db-subnet-group"
  }
}


resource "aws_db_instance" "postgresql" {
  # RDS instance settings
  identifier              = "my-postgresql-instance"
  engine                  = "postgres"
  engine_version          = "16.3" # Choose the PostgreSQL version
  instance_class          = "db.t3.micro" # Choose the instance class (size)
  allocated_storage       = 20 # Storage in GB
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  multi_az                = true # Enable Multi-AZ for high availability
  storage_type            = "gp2" # General Purpose SSD storage
  publicly_accessible     = true # Set to false for private access
  auto_minor_version_upgrade = true # Automatically upgrade minor versions

  # Database credentials
  username                = "postgres" # Master username
  password                = "password" # Master password (set securely)

  # Optional: Enable backup and retention
  backup_retention_period = 7 # Number of days for backups
  
  delete_automated_backups = true # Automatically delete backups after instance deletion
  skip_final_snapshot      = false # Require a final snapshot before deletion
  final_snapshot_identifier = "my-postgresql-instance-final-snapshot"


  # Tags
  tags = {
    Name = "PostgreSQL RDS Instance"
  }
}
