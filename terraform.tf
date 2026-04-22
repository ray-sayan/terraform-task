terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.40.0"
    }
  }
  backend "s3" {
    bucket         = "sayan-terraform-state-12345"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    use_lockfile   = true   # ✅ NEW locking 
    encrypt        = true
  }
}
