import subprocess
import cv2
from flask import Flask, Response

app = Flask(__name__)

# Start the exp.py script as a separate process
exp_process = subprocess.Popen(['python', '/home/khaled/Desktop/exp.py'], stdout=subprocess.PIPE)

def generate_frames():
    while True:
        # Read the frame from the subprocess stdout
        frame = exp_process.stdout.read(640 * 480 * 3)

        # If no frame is received, exit the loop
        if not frame:
            break

        # Yield the frame as a byte string
        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')

@app.route('/video_feed')
def video_feed():
    # Return the streaming response
    return Response(generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, threaded=True)
