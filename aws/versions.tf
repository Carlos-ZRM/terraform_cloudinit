terraform {
  # The experiments argument allows us to add experimental features that are not specified as 'stable' in a terraform release yet.
  # In this case, we are enabling the 'module_variable_optional_attrs' which allow us to use the 'defaults()' function experiments = [module_variable_optional_attrs]

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

}
