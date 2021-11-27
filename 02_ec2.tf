# security group
resource "aws_security_group" "pro_websg" {
    name        = "Allow-WEB"
    description = "http-ssh-icmp"
    vpc_id      = aws_vpc.pro_vpc.id
  
    ingress = [
        {
            description         = "ssh"
            from_port           = 22
            to_port             = 22
            protocol            = "tcp"
            cidr_blocks         = ["0.0.0.0/0"]
            ipv6_cidr_blocks    = ["::/0"]
            prefix_list_ids     = null
            security_groups     = null
            self                = null
        },
        {
            description         = "http"
            from_port           = 80
            to_port             = 80
            protocol            = "tcp"
            cidr_blocks         = ["0.0.0.0/0"]
            ipv6_cidr_blocks    = ["::/0"]
            prefix_list_ids     = null
            security_groups     = null
            self                = null
        },
        {
            description         = "icmp"
            from_port           = -1
            to_port             = -1
            protocol            = "icmp"
            cidr_blocks         = ["0.0.0.0/0"]
            ipv6_cidr_blocks    = ["::/0"]
            prefix_list_ids     = null
            security_groups     = null
            self                = null
         },
         {
            description      = "mysql"
            from_port        = 3306
            to_port          = 3306
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
            security_groups  =  null
            prefix_list_ids  =  null
            self             =  null
        },{
            description         = "tomcat"
            from_port           = 8080
            to_port             = 8080
            protocol            = "tcp"
            cidr_blocks         = ["0.0.0.0/0"]
            ipv6_cidr_blocks    = ["::/0"]
            prefix_list_ids     = null
            security_groups     = null
            self                = null
        },
    ]

    egress = [
        {
            description         = "All"
            from_port           = 0
            to_port             = 0
            protocol            = "-1"
            cidr_blocks         = ["0.0.0.0/0"]
            ipv6_cidr_blocks    = ["::/0"]
            prefix_list_ids     = null
            security_groups     = null
            self                = null
        }
    ]

    tags = {
      "Name" = "pro-tf-websg"
    }
}

# instance_ami
data "aws_ami" "amzn" {
    most_recent = true
    
    filter  {  
        name = "name"
        values = ["amzn2-ami-hvm*-x86_64-ebs"]
    }
  
  filter {
    name    ="virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

# instance 
resource "aws_instance" "pro_bas_a" {
    ami                         = "ami-0e4a9ad2eb120e054"
    instance_type               = "t2.micro"
    key_name                    = "pro-tf-key"
    vpc_security_group_ids      = [aws_security_group.pro_websg.id]
    availability_zone           = "ap-northeast-2a"
    subnet_id                   = aws_subnet.pro_puba.id
    user_data                   = file("./pro-tf.sh")

    tags   =   {
        Name = "pro-tf-bas_a"
    }
}

# instance_eip
resource "aws_eip" "pro_bas_a_eip" {
  vpc = true
  instance                    = aws_instance.pro_bas_a.id
}

# instance_pri_a
resource "aws_instance" "pri_a" {
    ami                         = "ami-0e4a9ad2eb120e054"
    instance_type               = "t2.micro"
    key_name                    = "pro-tf-key"
    vpc_security_group_ids      = [aws_security_group.pro_websg.id]
    availability_zone           = "ap-northeast-2a"
    subnet_id                   = aws_subnet.pro_pria.id
    user_data                   = file("./http-tomcat.sh")

    tags   =   {
        Name = "pro-tf-pria"
    }
}

# instance_pri_c
resource "aws_instance" "pri_c" {
    ami                         = "ami-0e4a9ad2eb120e054"
    instance_type               = "t2.micro"
    key_name                    = "pro-tf-key"
    vpc_security_group_ids      = [aws_security_group.pro_websg.id]
    availability_zone           = "ap-northeast-2c"
    subnet_id                   = aws_subnet.pro_pric.id
    user_data                   = file("./http-tomcat.sh")

    tags   =   {
        Name = "pro-tf-pric"
    }
}


# trace1
resource "aws_instance" "pro_trace1" {
    ami                         = "ami-0e4a9ad2eb120e054"
    instance_type               = "t2.micro"
    key_name                    = "pro-tf-key"
    vpc_security_group_ids      = [aws_security_group.pro_websg.id]
    availability_zone           = "ap-northeast-2c"
    subnet_id                   = aws_subnet.pro_pubc.id

    tags   =   {
        Name = "pro-tf-trace1"
    }
}

# instance_eip
resource "aws_eip" "pro_trace1_eip" {
  vpc = true
  instance                    = aws_instance.pro_trace1.id
}

# trace2
resource "aws_instance" "pro_trace2" {
    ami                         = "ami-0e4a9ad2eb120e054"
    instance_type               = "t2.micro"
    key_name                    = "pro-tf-key"
    vpc_security_group_ids      = [aws_security_group.pro_websg.id]
    availability_zone           = "ap-northeast-2c"
    subnet_id                   = aws_subnet.pro_pubc.id

    tags   =   {
        Name = "pro-tf-trace2"
    }
}

# instance_eip
resource "aws_eip" "pro_trace2_eip" {
  vpc = true
  instance                    = aws_instance.pro_trace2.id
}

# trace3
resource "aws_instance" "pro_trace3" {
    ami                         = "ami-0e4a9ad2eb120e054"
    instance_type               = "t2.micro"
    key_name                    = "pro-tf-key"
    vpc_security_group_ids      = [aws_security_group.pro_websg.id]
    availability_zone           = "ap-northeast-2c"
    subnet_id                   = aws_subnet.pro_pubc.id

    tags   =   {
        Name = "pro-tf-trace3"
    }
}

# instance_eip
resource "aws_eip" "pro_trace3_eip" {
  vpc = true
  instance                    = aws_instance.pro_trace3.id
}