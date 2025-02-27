# Manage Kubernetes Clusters Using Terraform

Terraform simplifies the management of Kubernetes clusters by:

1. **Automating Cluster Creation**: Create, update, and delete clusters programmatically, reducing manual effort.  
2. **Managing Resources as Code**: Treat Kubernetes resources (e.g., Deployments, Services) as version-controlled code.  
3. **Seamless Cloud Integration**: Easily provision cloud infrastructure (VPCs, subnets, node groups) alongside Kubernetes config.

This guide shows how to create an **Amazon EKS cluster** and deploy a **sample NGINX application** using Terraform.

---

## Prerequisites

1. **Terraform Installed**: Make sure you have a recent version of [Terraform](https://developer.hashicorp.com/terraform/downloads) installed.  
2. **AWS CLI & Credentials**: You’ll need AWS credentials configured (e.g., via `aws configure` or environment variables) with permissions to create EKS resources.  
3. **kubectl**: Optionally, install [kubectl](https://kubernetes.io/docs/tasks/tools/) if you want to manually interact with the cluster.

---

## 1. Create an EKS Cluster

Below is an example using the [terraform-aws-modules/eks/aws](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest) module to simplify EKS configuration. This module handles the creation and configuration of the EKS control plane, node groups, networking, and more.

```hcl
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.21"

  # Reference your existing VPC and subnets
  vpc_id  = aws_vpc.example.id
  subnets = [aws_subnet.example.id]

  worker_groups = [
    {
      instance_type = "t2.medium"
      asg_max_size  = 3
    }
  ]
}
```

**Autonomy:**

- `cluster_name` & `cluster_version`: Define a meaningful name for your cluster and specify the Kubernetes version (e.g., 1.21 or higher).
- `vpc_id` & `subnets`: Use your existing AWS VPC and subnet IDs.
- `worker_groups`: Configure node groups (e.g., instance types, scaling limits). Here, an Auto Scaling group is set with a max size of 3 nodes.

---

## 2. Deploy a Kubernetes Application

Once Terraform creates the EKS cluster, you can manage Kubernetes resources by configuring the kubernetes provider to communicate with your new cluster.

```hcl
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = module.eks.cluster_auth_token
}
```

Sample Deployment and Service
Below is an NGINX Deployment and corresponding Service that exposes traffic via an AWS load balancer:

```hcl
resource "kubernetes_deployment" "example" {
  metadata {
    name = "example-deployment"
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "example"
      }
    }
    template {
      metadata {
        labels = {
          app = "example"
        }
      }
      spec {
        container {
          name  = "example"
          image = "nginx:latest"
        }
      }
    }
  }
}

resource "kubernetes_service" "example" {
  metadata {
    name = "example-service"
  }
  spec {
    selector = {
      app = "example"
    }
    port {
      port        = 80
      target_port = 80
    }
    # Creates an AWS ELB (Classic or ALB/NLB depending on EKS version & settings)
    type = "LoadBalancer"
  }
}
```

**Autonomy:**

1. *kubernetes_deployment:*
- `replicas = 3` spins up 3 pods of NGINX for load balancing and redundancy.
- `selector` and `template` ensure pods are labeled consistently, making them discoverable by Services.
2. *kubernetes_service:*
- `type = "LoadBalancer"` creates an external load balancer to expose port 80 to the internet (or your chosen network).
- `selector` matches pods labeled `app = "example"`.

---

## 3. Usage and Workflow

1. **Initialize:**

```bash
terraform init
```

This downloads the required providers and modules.

2. **Plan:**

```bash
terraform plan
```

Review the changes Terraform will make (e.g., new EKS cluster, node groups, Kubernetes resources).

3. **Apply:**

```bash
terraform apply
```

Provisions your AWS infrastructure and Kubernetes resources. This step may take several minutes for EKS to become active.

4. **Verify (Optional):**

- Use kubectl get pods --all-namespaces to confirm your pods are running.
- Use kubectl get svc to see the external load balancer DNS name and access your NGINX service in a browser.

5. **Clean Up:**
To remove all resources when you’re done testing or no longer need the cluster:

```bash
terraform destroy
```

This will delete the EKS cluster, node groups, and associated Kubernetes resources. Ensure you no longer need them before running this command.
