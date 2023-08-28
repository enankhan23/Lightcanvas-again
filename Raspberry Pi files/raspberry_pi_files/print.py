import pickle


with open('coordinates.pkl', 'rb') as f:
        coords = pickle.load(f)

for coord in coords:
        print(coord)
