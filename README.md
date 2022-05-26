Build the Docker image: `docker build -t mostafaw/goviolin:latest .`

Run the Docker image: `docker run -p 3000:8080 mostafaw/goviolin:latest`

Docker compose: `docker-compose -f docker-compose.yaml up`

To run Jenkins: `sudo systemctl start jenkins` on port `8080`

To stop Jenkins: `sudo systemctl stop jenkins` 
To get status from Jenkins: `sudo systemctl status jenkins` 

Start Minikube: `minikube start`

expose IP: `minikube tunnel`

Access port from Minikube: `minikube service goviolin-service --url` or `minikube service goviolin-service`
