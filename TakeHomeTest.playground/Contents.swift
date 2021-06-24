/*
@Take Home Test
Part 1: Write a program to make an http requests using Swift
Part 2: Extend the above program to make an http request to chromedriver and launch a chrome browser session
Part 3: Launch icloud.com page

Pre-requisites

Step1 : Download chrome driver(https://sites.google.com/a/chromium.org/chromedriver/)
Step2 : Start chrome driver locally
    ./chromedriver -default

This function can be used to excute Http requests using URL
Part 1: Write a program to make an http requests using Swift

Part 1: Make HTTP requests

Part 2: Extend the above program to make an http request to chromedriver and launch a chrome browser session

Part 3: Launch icd.com

*/

/**
 - Class Diagram
 - Code Walkthrough
 - Demo
 - Q&A
*/

print("=== Start of Playgroud ===")

//chrome
let driverUrl="http://localhost:9515/"

//firefox
//let driverUrl="http://localhost:4444/"

let browserDriver:BrowserDriver

do{

    browserDriver=try BrowserDriver(driverURL:driverUrl)

    try browserDriver.maximizeWindow()
    try browserDriver.navigateTo(url: "https://www.icloud.com/")
//    try browserDriver.deleteSession()

}
catch BrowserDriverError.HttpRequestError(let msg) {
    print("HttpRequestError: \(msg)")
}
catch let error as BrowserDriverError{
    print("BrowserDriverError: \(error)")
}
catch{
    print("Other error: \(error)")
}

test_ActionAfterSessionDeleted()
test_InvalidNagivationUrl()
test_ValidScenario()
test_InvalidDriverUrl()

print("=== End of Playgroud ===")

