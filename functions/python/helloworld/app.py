
from flask import Flask
import logging
import os
import sys

log = logging.getLogger(__name__)

app = Flask(__name__)

def setup_app(app):
    console_handler = logging.StreamHandler(sys.stdout)
    log.addHandler(console_handler)
    log.setLevel(logging.DEBUG)
    log.info("starting python helloworld on port %s...", os.environ["PORT"])

setup_app(app)

@app.route("/py/hello")
def hello():
    log.info("handling request at /py/hello")
    return "Hello from Python app!"