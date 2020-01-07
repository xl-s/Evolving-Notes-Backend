from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route("/api/")
def home():
	with open("content", "r", encoding="UTF-8") as f:
		content = f.read().strip()
	return jsonify(body=content)
