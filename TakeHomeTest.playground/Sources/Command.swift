/**
 Valid Webdriver commands/operation
 */
public enum Command {
    
    case newSession
    case navigateTo(String)
    case maximize(String)
    case deleteSession(String)
    
    /**
        This method returns the http method and the computed end point of a command
     - Returns: (method:HTTPMethod, endpoint:String)
     */
    func getEndpoint() -> (method:HTTPMethod, endpoint:String){
       switch self {
       case .newSession:
        return (HTTPMethod.POST,"session")
       case let .navigateTo(sessionId):
        return (HTTPMethod.POST,"session/\(sessionId)/url")
       case let .maximize(sessionId):
           return (HTTPMethod.POST,"session/\(sessionId)/window/maximize")
       case let .deleteSession(sessionId):
           return (HTTPMethod.DELETE,"session/\(sessionId)")
       }
    }
}
