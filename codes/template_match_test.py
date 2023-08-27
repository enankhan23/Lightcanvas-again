from flask import Flask, render_template
import cv2
import numpy as np
import math

app = Flask(__name__)

def match_template(image, template):
    # ... Your template matching code ...
    # Convert the image and template to grayscale
    gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    gray_template = cv2.cvtColor(template, cv2.COLOR_BGR2GRAY)

    # Perform template matching
    result = cv2.matchTemplate(gray_image, gray_template, cv2.TM_CCOEFF_NORMED)
    
    # Get the coordinates of the best match
    min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(result)
    top_left = max_loc
    bottom_right = (top_left[0] + template.shape[1], top_left[1] + template.shape[0])

    # Draw a rectangle around the matched region
    matched_image = cv2.rectangle(image.copy(), top_left, bottom_right, (0, 255, 0), 2)

    # Calculate the similarity score
    similarity_score = max_val

    return similarity_score

@app.route('/')
def index():
    # Load the image and template
    image = cv2.imread("E:\\4-1\\IDP\\star.jpg")
    template = cv2.imread("E:\\4-1\\IDP\\star_template.jpg")

    # Perform template matching and get the similarity score
    similarity_score = match_template(image, template)

    # Calculate the similarity score as a percentage
    #similarity_score_percent = math.ceil(similarity_score * 100)
    similarity_score_percent= similarity_score

    return render_template('result.html', similarity_score=similarity_score_percent)

if __name__ == '__main__':
    app.run(debug=True)
