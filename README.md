GoViolin is a helpful way to practice violin written in Go. Listen to any scale or arpeggio with a few mouse clicks. Play along to improve your intonation.
# Use GO Locally 
<img src="https://user-images.githubusercontent.com/56788883/175832396-30f2b8cd-1963-4bcb-9d90-b8ee393b24ef.png" alt="drawing" width="400"/>

Build, run and test Go locally:
- Initialize the module: 
  - `go mod init github.com/Rosalita/GoViolin`
  - `go mod tidy`
  - `go mod vendor`
- Build a runnable binary: `go build -o runnable.o .`
- Run the binary: `./runnable.o`
- Run the tests: `go test ./...`
--- 
# Docker
<img src="https://user-images.githubusercontent.com/56788883/175832426-b35052ce-4c90-45c5-a70d-82ba92a398a5.png" alt="drawing" width="400"/>

The Docker image is based on the concept of multi-stage build. We use a builder stage to build the runnable binary and another light weight stage to run it. The final image using this approach is very small; less than the original image by a factor of 5!
- Build the Docker image: `docker build -t mostafaw/goviolin:latest .`
- Run the Docker image: `docker run -p 3000:8080 mostafaw/goviolin:latest`
---
# Docker Compose
<img src="https://user-images.githubusercontent.com/56788883/175832455-761edfbb-5267-4f6c-8137-bb9151812c8f.png" alt="drawing" width="400"/>

We have used Docker compose here to encapsulate the parameters passed during running the docker image. 
- Docker compose: `docker-compose -f docker-compose.yaml up`
---
# Jenkins
![image](https://user-images.githubusercontent.com/56788883/175832347-652d700b-16e1-4b43-8fc2-30f39a86a287.png)

The pipeline supports three stages: Run the tests, Build the image and Push the image to Docker Hub. It also supports sending emails with the pipeline status. The pipeline can be easily configured by specifying parameters when running it. 
- Run Jenkins: `sudo systemctl start jenkins` on port `8080`
- Get status(e.g.: password) from Jenkins: `sudo systemctl status jenkins` 
- Stop Jenkins: `sudo systemctl stop jenkins` 
---
# Kubernetes
<img src="https://user-images.githubusercontent.com/56788883/175832473-9b8473f8-4dd8-42f3-ac85-13f7273fba88.png" alt="drawing" width="1000"/>

Deploy & access a service in kubernetes:
- Start the local cluster: `minikube start`
- Create the deployment  `kubectl apply -f deployment.yaml `
- Create the service: `kubectl apply -f service.yaml`
- Get the URL: `minikube service goviolin-service --url`
- Expose the port (optional): `minikube tunnel`

---
# Helm
<img src="https://user-images.githubusercontent.com/56788883/175832506-9e6be881-ec68-4600-b1c6-12d6debc6c40.png" alt="drawing" width="400"/>

Use helm charts to manage k8s manifests 
- Install the chart: `helm install goviolin-chart  ./goviolin-chart`
- Update the chart values: `helm upgrade --install goviolin-chart  ./goviolin-chart`
- Get the URL: `minikube service goviolin-chart --url`
---
# Provisioning using Terraform
<img src="https://user-images.githubusercontent.com/56788883/175832510-f3611654-3704-43d5-94c3-05cc89923891.png" alt="drawing" width="1000"/>

- Deploy the infrastructure: `terraform apply`
- Destroy the infrastructure: `terraform destroy`
- Stop the instance: `./stop-connection.sh GoViolin`
- Start the instance: `./start-connection.sh GoViolin`
