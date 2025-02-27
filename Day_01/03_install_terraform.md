# Setting Up Terraform

Terraform’s full potential can only be realized when it is set up correctly on your system.

Let’s get started!

---

## 1. Installing Terraform

Terraform is a single binary executable, making installation straightforward. Here’s how to set it up based on your operating system.

### 1.1 Windows Installation

1. Download the latest Windows Terraform binary from the official website:  
   [Terraform Downloads](https://developer.hashicorp.com/terraform/install)
2. Extract the downloaded ZIP file to a directory (e.g., `C:\terraform`).
3. Add this directory to the System PATH:  
   - Search for **"Environment Variables"** in Windows.  
   - Edit the **Path** variable under **System Variables** and add the Terraform folder path.
4. Open **Command Prompt (cmd)** and verify installation:

   ```cmd
   C:\>terraform -v
   Terraform v1.10.5
   on windows_386

### 1.2 macOS Installation (via Homebrew)

1.2.1 Open Terminal and run:

```sh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

### 1.3 Linux Installation 

Follow the steps from the link - [Terraform Install](https://developer.hashicorp.com/terraform/install)

---

## Verify installation:

To ensure Terraform is installed correctly, check the version:

```cmd
terraform -v
```

This confirms Terraform is installed and ready to use.

Tip: `Always check for the latest Terraform version before installation by visiting the official HashiCorp website.`
