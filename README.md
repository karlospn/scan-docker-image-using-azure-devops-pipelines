# Testing how to use some container vulnerabilities scanners with Azure DevOps CI/CD pipelines

This repository features multiple Azure DevOps YAML pipelines that will show you how you can use a few of the most well-known vulnerability scanners in the market right now.

The scanners that I'll be testing are the following ones: 
- AWS Elastic Container Registry integrated scanner featuring Clair.
- AquaSec Trivy.
- Azure Defender for ACR scan featuring Qualys.
- Sysdig

You can find a pipeline for each scanner in the ``/pipelines`` folder.
