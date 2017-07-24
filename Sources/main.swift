

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer


let helloHandler: RequestHandler = {_,response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
    response.completed()
}

let server = HTTPServer()
var routes = Routes()

routes.add(method: .get, uri: "/", handler: helloHandler)
server.addRoutes(routes)
server.serverPort = 8181

do {
	try server.start()
} catch PerfectError.networkError(let error, let msg) {
	fatalError("\(error)\n\(msg)") // fatal error launching one of the servers
}

