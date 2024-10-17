terraform {
  backend "s3" {
    region  = "us-east-2"
    bucket  = "ru-ab-terraform-state-s3"
    key     = "task_3.tfstate"
    encrypt = true
  }
}
