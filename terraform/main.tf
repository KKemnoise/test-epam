data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update -y
                sudo apt-get upgrade -y
                sudo apt-get install -y openjdk-11-jdk
                wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
                sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
                sudo apt-get update -y
                sudo apt-get install -y jenkins
                sudo systemctl start jenkins
                sudo systemctl enable jenkins
                sudo apt-get install -y git
                echo "Jenkins installed successfully."
                echo "The initial Jenkins admin password is:"
                sudo cat /var/lib/jenkins/secrets/initialAdminPassword
              EOF

}
  tags = {
    Name = "HelloWorld"
  }
}