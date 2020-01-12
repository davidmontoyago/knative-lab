pre-reqs:
	python3 -m pip install pipenv
	pipenv install -r requirements.txt
	pipenv lock

package:
	make pre-reqs
	docker build . -t faas/helloworld-py:latest