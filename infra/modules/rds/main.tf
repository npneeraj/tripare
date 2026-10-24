data "aws_ssm_parameter" "db_password" {
  name            = "/${var.env}/rds/db_password"
  with_decryption = true
}

resource "aws_security_group" "rds" {
  name        = "${var.env}-rds-sg"
  description = "Allow DB traffic from ECS"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ecs_sg_id]
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.env}-rds-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "postgres" {
  identifier           = "${var.env}-db"
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "15.4"
  instance_class       = var.db_instance_class
  db_name              = "appdb"
  username             = "dbadmin"
  password             = data.aws_ssm_parameter.db_password.value
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot  = true
  publicly_accessible  = false

  backup_retention_period = var.backup_retention_period
  deletion_protection     = var.deletion_protection
}