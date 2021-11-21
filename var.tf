#vpc
variable "region" {
  description = "seoul"
  default = "ap-northeast-2"
}

variable "vpc_cidr" {
  description = "Final-vpc cidr"
  default = "10.0.0.0/16"
}

variable "vpc" {
  description = "Final-vpc"
  default = "aws_vpc.Final_vpc"
}

variable "vpc_id" {
  description = "Final-vpc ID"
  default = "aws_vpc.Final_vpc.id"
}

# subnet
variable "Final_mgmt_subnet" {
  description = "Final-mgmt-subnet"
  default = "10.0.0.0/27"
}

variable "Final_pub_subnet" {
  description = "Final-pub-subnet"
  default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "Final_web_subnet" {
  description = "Final-web-subnet"
  default = ["10.0.3.0/24","10.0.4.0/24"]
}

variable "Final_was_subnet" {
  description = "Final-was-subnet"
  default = ["10.0.5.0/24","10.0.6.0/24"]
}

variable "Final_db_subnet" {
  description = "Final-db-subnet"
  default = ["10.0.7.0/27","10.0.7.32/27"]
}

variable "zone" {
  description = "AZ"
  default = ["a","c"]
}

# RT
variable "cidr_block" {
  description = "All IP"
  default = "0.0.0.0/0"
}

variable "ipv6_cidr_blocks" {
  description = "All IPv6"
  default = "::/0"
}

# instance
variable "ami" {
  description = "ami"
  default = "ami-0252a84eb1d66c2a0"
}

variable "key_pair" {
  description = "key_pair"
  default = "final-key"
}