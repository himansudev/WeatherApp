-> Weather App
This is a weather app that allows users to search for cities and view today's weather as well as the forecast for the coming days. The app is built using SwiftUI 3.0 (due to system limitations) and provides a seamless, reactive experience for displaying weather data.

-> Features
Search Cities: Allows users to search for a city.
City Selection: Upon selecting a city from the search results, the app navigates to a new screen that displays:
Current weather for today.
Weather forecast for the next few days.
System Limitation
Please note that this app is built using SwiftUI 3.0, which is compatible with iOS 14 and earlier. This version of SwiftUI was chosen due to the limitations of the development environment on the old system used for this project. Therefore, the app leverages the available tools and frameworks in SwiftUI 3.0 to deliver the required features.


-> How It Works
- City Search:

Users can enter a city name in the search bar.
The app makes an API request to fetch cities matching the search query.

City Selection:

After selecting a city from the list, the app navigates to a detailed weather screen showing:
Today's weather
A 5-day weather forecast.


-> Network Connectivity: 
The app assumes that the device has an active internet connection to fetch weather data.

-> Architecture

The app follows the MVVM (Model-View-ViewModel) architecture:

- Model:
The model includes a Weather struct that holds the data for the weather such as temperature, humidity, forecast, etc. The data is fetched from a weather API in JSON format.

- View:
The views are built using SwiftUI 3.0, which includes:
A search screen for searching cities.
A weather details screen to display the current and forecasted weather for a selected city.

- ViewModel:
The ViewModel handles the data manipulation and communicates between the Model and the View. It fetches data from the API and exposes it to the View in a format that is easy to display.


