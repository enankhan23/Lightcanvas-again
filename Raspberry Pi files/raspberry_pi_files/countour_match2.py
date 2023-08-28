import cv2
import numpy as np
import math

###gives value between 0.0 to 1.0 but we are getting difference value, so need to minus the value from 1

def calculate_contour_similarity(contours1, contours2):
    total_similarity = 0
    for contour1 in contours1:
        min_similarity = float('inf')
        for contour2 in contours2:
            similarity = cv2.matchShapes(contour1, contour2, cv2.CONTOURS_MATCH_I3, 0)
            if similarity < min_similarity:
                min_similarity = similarity
        total_similarity += min_similarity
    return total_similarity / len(contours1)

# Load the image and template
image = cv2.imread("E:\\4-1\\IDP\\star2.jpg")
template = cv2.imread("E:\\4-1\\IDP\\perfect_star.jpg")

# Convert images to grayscale
gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
gray_template = cv2.cvtColor(template, cv2.COLOR_BGR2GRAY)

# Find contours in the images
contours_image, _ = cv2.findContours(gray_image, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
contours_template, _ = cv2.findContours(gray_template, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

# Calculate the contour similarity score
contour_similarity = calculate_contour_similarity(contours_template, contours_image)


cv2.imshow('Matched Image', gray_image)
cv2.imshow('Template Image', gray_template)
cv2.waitKey(0)
cv2.destroyAllWindows()
# Print the contour similarity score
print('Contour Similarity Score:', (contour_similarity))
