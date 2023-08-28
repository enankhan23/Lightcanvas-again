import cv2
import numpy as np
import matplotlib.pyplot as plt

####gives us the difference, but sometimes it becomes more than 1.0 

def match_template(image, template):
    # Convert the image and template to grayscale
    gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    gray_template = cv2.cvtColor(template, cv2.COLOR_BGR2GRAY)
    _, binary_img1 = cv2.threshold(gray_image, 100, 255, cv2.THRESH_BINARY)
    _, binary_img2 = cv2.threshold(gray_template, 100, 255, cv2.THRESH_BINARY)
    contour1, heirarchy = cv2.findContours(binary_img1, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    contour2, heirarchy = cv2.findContours(binary_img2, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cont_diff = cv2.matchShapes(contour1[0],contour2[0],cv2.CONTOURS_MATCH_I2,0)
    
    # Calculate the similarity score
    similarity_score = cont_diff

    return binary_img1, binary_img2,similarity_score

# Load the image and template
image = cv2.imread("E:\\4-1\\IDP\\circle_2.jpg")
template = cv2.imread("E:\\4-1\\IDP\\perfect_star.jpg")


# Perform template matching and get the matched image and similarity score
matched_image, template_image, similarity_score = match_template(image, template)

# Display the original image and the matched image
# cv2.imshow('Template Image', template)

cv2.imshow('Matched Image', matched_image)
cv2.imshow('Template Image', template_image)
cv2.waitKey(0)
cv2.destroyAllWindows()

# Print the similarity score
print('Similarity Score:', (similarity_score))
