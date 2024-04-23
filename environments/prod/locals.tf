locals {
  vpc_cidr_block = {
    dev = "10.1.0.0/16"
    stage = "10.2.0.0/16"
    prod = "10.3.0.0/16"
  }
  subnet_cidr_web_public = {
    dev = ["10.1.1.0/24", "10.1.2.0/24"]
    stage = ["10.2.1.0/24", "10.2.2.0/24"]
    prod = ["10.3.1.0/24", "10.3.2.0/24"]
  }
  subnet_cidr_app_private = {
    dev = ["10.1.3.0/24", "10.1.4.0/24"]
    stage = ["10.2.3.0/24", "10.2.4.0/24"]
    prod = ["10.3.3.0/24", "10.3.4.0/24"]
  }
  subnet_cidr_data_private = {
    dev = ["10.1.5.0/24", "10.1.6.0/24"]
    stage = ["10.2.5.0/24", "10.2.6.0/24"]
    prod = ["10.3.5.0/24", "10.3.6.0/24"]
  }
  project = "doa"
}