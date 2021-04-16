resource "aws_security_group" "SecurityGroup_RDS" {
  name = "IB07441-SecurityGroup-RDS"
  description = "Security group for IB07441 instance"
  vpc_id = aws_vpc.VPC.id

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "IB07441-SecurityGroup"
  }
}

resource "aws_db_subnet_group" "DB_Subnet_Group" {
  name       = "ib07441-db-subnet-group"
  subnet_ids = [
    aws_subnet.publicSubnet01.id,
    aws_subnet.publicSubnet02.id,
    aws_subnet.publicSubnet03.id
  ]

  tags = {
    Name = "FS07441-DBSubnetGroup"
  }
}

resource "aws_db_instance" "DB_Instance" {
  allocated_storage    = 5
  engine               = "postgress"
  engine_version       = "9.6.2"
  instance_class       = "db.t2.micro"
  name                 = "ib07441-invoicer"
  username             = "admin"
  password             = "password"
  vpc_security_group_ids = [aws_security_group.SecurityGroup_RDS.id]
  db_subnet_group_name = aws_db_subnet_group.DB_Subnet_Group.id
  publicly_accessible  = true
  port                 = 5432
  identifier = "ib07441-invoicer-identifier"
  final_snapshot_identifier = "id07441-invoicer-snapshot-identifier"
  skip_final_snapshot  = true
  auto_minor_version_upgrade = true
  multi_az = false
}