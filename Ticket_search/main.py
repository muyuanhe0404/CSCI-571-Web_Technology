from flask import Flask, jsonify,abort
from flask import *
app = Flask(__name__, static_folder='static', static_url_path='')

@app.route("/")
def homepage():
    #return "hello"
    return app.send_static_file("events.html")

if __name__ == "__main__":
    app.run()
