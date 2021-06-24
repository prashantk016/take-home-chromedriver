import Foundation

public class BrowserDriver{
    
    let driverURL:String
    let httpReq:HTTPRequest
    private var sessionId:String?
  
    public init(driverURL:String) throws {
        self.driverURL=driverURL
        self.httpReq=HTTPRequest()
        self.sessionId=try createNewSession()
        print("SessionId: \(sessionId ?? "No_SessionId")")
    }
    
    /**
     This method takes a `Command` argument along with header and body argument with default values. It calls the makeHTTPRequest function from HTTPRequest class.
     After the makeHTTPRequest is completed, it verifies the response by calling the verifyResponse function and throws an error if any.
     If the request was successful with status code 200-299, it returns the content of the response body as JSON [String:Any]
    
     - Parameters:
         - command : name of the BrwoserDriver command of type Command
         - body: value of body of HTTP request stored as dictionary
         - headers: HTTP headers dictionary.
     - Throws: BrowserDriverError
    */
    func executeCommand(_ command:Command, body:[String:Any]=[:], headers:[String:String]=[:]) throws -> [String:Any]?{
        
        let (httpMethod, endpoint) = command.getEndpoint()
        
        /// Make http request call
        let (error, response, data) = httpReq.makeHTTPRequest(urlString: driverURL+endpoint, httpMethod:httpMethod, headers:headers, httpBody:parseDictToJSONData(body))
        
        var json:[String:Any]?
        
        /// Verifying the results from the http request after completion
        try verifyResponse(error:error,response:response,data:data)
       
        if let data = data{
           json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
           json = json?["value"] as? [String:Any]
        }
        
        return json
    }

    /**
     This method creates a new web driver session and returns the session Id of the newly created session
    
     - Parameter capabilities: capabilities of the browser instance. Default value is empty. Example: ["pageLoadStrategy":"eager"]
     - Throws: BrowserDriverError
    */
    func createNewSession(_ capabilities:[String:String] = [:]) throws -> String?{
        
        let headers = ["application/json":"Content-Type"]
        let body:[String:Any] = ["capabilities":capabilities]
        let json = try executeCommand(Command.newSession, body:body, headers:headers)
       
        return json?["sessionId"] as? String
    }
    
    /**
    This method navigates to the specified url for session Id and returns
    
    - Parameters:
     - url:complete url of the page to visit
     - sessionId:valid browser driver session Id
    - Throws: BrowserDriverError
    */
    public func navigateTo(url:String) throws {
        try verifySession()
        let headers = ["application/json":"Content-Type"]
        let body = ["url": url]
        _ = try executeCommand(Command.navigateTo(sessionId!), body:body, headers:headers)
    }

    /**
    This method maximizes the browser window with specified session Id and returns
    
    - Parameter sessionId:valid browser driver session Id
    - Throws: BrowserDriverError
    */
    public func maximizeWindow() throws {
        try verifySession()
        let headers = ["application/json":"Content-Type"]
        _ = try executeCommand(Command.maximize(sessionId!), headers:headers)
    }
    
    /**
     This method deletes the driver session with specified session Id and returns
     
     - Parameter sessionId:valid browser driver session Id
     - Throws: BrowserDriverError
     */
    public func deleteSession() throws {
        try verifySession()
        let headers = ["application/json":"Content-Type"]
        _ = try executeCommand(Command.deleteSession(sessionId!), headers:headers)
    }
    
    /**
     This method verified if the results after execution of a http request was completed successfully
     
     It first checks if the http request failed. If yes, it will throw a `BrowserDriverError.httpRequestError`
     If the request was successfully completed, it verifies if the response status code is 400, 404, 405 or 500; it will throw a `BrowserDriverError.driverRequestError`
     
     - Parameter httpReqResult: Dictionary of [String:Any] returned by makeHTTPRequest with either error or with response and data
     - Throws:`BrowserDriverError`
     */
    func verifyResponse(error:Error?, response:HTTPURLResponse?, data:Data?) throws {
        
        if let error = error{
            throw BrowserDriverError.HttpRequestError(message: String(describing: error))
        }
        
        var responseBody:[String: Any]?
        if let data=data{
            responseBody = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            responseBody = responseBody?["value"] as? [String:Any]
        }
        
        switch response!.statusCode {
        case 400...599:
            throw BrowserDriverError.DriverRequestError(message: responseBody?["message"] as! String)
        default:
            return
        }
    }
    
    /**
     This method verifies if the variable sessionId is not nil. It called before a driver command is executed
     If sessionId is not set it will throw a `BrowserDriverError.NoSessionError`
     - Throws: BrowserDriverError.NoSessionError
     */
    func verifySession() throws {
        if sessionId==nil{
            throw BrowserDriverError.NoSessionError
        }
    }
}

/**
Browser Driver Errors
*/
public enum BrowserDriverError : Swift.Error {
    
    case HttpRequestError(message: String)
    case DriverRequestError(message: String)
    case NoSessionError
}
