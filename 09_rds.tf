resource "aws_db_subnet_group" "Final_rds_subnet_group" {
  name       = "final-rds-subnet-group"
  subnet_ids = aws_subnet.Final_db_subnet.*.id
  depends_on = [
    aws_subnet.Final_db_subnet
  ]
}

resource "aws_db_instance" "Final_rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0.20"
  instance_class       = "db.t3.micro"
  name                 = "petclinic"
  username               = "petclinic"
  password               = "petclinic"

  db_subnet_group_name = aws_db_subnet_group.Final_rds_subnet_group.id

  vpc_security_group_ids = [aws_security_group.Final_db_sg.id]
  skip_final_snapshot    = true
  tags                   = {
    Name = "Final-rds"
  }
}