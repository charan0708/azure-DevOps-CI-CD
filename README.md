# DevOps Technical Task

# Azure DevOps CI/CD for .NET 8 Web app (Docker + AKS)

This project demonstrates how to build, test, containerize, and deploy a .NET 8 Web API using Azure DevOps pipelines. The container is pushed to Docker Hub and deployed to Azure Kubernetes Service (AKS).

## 📦 Project Stack
- CI/CD: Azure DevOps Pipelines
- Container Registry: Docker Hub
- Deployment Platform: Azure Kubernetes Service (AKS)

CI Pipeline: `.azure-pipelines/azure-build.yml`:
Triggers on:
- Push to `main`
- Pull requests to `main`

### Steps:
1. Test: Runs `dotnet test` on the API
2. Build: Compiles the API using `dotnet build`
3. Dockerize & Push: Builds Docker image and pushes it to Docker Hub.

## CD Pipeline: `.azure-pipelines/azure-release.yml`

### Trigger:
- Automatically triggered on successful completion of the CI pipeline

### Steps:
1. Uses Azure CLI to connect to AKS
2. Deploys the image using `kubectl apply -f k8s/deployment.yaml`

---

##  Kubernetes Manifest: `k8s/deployment.yaml`

Creates:
- A Deployment for the `counterapi` container
- A NodePort Service to expose it across the network or in the nodes.

Finally the image path in the YAML is updated:

```yaml
image: charan0802/counterapi:latest
