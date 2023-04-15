provider "aws"{
    region = "us-east-1"
    access_key = "AKIAQWGE3LSX2S7FTCXX"
    secret_key = "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"
}
resource "aws_instance" "module"{
    ami = var.ec2_info.ec2_ami
    instance_type = var.ec2_info.ec2_instance
    key_name = aws_key_pair.keypair.key_name
}
 
resource "aws_key_pair" "keypair"{
    key_name = var.ec2_info.key_pair_name
    public_key = tls_private_key.rsa-4096-example.public_key_openssh
}
resource "tls_private_key" "rsa-4096-example"{
    algorithm = "RSA"
    rsa_bits =  4096
}

resource "local_file" "foo"{
    content = tls_private_key.rsa-4096-example.private_key_pem
    filename = "demo_check.pem"
}
variable "ec2_info"{
    type = object({
       ec2_ami = string
       ec2_instance = string
       key_pair_name = string
    }
    )
    default ={
        ec2_ami = "ami-069aabeee6f53e7bf"
        ec2_instance = "t2.nano"
        key_pair_name = "shanu_test"
    } 
}
output "aws_instance"{
    value = aws_instance.module
}
