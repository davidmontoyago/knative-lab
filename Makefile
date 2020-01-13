REGISTRY:=$(shell minikube ip)
SOCAT_BRIDGE:=$(shell docker ps --filter name=socat-bridge -q)

cluster:
	minikube start --memory=8192 --cpus=4 \
		--kubernetes-version=v1.16.2 \
		--vm-driver=hyperkit \
		--disk-size=30g \
		--insecure-registry="$(REGISTRY):5000" \
		--extra-config=apiserver.enable-admission-plugins="LimitRanger,NamespaceExists,NamespaceLifecycle,ResourceQuota,ServiceAccount,DefaultStorageClass,MutatingAdmissionWebhook"
	
	minikube addons enable registry
	
	# port forward from local to minikube with socat
	docker rm -f $(SOCAT_BRIDGE) || true
	docker run -d --name socat-bridge --rm --network=host alpine ash -c "apk add socat && socat TCP-LISTEN:5000,reuseaddr,fork TCP:$(REGISTRY):5000" 2>/dev/null

deploy:
	kubectl apply -f ./deployment/knative/serving-crds.yaml
	kubectl apply -f ./deployment/knative/serving-core.yaml
	kubectl apply -f ./deployment/knative/config-context.yaml

	kubectl apply -f ./deployment/ambassador

destroy:
	kubectl delete -f ./deployment/knative/serving-crds.yaml
	kubectl delete -f ./deployment/knative/serving-core.yaml

	kubectl delete -f ./deployment/ambassador

# minikube service --url ambassador | head -n 1