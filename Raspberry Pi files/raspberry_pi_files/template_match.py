import cv2
import numpy as np
import math

def match_template(image, template):
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

    return matched_image, similarity_score

# Load the image and template
image = cv2.imread("/home/khaled/Desktop/test_trial/perfect_star.jpg")
template = cv2.imread("/home/khaled/Desktop/test_trial/server.jpg")


# Perform template matching and get the matched image and similarity score
matched_image, similarity_score = match_template(image, template)

# Display the original image and the matched image
cv2.imshow('Template Image', template)
cv2.imshow('Matched Image', matched_image)
cv2.waitKey(0)
cv2.destroyAllWindows()

# Print the similarity score
print('Similarity Score:', math.ceil(similarity_score*100))
