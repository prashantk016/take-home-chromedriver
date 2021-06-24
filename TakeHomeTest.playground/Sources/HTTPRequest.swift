import Foundation

public class HTTPRequest{
    
    let session = URLSession.shared
   
    /**
     This method make a synchronous http request. It takes the url and http method as required arguments along with headers and request body
     
     - Parameters:
        - urlString: the url  to make the http request to
        - httpMethod: valid http method of request to make
        - headers: headers to add to the request
        - body: value content of the request body
     - Returns: A dictionary containing the result of the request after completion.
     The dictionary contains key 'error' with value if an error had occured when trying to execute the request OR it contains keys 'body' and 'response' with value when the request was executed successfully
     
     Note: This method does not throws an error if the request failed it. It returns the results and expects the calling method to verify results and throw any error as needed
     */
    public func makeHTTPRequest(urlString:String, httpMethod:HTTPMethod, headers:[String:String]=[:], httpBody:Data?=parseDictToJSONData([:])) -> (Error?,HTTPURLResponse?,Data?){
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        ///setting headers in request object
        for(value,headerField) in headers {
                   request.setValue(value, forHTTPHeaderField:headerField)
        }
       
        /// Setting http body data if not nil
        if let httpBody = httpBody{
            request.httpBody=httpBody
        }
     
        return makeHTTPRequest(request:request)

    }
    
    /**
    This method make a synchronous http request. It takes an URLRequest argument
    
    - Parameter request: URLRequest instance
    - Returns: A dictionary containing the result of the request after completion.
    The dictionary contains key 'error' with value if an error had occured when trying to execute the request OR it contains keys 'body' and 'response' with value when the request was executed successfully
    
    Note: This method does not throws an error if the request failed it. It returns the results and expects the calling method to verify results and throw any error as needed
    */
    public func makeHTTPRequest(request:URLRequest) -> (Error?,HTTPURLResponse?,Data?){
    
        var error:Error?
        var response:HTTPURLResponse?
        var data:Data?
        
        let semaphore = DispatchSemaphore(value: 0)
        // Execute HTTP request
        let task = session.dataTask(with: request) { (_data, _response, _error) in

            defer{
                semaphore.signal()
            }
            
            error=_error
            response=_response as? HTTPURLResponse
            data=_data
       
        }
        task.resume()
        semaphore.wait()
        
        return (error, response, data)

    }
}
