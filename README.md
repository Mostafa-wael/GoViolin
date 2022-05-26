# Use GO Locally 
**Build, run and test Go locally:**
- Initialize the module: 
  - `go mod init github.com/Rosalita/GoViolin`
  - `go mod tidy`
  - `go mod vendor`
- Build a runnable binary: `go build -o runnable.o .`
- Run the binary: `./runnable.o`
- Run the tests: `go test ./...`
--- 
# Docker
The Docker image is based on the concept of multi-stage build. We use a builder stage to build the runnable binary and another light weight stage to run it. The final image using this approach is very small; less than the original image by a factor of 5!
- Build the Docker image: `docker build -t mostafaw/goviolin:latest .`
- Run the Docker image: `docker run -p 3000:8080 mostafaw/goviolin:latest`
---
# Docker Compose
We have used Docker compose here to encapsulate the parameters passed during running the docker image. 
- Docker compose: `docker-compose -f docker-compose.yaml up`
---
# Jenkins
The pipeline supports three stages: Run the tests, Build the image and Push the image to Docker Hub. It also supports sending emails with the pipeline status. The pipeline can be easily configured by specifying parameters when running it. 
- Run Jenkins: `sudo systemctl start jenkins` on port `8080`
- Get status(e.g.: password) from Jenkins: `sudo systemctl status jenkins` 
- Stop Jenkins: `sudo systemctl stop jenkins` 
---
# Kubernetes

Deploy & access a service in kubernetes:

- Start the local cluster: `minikube start`
- Create the deployment  `kubectl apply -f deployment.yaml `
- Create the service: `kubectl apply -f service.yaml`
- Get the URL: `minikube service goviolin-service --url`
- Expose the port (optional): `minikube tunnel`

---
# Helm
Use helm charts to manage k8s manifests 
- Install the chart: `helm install goviolin-chart  ./goviolin-chart`
- Update the chart values: `helm upgrade --install goviolin-chart  ./goviolin-chart`
- Get the URL: `minikube service goviolin-chart --url`
---
# Terraform
- Deploy the infrastructure: `terraform apply`
- Destroy the infrastructure: `terraform destroy`
