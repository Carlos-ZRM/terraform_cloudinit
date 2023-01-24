variable "ingress_port" {
    type = list(object({
      description = string
      from_port  = number
      to_port  = number
      protocol = string
      cidr_blocks = list(string)
    }))

    default = [
    {
      description      = "Cockpit from VPC"
      from_port        = 9090
      to_port          = 9090
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    },
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    },
    {
      description      = "HTTP from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    },
    ]
}