variable "ami" {
  type = string
  default = "ami-02df5cb5ad97983ba"
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

resource "aws_key_pair" "terra-key" {
  key_name   = "terra-key"
  public_key = file("/workspaces/terraform-projects/terra-test/.ssh/terra-key.pub")
}