resource "aws_eip" "Final-mgmt-eip"{
  count                = 1
  instance             = aws_instance.Final_mgmt[count.index].id
  vpc                  = true
}

# instance
resource "aws_instance" "Final_mgmt" {
  count                  = 1
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.Final_mgmt_sg.id]
  availability_zone      = "ap-northeast-2a"
  private_ip             = null
  subnet_id              = aws_subnet.Final_mgmt_subnet.id
  tags = {
    Name                 = "Final-mgmt"
    }
}

resource "aws_instance" "Final_web" {
  count                  = length(var.zone)
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.Final_web_sg.id]
  availability_zone      = "${var.region}${var.zone[count.index]}"
  private_ip             = null
  subnet_id              = aws_subnet.Final_web_subnet[count.index].id
  tags = {
    Name                 = "Final-web-${var.zone[count.index]}"
    }
}

resource "aws_instance" "Final_was" {
  count                  = length(var.zone)
  ami                    = var.ami
  instance_type          = "t2.large"
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.Final_was_sg.id]
  availability_zone      = "${var.region}${var.zone[count.index]}"
  private_ip             = null
  subnet_id              = aws_subnet.Final_was_subnet[count.index].id
  tags = {
    Name                 = "Final-was-${var.zone[count.index]}"
    }
}