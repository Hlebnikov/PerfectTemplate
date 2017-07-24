

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer


let helloHandler: RequestHandler = {_,response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
    response.completed()
}

let checkCodeHandler: RequestHandler = {request, response in
    response.setBody(string: request.uri)
    if let codeText = request.queryParams.first?.1 {
        if let code = Int(codeText) {
            if code == 3333 {
                let responseDict = ["success": "true"]
                let jsonString = try! responseDict.jsonEncodedString()
                response.setBody(string: jsonString)
            } else {
                let responseDict = ["success": "true"]
                let jsonString = try! responseDict.jsonEncodedString()
                response.setBody(string: jsonString)
            }
        }
    }
    response.completed()
}

let server = HTTPServer()
var routes = Routes()

routes.add(method: .get, uri: "/hello", handler: helloHandler)
routes.add(method: .get, uri: "/auth/code", handler: checkCodeHandler)
server.addRoutes(routes)
server.serverPort = 8181

do {
	try server.start()
} catch PerfectError.networkError(let error, let msg) {
	fatalError("\(error)\n\(msg)") // fatal error launching one of the servers
}

