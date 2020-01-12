FROM python:3.7-alpine3.11

ENV PORT=9000

WORKDIR /app

COPY . ./

RUN pip install pipenv && \
    pipenv install --system --ignore-pipfile

CMD exec gunicorn --bind :$PORT app:app
