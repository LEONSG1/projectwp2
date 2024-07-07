import os
from flask import Flask, request, jsonify
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestRegressor

app = Flask(__name__)

# Use an absolute path to specify the file location
file_path = '/Users/esra/Desktop/flight/Clean_Dataset.csv'  # Adjust this path as needed
if not os.path.exists(file_path):
    raise FileNotFoundError(f"File not found: {file_path}")

# Load the dataset
df = pd.read_csv(file_path)
# 'duration' column removal
# Selecting necessary columns and cleaning the data
df_cleaned = df.drop(columns=['stops'])
features = df_cleaned[['source_city', 'destination_city', 'class']]
target = df_cleaned['price']

# Converting categorical data to numerical data
label_encoders = {}
for column in features.columns:
    label_encoders[column] = LabelEncoder()
    features[column] = label_encoders[column].fit_transform(features[column])

# Splitting data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(features, target, test_size=0.2, random_state=42)

# Training the model
model = RandomForestRegressor(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    input_data = pd.DataFrame({
        'source_city': [data['source_city']],
        'destination_city': [data['destination_city']],
        'class': [data['class']]
    })
    
    for column in input_data.columns:
        input_data[column] = label_encoders[column].transform(input_data[column])
    
    predicted_price = model.predict(input_data)

    # Find matching flights for source and destination
    matching_flights = df_cleaned[
        (df_cleaned['source_city'] == data['source_city']) &
        (df_cleaned['destination_city'] == data['destination_city']) &
        (df_cleaned['class'] == data['class'])
    ]
    
    if not matching_flights.empty:
        flight_no = matching_flights.iloc[0]['flight']
        duration = matching_flights.iloc[0]['duration']
        available_flights = matching_flights.shape[0]
    else:
        flight_no = 'Unknown'
        duration = 'Unknown'
        available_flights = 0

    return jsonify({
        'predicted_price': predicted_price[0],
        'flight_no': flight_no,
        'duration': duration,
        'available_flights': available_flights
    })

if __name__ == '__main__':
    app.run(debug=True)
