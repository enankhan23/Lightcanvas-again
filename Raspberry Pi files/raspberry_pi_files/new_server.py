import subprocess
from flask import Flask, send_file

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/image')
def send_image():
    image_path = r'/home/khaled/Desktop/test_trial/latest.jpg'
    return send_file(image_path, mimetype='image/jpeg')

if __name__ == '__main__':
    # Start the drawing.py script as a separate process
    subprocess.Popen(['python', '/home/khaled/Desktop/exp.py'])

    # Run the Flask server
    app.run(host='0.0.0.0', port=5000)
