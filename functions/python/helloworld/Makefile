REGISTRY:=$(shell minikube ip)

pre-reqs:
	python3 -m pip install pipenv
	pipenv install -r requirements.txt
	pipenv lock

package:
	make pre-reqs
	docker build . -t $(REGISTRY):5000/faas/helloworld-py:latest

deploy:
	docker push $(REGISTRY):5000/faas/helloworld-py:latest
	kubectl apply -f service.yaml