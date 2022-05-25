Build the Docker image: `docker build -t insta .`

Run the Docker image: `docker run -p 8080:8080 insta`

To run Jenkins: `sudo systemctl start jenkins` on port `8080`

To stop Jenkins: `sudo systemctl stop jenkins` 
<<<<<<< HEAD:guide.md
To get status from Jenkins: `sudo systemctl status jenkins` 
=======

>>>>>>> 7098b214f99a9a53b006eded88a832ddc8428e98:README.md
Start Minikube: `minikube start`

expose IP: `minikube tunnel`

Access port from Minikube: `minikube service goviolin-service --url` or `minikube service goviolin-service`
