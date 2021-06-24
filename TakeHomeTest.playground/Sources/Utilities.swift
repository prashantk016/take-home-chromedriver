import Foundation

public enum HTTPMethod:String{
    case GET, POST, DELETE, PUT, PATCH, OPTIONS, HEAD
}

/**
 This method takes a dictionary as an argument and return the Json serialization of the argument
 */
public func parseDictToJSONData(_ toParse: [String:Any]) -> Data? {
    
    let data=try? JSONSerialization.data(
        withJSONObject: toParse,
        options: []
    )
    return data
}
