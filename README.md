
- Build the Docker image: `docker build -t mostafaw/goviolin:latest .`
- Run the Docker image: `docker run -p 3000:8080 mostafaw/goviolin:latest`
- Docker compose: `docker-compose -f docker-compose.yaml up`

- To run Jenkins: `sudo systemctl start jenkins` on port `8080`
- To stop Jenkins: `sudo systemctl stop jenkins` 
- To get status from Jenkins: `sudo systemctl status jenkins` 

- before start: `eval $(minikube docker-env)`
- Start Minikube: `minikube start`
- List pods: `minikube kubectl -- get pods -A`
- list: `kubectl get pods `, `kubectl get services `, `kubectl get deployment`
- delete pod: `kubectl delete pod <name> `
- expose IP: `minikube tunnel`
- Access port from Minikube: `minikube service goviolin-service --url` 

Run test:
```
go mod init github.com/Rosalita/GoViolin
go mod tidy
go mod vendor
go build -o runnable.o .
go test ./...
```
