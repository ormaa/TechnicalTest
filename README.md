# TechnicalTest

This app is a Technical test for DigiSchool, by Olivier ROBIN - 15 Mai 2018

# Notes

This version of the project is written in Swift 4.1 for IOS 11.0
without any external framework, in order to deliver something purely "Apple" style.

Some improvement could be done by using Alamofire, to do web service call,
rxSwift to bind the data to tableView, searchBar,
and SwiftyJson to have elegant solution to parse JSON datas.

if I have anough time, check the repositoery, I could try to add a branch, with an implementation using Alamofire, rxSwift, and may be Swifty  JSON.

# Design pattern

I chose something sililar to MVVM pattern.
To be short :
MVVM class is called by ViewController to get the datas.
the MVVM class manage the webservice call to get datas ( or to send datas when needed... this is not the case here)
it manage the JSON conversion, and format the datas to be usable by ViewController.
