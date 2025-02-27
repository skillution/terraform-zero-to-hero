## Managing Multi-Cloud Environments with Terraform

### Why Multi-Cloud?
In today’s world, organizations often use multiple cloud providers (e.g., AWS, Azure, GCP) to avoid vendor lock-in, improve redundancy, and leverage the best features of each provider. 

Terraform makes it easy to manage resources across multiple clouds using a single configuration.

### Example: Multi-Cloud Configuration
Here’s how you can manage resources in both **AWS** and **Google Cloud Platform** using Terraform:

In the example configuration below, we are using Terraform to manage resources across multiple clouds in a single configuration.

To achieve this, we define separate provider blocks for each cloud provider.

```hcl

# AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Google Cloud Provider
provider "google" {
  project = "my-gcp-project"
  region  = "us-central1"
}

# AWS EC2 Instance
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

# Google Cloud Compute Instance
resource "google_compute_instance" "example" {
  name         = "example-instance"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
  }
}

```
