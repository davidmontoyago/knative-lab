# knative-lab

### Pre-reqs

- Minikube

```
# knative's cannot reuse the host docker daemon to pull images - using local registry instead 
eval $(minikube docker-env --unset)

# start minikube cluster
make cluster

# deploy knative & ambassador
make deploy

```