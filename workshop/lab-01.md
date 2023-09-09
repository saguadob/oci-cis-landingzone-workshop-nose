# Lab 01 - Deploy with a Landing Zone

## Task 1 - Setup a Ephemeral Environment

Go to the OCI Cloud shell using this [link](https://cloud.oracle.com/?&bdcstate=maximized&cloudshell=true)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/saguadob/oci-cis-landingzone-workshop-nose/main/configure-oci-shell.sh)"
```

The following command downloads and runs this 📃 [script file](../configure-oci-shell.sh). Let's analize the script:

```sh
# Authenticate to github and get also the user scope
gh auth login -s user -h github.com -p https -w

gh repo fork saguadob/oci-cis-landingzone-workshop-nose --fork-name oci-cis-landingzone-workshop --clone --remote=true --remote-name=origin
cd oci-cis-landingzone-workshop

git config user.name "$(gh api user -q .login)"
git config user.email "$(gh api user/public_emails -q first.email)"
gh repo set-default "$(gh api user -q .login)/oci-cis-landingzone-workshop"
git remote rm upstream
```

And the a initial Resource Manager stack is created

```sh
git_config_ocid=$(oci resource-manager configuration-source-provider create-github-access-token-provider --compartment-id "$OCI_TENANCY" --access-token "$(gh auth token)" --api-endpoint "https://github.com"  --display-name "gh-lz-01" --query data.id --raw-output) 

oci resource-manager stack create-from-git-provider --compartment-id "$OCI_TENANCY" --config-source-configuration-source-provider-id "$git_config_ocid" --config-source-branch-name main --config-source-repository-url "$(gh repo view --json url -q .url)" --config-source-working-directory lz --display-name "stack-gh-oci-lz-01" --terraform-version "1.2.x" --variables "{\"tenancy_ocid\":\"$OCI_TENANCY\" , \"region\":\"$OCI_REGION\"}"
```

## Task 2 - Analize Folder structure

While the LZ is being deployed, lets analyze the components of the repository. Go to the [terraform guide](../terraform.md).

## Task 3 - TF Plan

``` sh
  oci resource-manager job create-plan-job --stack-id "<stack-ocid>" --display-name "plan-lz-job"
```

## Task 4 - Apply Configuration

```sh
oci resource-manager job create-apply-job --stack-id "<stack-ocid>" --execution-plan-strategy FROM_PLAN_JOB_ID --execution-plan-job-id "<plan-job-ocid>" --display-name "apply-deploy-lz-job"
```
