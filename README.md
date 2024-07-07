# FlightBookingApp-WithRandomForestPricePrediction
This repository contains a Flutter-based flight booking application integrated with a machine-learning model for flight price prediction. The backend uses a Flask API and a Random Forest Regressor to predict flight prices based on departure and arrival cities, travel class, and stop preferences.

<img width="315" alt="Ekran Resmi 2024-07-03 02 00 44" src="https://github.com/esradag/FlightBookingApp-WithRandomForestPricePrediction/assets/73072424/37f20afe-9f2f-4a15-b5bc-7f67c044c876">

<img width="318" alt="Ekran Resmi 2024-07-03 02 00 37" src="https://github.com/esradag/FlightBookingApp-WithRandomForestPricePrediction/assets/73072424/3694de9a-517e-447b-8ad1-6b84d0882401">

<img width="321" alt="Ekran Resmi 2024-07-03 02 00 18" src="https://github.com/esradag/FlightBookingApp-WithRandomForestPricePrediction/assets/73072424/16792936-3d98-44ba-bd65-e4792cb6b8fe">

## Features
### Flight Search and Booking
- Search for flights based on various criteria including departure and arrival cities, travel dates, number of passengers, and class of travel.
- Toggle between one-way and round-trip options.
- Filter results to show nonstop flights first.

### Date Selection
- Choose departure and return dates with a user-friendly date picker.
- View flight options for the next seven days.

### Passenger and Bag Selection
- Specify the number of adults, children, and bags for the trip.

### Price Prediction
- Backend integration with a Flask API.
- Random Forest model predicts flight prices based on input features.
- Display the predicted price, flight number, and duration.

### User Interface
- Clean and modern UI with easy navigation.
- Dropdown menus for city and passenger selections.
- Switch for nonstop flight preference.

## Backend

### Flask API
- Handles requests for price predictions.
- Utilizes a Random Forest Regressor trained on a dataset of flight prices.
- Responds with predicted prices and additional flight information.

### Machine Learning Model
- Random Forest Regressor for price prediction.
- Preprocessed and encoded flight data for training.
- Model training and evaluation included.

## Dataset

The dataset used for training the machine learning model is sourced from Kaggle and is available [here](https://www.kaggle.com/datasets/shubhambathwal/flight-price-prediction). Below is a detailed description of the dataset and its columns.

### Dataset Description

#### Overview
The dataset consists of flight details for various routes in India, including information on the airline, the departure and arrival cities, the duration of the flight, the number of stops, and the price. This dataset is useful for building machine learning models to predict flight prices based on these features.

#### Columns

1. **Airline**: The airline operating the flight (e.g., Jet Airways, IndiGo, Air India).
2. **Date_of_Journey**: The date when the journey is scheduled.
3. **Source**: The departure city (e.g., Delhi, Mumbai, Bangalore).
4. **Destination**: The arrival city (e.g., Cochin, Kolkata).
5. **Route**: The route taken by the flight.
6. **Dep_Time**: The departure time of the flight.
7. **Arrival_Time**: The arrival time of the flight.
8. **Duration**: The duration of the flight.
9. **Total_Stops**: The number of stops between the source and destination.
10. **Additional_Info**: Additional information about the flight.
11. **Price**: The price of the ticket.

### Data Preparation
The dataset is preprocessed by encoding categorical variables and handling missing values. Features such as the source city, destination city, and travel class are converted to numerical data using label encoding. The target variable is the flight price.

## Getting Started

### Prerequisites
- **Flutter SDK**
- **Python 3.7+**
- **Flask**

### Installation

#### Flutter Frontend
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/FlightBookingApp-WithRandomForestPricePrediction.git
