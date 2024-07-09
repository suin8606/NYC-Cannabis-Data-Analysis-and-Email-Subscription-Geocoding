# NYC Cannabis Data Analysis: Linear Regression, Clustering, and Mapping
## Overview
This project contains data analysis and visualization scripts for NYC cannabis data and email subscription geocoding. The analysis is performed using Python and R, showcasing different aspects of data handling, geocoding, and visualization.

## Files
* NYC_Cannabis_Linear_Regression_Clustering_and_Mapping.ipynb: A Jupyter notebook written in Python for analyzing cannabis data in NYC. It includes data loading, cleaning, exploratory data analysis (EDA), linear regression, clustering, and mapping using Folium.
* Email_Subscription_Geocoding_and_Visualization.R: An R script for geocoding email subscription addresses and creating interactive maps. It demonstrates how to handle geocoding, data summarization, and visualization using leaflet and ggplot2.
## Project Details
NYC Cannabis Data Analysis: Linear Regression, Clustering, and Mapping (Python)
This Jupyter notebook performs the following tasks:

1. Data Loading: Reads the cannabis data into a Pandas DataFrame.
2. Data Cleaning and Preprocessing: Handles missing values, filters data, and performs feature engineering.
3. Exploratory Data Analysis (EDA): Uses various plotting libraries like Matplotlib and Seaborn to visualize data distributions and correlations.
4. Linear Regression: Applies linear regression to model relationships within the data.
5. Clustering: Uses clustering techniques to group similar data points.
6. Mapping: Generates interactive maps using Folium to visualize spatial data.
   
## Email Subscription Geocoding and Visualization (R)
This R script handles geocoding and visualization of email subscription data:

1. Data Loading: Reads the email subscription data from a CSV file.
2. Data Cleaning: Processes the data by converting column names to lower case and handling missing values.
3. Geocoding: Uses the tidygeocoder package to geocode addresses and manually sets coordinates for missing values.
4. Mapping: Creates an interactive map using leaflet and adds markers based on geocoded data.
5. Summarization and Visualization: Groups data by state, summarizes the count, and creates bar plots to visualize email registrations by year using ggplot2.
