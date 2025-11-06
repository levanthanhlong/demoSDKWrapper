import Foundation

class ApiServices {
    
    static let shared = ApiServices()
    static let baseURLString1 = "http://192.168.1.43:3000"
    static let baseURLString = "https://ekyc-api.kalapa.vn"
    static let baseURLString2 = "https://yourserver.com"
    
    private init() {}
    
    /// Gọi API để tạo session ID (JWT)
    func getSessionId1(completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "/(ApiServices.shared.baseURLString)/auth/get-token") else {
            completion(nil)
            return      
        }
        // Body request
        let body: [String: Any] = [
            "flow": "nfc_only"
        ]
        
        // Convert body sang JSON
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            completion(nil)
            return
        }
        
        // Tạo request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Gọi API
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ API error:", error)
                completion(nil)
                return
            }
            
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let token = json["token"] as? String else {
                print("⚠️ Invalid response")
                completion(nil)
                return
            }
            
            print("✅ Session ID:", token)
            completion(token)
        }
        
        task.resume()
    }
    func initialSession() async -> String? {
        guard let url = URL(string: "\(ApiServices.baseURLString)/auth/get-token") else {
            print("❌ Invalid URL")
            return nil
        }
        
        let body: [String: Any] = [
            "flow": "nfc_only"
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            print("❌ Cannot encode body to JSON")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                print("⚠️ Invalid HTTP response")
                return nil
            }
            
            // Parse JSON
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let token = json["token"] as? String else {
                print("⚠️ Invalid JSON format or missing token")
                return nil
            }
            
            print("✅ Successfully logged in with token: \(token)")
            return token
            
        } catch {
            print("❌ Request failed: \(error)")
            return nil
        }
    }

}
