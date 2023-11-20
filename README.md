
# TIME SERIES ANALYSIS IN R ( PROJECT) 
In mathematics, a time series is a series of data points indexed in time order. Most commonly, a time series is a sequence taken at successive equally spaced points in time. Thus it is a sequence of discrete-time data.
In the broadest definition , a time series is any data set where the values are measured at different points in time. Many time series are uniformly spaced at a specific frequency, for example, hourly weather measurements, daily counts of web site visits, or monthly sales totals. Time series can also be irregularly spaced and sporadic, for example, timestamped data in a computer system’s event log .
Working with a time series of energy data we’ll see how techniques such as time-based indexing, resampling, and rolling windows can help us explore variations in electricity demand and renewable energy supply over time.
Aspects of the data set: 
•	The data set: Open Power Systems Data
•	Time series data structures
•	Time-based indexing
•	Visualizing time series data
•	Seasonality 
•	Frequencies
•	Trends7

# Explaining Dataset: 
Electricity production and consumption are reported as daily totals in gigawathh-hours. The columns of the data file are 
* date -> the date (yyyy-mm-dd format)
* consumption -> electricity consumption in GWh 
* Wind w->wind power production in GWh 
* Solar -> Solar power production in GWh 
* Wind+Solar -> Sum of wind and solar power production in GWh 
also in this project we will explore how electricity consumption and production in Germany have varied over time. 

# Time Series Analysis: 
In the project we've answered mainly these following questions: 

* when is electricity consumption typically highest and lowest? 
* how do wind and solar power production vary with seasons of the year? 
* what are the long-term trends in electricity consumption, solar power and wind power? 
* how do wind and solar power production compare with electricity consumption and how has this ratio changed over time ? 
For the explanation of the plots and the results, you can find them below the word file titled PROJECT R visualization and notes done after wrangling and cleaning the data. 
