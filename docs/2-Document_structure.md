### Directory structure

~~~

├── main.tf
├── outputs.tf
├── provider.tf
├── variables.tf
└── versions.tf
~~~

Getting started with the structuring of Terraform configurations
Putting all code in main.tf is a good idea when you are getting started or writing an example code. In all other cases you will be better having several files split logically like this:
- main.tf - call modules, locals, and data sources to create all resources
- variables.tf - contains declarations of variables used in main.tf
- outputs.tf - contains outputs from the resources created in main.tf
- provider.tf - contains configuration for multiple providers
- versions.tf - contains version requirements for Terraform

### Terraform block

Terraform settings are gathered together into terraform blocks


Each terraform block can contain a number of settings related to Terraform's behavior. Within a terraform block, only constant values can be used; arguments may not refer to named objects such as resources, input variables, etc, and may not use any of the Terraform language built-in functions.

The `required_version` setting accepts a version constraint string, which specifies which versions of Terraform can be used with your configuration.

The required_version setting applies only to the version of Terraform CLI. Terraform's resource types are implemented by provider plugins, whose release cycles are independent of Terraform CLI and of each other. Use the `required_providers` block to manage the expected versions for each provider you use.

The `required_providers` block specifies all of the providers required by the current module, mapping each local provider name to a source address and a version constraint.

~~~JSON
terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = "~> 1.2"


}
~~~


### Urls

- [1] [https://www.terraform-best-practices.com/code-structure](https://www.terraform-best-practices.com/code-structure)
- [2] [https://developer.hashicorp.com/terraform/language/settings](https://developer.hashicorp.com/terraform/language/settings)