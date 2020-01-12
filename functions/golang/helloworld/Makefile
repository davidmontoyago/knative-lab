REGISTRY=localhost

package:
	docker ps
	docker build . -t $(REGISTRY):5000/faas/helloworld-go:latest

deploy:
	docker push $(REGISTRY):5000/faas/helloworld-go:latest
	kubectl apply -f service.yaml