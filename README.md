# Take Home chromedriver
Swift (5.3.2) based playground implementation of Webdriver protocol

## Prerequisites
- XCode v11.7 or higher
## How to run
1. Open the project in XCode
2. Download [chrome driver](https://chromedriver.chromium.org/downloads)
3. Start chrome driver locally from terminal using below command
        ```./chromedriver -default```
4. Update the ``driverUrl``  variable in playground to the address chromedriver is running on
5. Execute Playground
6. Enjoy! ;)

<p  align="center">
<img src="/resources/Class_Diagram_Take_Home.png"  width="90%" title="Class_Diagram"/>
</p>

## References

- https://w3c.github.io/webdriver/
- https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html#
- https://www.appcoda.com/learnswift/get-started.html
- https://learnappmaking.com/urlsession-swift-networking-how-to/
- https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html
 
## Project Structure
```
|____Postman Collections
| |____WebDrive API Env.postman_environment.json
| |____WebDriver Endpoints.postman_collection.json
|____TakeHomeTest.playground
| |____Sources
| | |____Utilities.swift
| | |____HTTPRequest.swift
| | |____Command.swift
| | |____UnitTests.swift
| | |____BrowserDriver.swift
|____resources
| |____.DS_Store
| |____Class_Diagram_Take_Home.png
| |____geckodriver
| |____Class_Diagram_Take_Home.drawio
| |____chromedriver
|____README.md
|____.gitignore
```
## Author
Prashant Kabra
