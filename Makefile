cluster:
	minikube start --memory=8192 --cpus=4 \
		--kubernetes-version=v1.16.2 \
		--vm-driver=hyperkit \
		--disk-size=30g \
		--extra-config=apiserver.enable-admission-plugins="LimitRanger,NamespaceExists,NamespaceLifecycle,ResourceQuota,ServiceAccount,DefaultStorageClass,MutatingAdmissionWebhook"

deploy:
	kubectl apply -f ./deployment/knative/serving-crds.yaml
	kubectl apply -f ./deployment/knative/serving-core.yaml

	kubectl apply -f ./deployment/ambassador

destroy:
	kubectl delete -f ./deployment/knative/serving-crds.yaml
	kubectl delete -f ./deployment/knative/serving-core.yaml

	kubectl delete -f ./deployment/ambassador

# minikube service --url ambassador | head -n 1