import cv2

# Load the template and user-drawn image
template = cv2.imread("E:\\4-1\\IDP\\star2.jpg", cv2.IMREAD_GRAYSCALE)
user_drawn = cv2.imread("E:\\4-1\\IDP\\star2.jpg", cv2.IMREAD_GRAYSCALE)

# Find contours in the template and user-drawn image
template_contours, _ = cv2.findContours(template, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
user_drawn_contours, _ = cv2.findContours(user_drawn, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

# Calculate the similarity between the contours
def compare_contours(contours1, contours2):
    similarity_scores = []
    for contour1 in contours1:
        scores = []
        for contour2 in contours2:
            score = cv2.matchShapes(contour1, contour2, cv2.CONTOURS_MATCH_I3, 0)
            scores.append(score)
        similarity_scores.append(min(scores))  # Use the minimum score for each contour
    return similarity_scores

contour_similarity_scores = compare_contours(template_contours, user_drawn_contours)

# Print the similarity scores
#for i, score in enumerate(contour_similarity_scores):
    #print(f"Contour {i+1} Similarity Score: {score}")

# Calculate an overall similarity score
overall_similarity = sum(contour_similarity_scores) / len(contour_similarity_scores)
print(f"Overall Contour Similarity Score: {overall_similarity}")
