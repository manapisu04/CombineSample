////
////  WebSocket.swift
////  CCCUltimate
////
////  Created by cmStudent on 2022/07/12.
////
//
//import Foundation
//
//class WebSocket {
//    static let shared = WebSocket()
//    var webSocketTask: URLSessionWebSocketTask
//
//    private init() {
//        // FIXME: URLなおせ
//        let request = URLRequest(url: URL(string: "~~~")!)
//        let urlSession = URLSession(configuration: .default)
//        self.webSocketTask = urlSession.webSocketTask(with: request)
//        self.webSocketTask.resume()
//    }
//
//    func session(request: URLRequest) {
//
////        webSocketTask.send(<#T##message: URLSessionWebSocketTask.Message##URLSessionWebSocketTask.Message#>, completionHandler: <#T##(Error?) -> Void#>)
//    }
//
//    func send(data: Data) {
//        let sendData = URLSessionWebSocketTask.Message.data(data)
//        webSocketTask.send(sendData) { error in
//            guard let _ = error else {
//                //FIXME: なんかここに処理あると親切失敗したぜ〜とか
//                //TODO: こんばいん
//                return
//            }
//        }
//    }
//}
//
//// うーん、送るしなぁ、、、でこーだぶるか？
//struct SendMassage: Decodable {
//    let id: Int
//    let user: String
//    let message: String
//}
