### Fitofit
This is an application tracking distance user walked. It uses Google Maps API to
find shortest walking distance between two addresses and log it as an activity.

Live version of application: https://fit-o-fit.herokuapp.com

### Setup

To run locally, you have to have Ruby version 3.0.2 installed on your machine.
Then clone repository"
```
git clone https://github.com/WisniewskiMJ/fit-o-fit
```
Next you have to execute 
```
.bin/setup
```
which will install bundler and create database. 
Then you have to run 
```
bundle exec rails server
```
and the app will be available at __localhost:3000__ in your browser.

Then you have to provide Google Maps API key and put it into .env file:
```
GMAPS_API_KEY = your_API_key
```
to allow connection to Google Maps API.

### To do

This is basic version of application, due to time limit. Things that need to be added:

* Landing page
* Refactor error messages
* Tests