import cv2
import math

###eiake server e pathaite hobe###

def compare_contours_hu(image1, image2):
    # Convert images to grayscale
    gray_image1 = cv2.cvtColor(image1, cv2.COLOR_BGR2GRAY)
    gray_image2 = cv2.cvtColor(image2, cv2.COLOR_BGR2GRAY)
    
    # Apply thresholding to obtain binary images
    _, binary_img1 = cv2.threshold(gray_image1, 100, 255, cv2.THRESH_BINARY)
    _, binary_img2 = cv2.threshold(gray_image2, 100, 255, cv2.THRESH_BINARY)
    
    # Find contours
    contours1, _ = cv2.findContours(binary_img1, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    contours2, _ = cv2.findContours(binary_img2, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    
    # Calculate Hu Moments for the contours
    moments1 = cv2.moments(contours1[0])
    hu_moments1 = cv2.HuMoments(moments1).flatten()
    
    moments2 = cv2.moments(contours2[0])
    hu_moments2 = cv2.HuMoments(moments2).flatten()
    
    # Calculate the similarity using Hu Moments
    similarity_score = cv2.matchShapes(hu_moments1, hu_moments2, cv2.CONTOURS_MATCH_I1, 0)
    
    return similarity_score


# Load the images
image1 = cv2.imread("E:\\4-1\\IDP\\perfect_star.jpg")
image2 = cv2.imread("E:\\4-1\\IDP\\server.jpg")

# Compare contours using Hu Moments and get the similarity score
contour_similarity_score = compare_contours_hu(image1, image2)

cv2.imshow('Matched Image', image1)
cv2.imshow('Template Image', image2)
cv2.waitKey(0)
cv2.destroyAllWindows()


# Print the similarity score
print("Contour Similarity Score:", math.ceil(contour_similarity_score))


#value ke ami whole number kore pathacchi, this will be my percentage value. 
#Progress report e I'm dividing the value by 100
