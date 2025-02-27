
#############################################################################
# We are covering Multiple AWS providers (default + alias) in this file.
#############################################################################

###################################################
# Default AWS Provider
###################################################
provider "aws" {
  region = var.default_region
}

###################################################
# AWS Provider (Alias for a second region)
###################################################
provider "aws" {
  alias  = "secondary"
  region = var.secondary_region
}
