import picamera
import picamera.array
import cv2

with picamera.PiCamera() as camera:
    camera.resolution = (640, 480)  # Set the resolution of the camera
    camera.framerate = 24  # Set the frame rate
    camera.start_preview()  # Start the preview
    
    # Create a window to display the video feed
    cv2.namedWindow("Video Feed", cv2.WINDOW_NORMAL)
    cv2.resizeWindow("Video Feed", 640, 480)
    
    while True:
        # Capture a frame from the camera
        with picamera.array.PiRGBArray(camera) as output:
            camera.capture(output, 'rgb')
            frame = output.array
        
        # Display the frame in the "Video Feed" window
        cv2.imshow("Video Feed", frame)
        
        # Exit if 'q' is pressed
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break
    
    # Clean up resources
    cv2.destroyAllWindows()
    camera.stop_preview()
