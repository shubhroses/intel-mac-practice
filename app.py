import time
import logging
from datetime import datetime
from flask import Flask, jsonify

logging.basicConfig(
   level=logging.INFO,
   format='%(asctime)s %(name)s - %(levelname)s - %(message)s'
)

app = Flask(__name__)

startup_time = time.time()

@app.route("/health")
def health_check():
   """Health check endpoint for kubernetes probes"""
   uptime = time.time() - startup_time
   logging.info(f"Reached health check endpoint at: {uptime:.2f}") 

   health_data = {
      "status": "Healthy",
      "timestamp": datetime.utcnow().isoformat(),
      "uptime": round(uptime, 2),
      "service": "flask-demo",
      "version": "1.0.0"
   }
   logging.info(f"Health check status: Healthy")
   return jsonify(health_data)


@app.route("/")
def hello():
   return "Hello from flask in k3s inside of Vagrant"

if __name__ == "__main__":
   app.run(host="0.0.0.0", port=5000, debug=False)

