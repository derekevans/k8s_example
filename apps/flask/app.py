
import subprocess
import time

from flask import Flask


app = Flask(__name__)

@app.route("/")
def hello():

    # Add latency
    time.sleep(1)

    # Get IP
    out = subprocess.check_output(["hostname", "-I"])
    ip = out.decode().split(" ")[0]

    return f"Greetings from {ip}!"