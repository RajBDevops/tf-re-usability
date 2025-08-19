provider "aws" {
  region = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {}

variable "env" {}

resource "aws_instance" "my_inst" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "${var.env}-app-server"
    Env  = var.env
  }
}
terraform {
  backend "s3" {
    bucket         = "5319my-terraform-state-bucket"
    key            = "ec2/${terraform.workspace}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
