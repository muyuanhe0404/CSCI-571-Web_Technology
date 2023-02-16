from flask import Flask, jsonify,abort
from flask import *
app = Flask(__name__)

@app.route("/")
def homepage():
    return app.send_static_file("events.html")
if __name__ == "__main__":
    app.run()
