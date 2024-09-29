terraform {
  backend "s3" {
    region  = "us-east-2"
    bucket  = "ru-ab-terraform-state-s3"
    key     = "terraform.tfstate"
    encrypt = false
  }
}

resource "aws_s3_bucket" "terraform_state_s3" {
  bucket = "ru-ab-terraform-state-s3"

  tags = {
    name = "TerraformState"
  }
}
