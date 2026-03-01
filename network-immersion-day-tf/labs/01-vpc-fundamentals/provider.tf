terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      # Tags de Negócio
      Company      = "AcmeCorporation"
      BusinessUnit = "technology"
      CostCenter   = "eng-001"

      # Tags Técnicas
      Environment = var.environment
      ManagedBy   = "terraform"
      Repository  = "github.com/acme/network-immersion-day-tf"

      # Tags de Responsabilidade
      Owner     = "team-cloud@acme.com"
      Developer = "platform-team"
      Manager   = "tech-lead@acme.com"
    }
  }
}
