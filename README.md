Build the Docker image: `docker build -t insta .`

Run the Docker image: `docker run -p 8080:8080 insta`

To run Jenkins: `sudo systemctl start jenkins` on port `8080`

To stop Jenkins: `sudo systemctl stop jenkins` 

Start Minikube: `minikube start`

expose IP: `minikube tunnel`

Access port from Minikube: `minikube service goviolin-service --url` or `minikube service goviolin-service`
