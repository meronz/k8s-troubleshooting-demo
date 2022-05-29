# Kubernetes troubleshooting demo

### Setup
You will need Minikube and Skaffold. To setup a cluster for this demo, launch:

```shell
minikube start --network-plugin=cni --cni=calico
minikube addons enable metrics-server
minikube addons enable ingress
skaffold run
```

and once it finishes, run:
```shell
minikube tunnel
```
to expose the application on [http://localhost:8080](http://localhost:8080)