terraform {
  required_version = ">= 1.2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }
  }

  cloud {
    organization = "wts"

    workspaces {
      name = "wts-public-gateway-tf"
    }
  }
}

provider "aws" {
  region = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

# aws reference architecture https://docs.aws.amazon.com/quickstart/latest/vpc/architecture.html

resource "aws_vpc" "wts" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "WTS"
  }
}

resource "aws_internet_gateway" "wts" {
  vpc_id = aws_vpc.wts.id

  tags = {
    Name = "WTS"
  }
}

# public subnets

resource "aws_subnet" "public_az1" {
  vpc_id = aws_vpc.wts.id
  availability_zone_id = "use1-az1"
  cidr_block = "10.0.128.0/20"
  map_public_ip_on_launch = true

  tags = {
    Name = "WTS"
  }
}

resource "aws_subnet" "public_az2" {
  vpc_id = aws_vpc.wts.id
  availability_zone_id = "use1-az2"
  cidr_block = "10.0.144.0/20"
  map_public_ip_on_launch = true

  tags = {
    Name = "WTS"
  }
}

resource "aws_subnet" "public_az3" {
  vpc_id = aws_vpc.wts.id
  availability_zone_id = "use1-az3"
  cidr_block = "10.0.160.0/20"
  map_public_ip_on_launch = true

  tags = {
    Name = "WTS"
  }
}

resource "aws_subnet" "public_az4" {
  vpc_id = aws_vpc.wts.id
  availability_zone_id = "use1-az4"
  cidr_block = "10.0.176.0/20"
  map_public_ip_on_launch = true

  tags = {
    Name = "WTS"
  }
}

# private subnets

resource "aws_subnet" "private_az1" {
  vpc_id = aws_vpc.wts.id
  availability_zone_id = "use1-az1"
  cidr_block = "10.0.0.0/19"

  tags = {
    Name = "WTS"
  }
}

resource "aws_subnet" "private_az2" {
  vpc_id = aws_vpc.wts.id
  availability_zone_id = "use1-az2"
  cidr_block = "10.0.32.0/19"

  tags = {
    Name = "WTS"
  }
}

resource "aws_subnet" "private_az3" {
  vpc_id = aws_vpc.wts.id
  availability_zone_id = "use1-az3"
  cidr_block = "10.0.64.0/19"

  tags = {
    Name = "WTS"
  }
}

resource "aws_subnet" "private_az4" {
  vpc_id = aws_vpc.wts.id
  availability_zone_id = "use1-az4"
  cidr_block = "10.0.96.0/19"

  tags = {
    Name = "WTS"
  }
}

# nat gateway eips

# resource "aws_eip" "nat_gateway_az1" {
#   vpc = true

#   tags = {
#     Name = "WTS"
#   }
# }

# resource "aws_eip" "nat_gateway_az2" {
#   vpc = true

#   tags = {
#     Name = "WTS"
#   }
# }

# resource "aws_eip" "nat_gateway_az3" {
#   vpc = true

#   tags = {
#     Name = "WTS"
#   }
# }

# resource "aws_eip" "nat_gateway_az4" {
#   vpc = true

#   tags = {
#     Name = "WTS"
#   }
# }

# nat gateways

# resource "aws_nat_gateway" "az1" {
#   allocation_id = aws_eip.nat_gateway_az1.id
#   subnet_id = aws_subnet.public_az1.id

#   tags = {
#     Name = "WTS"
#   }
# }

# resource "aws_nat_gateway" "az2" {
#   allocation_id = aws_eip.nat_gateway_az2.id
#   subnet_id = aws_subnet.public_az2.id

#   tags = {
#     Name = "WTS"
#   }
# }

# resource "aws_nat_gateway" "az3" {
#   allocation_id = aws_eip.nat_gateway_az3.id
#   subnet_id = aws_subnet.public_az3.id

#   tags = {
#     Name = "WTS"
#   }
# }

# resource "aws_nat_gateway" "az4" {
#   allocation_id = aws_eip.nat_gateway_az4.id
#   subnet_id = aws_subnet.public_az4.id

#   tags = {
#     Name = "WTS"
#   }
# }

# public route tables

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.wts.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wts.id
  }

  tags = {
    Name = "WTS"
  }
}

# private route tables

# resource "aws_route_table" "private_az1" {
#   vpc_id = aws_vpc.wts.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.az1.id
#   }

#   tags = {
#     Name = "WTS"
#   }
# }

# resource "aws_route_table" "private_az2" {
#   vpc_id = aws_vpc.wts.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.az2.id
#   }

#   tags = {
#     Name = "WTS"
#   }
# }

# resource "aws_route_table" "private_az3" {
#   vpc_id = aws_vpc.wts.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.az3.id
#   }

#   tags = {
#     Name = "WTS"
#   }
# }

# resource "aws_route_table" "private_az4" {
#   vpc_id = aws_vpc.wts.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.az4.id
#   }

#   tags = {
#     Name = "WTS"
#   }
# }

# public route table associations

resource "aws_route_table_association" "public_az1" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public_az1.id
}

resource "aws_route_table_association" "public_az2" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public_az2.id
}

resource "aws_route_table_association" "public_az3" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public_az3.id
}

resource "aws_route_table_association" "public_az4" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public_az4.id
}

# private route table associations

# resource "aws_route_table_association" "private_az1" {
#   route_table_id = aws_route_table.private_az1.id
#   subnet_id = aws_subnet.private_az1.id
# }

# resource "aws_route_table_association" "private_az2" {
#   route_table_id = aws_route_table.private_az2.id
#   subnet_id = aws_subnet.private_az2.id
# }

# resource "aws_route_table_association" "private_az3" {
#   route_table_id = aws_route_table.private_az3.id
#   subnet_id = aws_subnet.private_az3.id
# }

# resource "aws_route_table_association" "private_az4" {
#   route_table_id = aws_route_table.private_az4.id
#   subnet_id = aws_subnet.private_az4.id
# }

# services

module "test_instance" {
  source = "./services/test_instance"
  subnet_id = aws_subnet.public_az1.id
}

module "public_gateway" {
  source = "./services/public_gateway"
  subnet_ids = [
    aws_subnet.public_az1.id,
    aws_subnet.public_az2.id,
    aws_subnet.public_az3.id,
    aws_subnet.public_az4.id
  ]
  vpc_id = aws_vpc.wts.id
  availability_zones = [
    "us-east-1c", // use1-az1
    "us-east-1d", // use1-az2
    "us-east-1e", // use1-az3
    "us-east-1a"  // use1-az4
  ]
}