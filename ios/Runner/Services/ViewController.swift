import UIKit
import CmcEkycSDK

class ViewController: UIViewController {
    
    static let shared =  ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("do")
        Task {
            do {
                try await startEkycFlow()
            } catch {
                print("Lỗi khi chạy eKYC: \(error)")
            }
        }
    }
    
    // MARK: - Gọi SDK
    public func startEkycFlow() async throws {
        
        print("do get session")
        //let sessionID = await ApiServices.shared.initialSession()
        
//        if sessionID == "" {
//            print("No session ID")
//            return
//        }else{
//            print("sessionID: \(sessionID!)")
//        }
        //5bb42ea331ee010001a0b7d7438s78vt8g62oul6943cra01xf28u48n
        Task {
            await CmcEkycManager.shared.startEkyc(
                from: self,
                session: "5bb42ea331ee010001a0b7d7438s78vt8g62oul6943cra01xf28u48n",
                baseUrl: ApiServices.baseURLString,
                language: "vi",
                mainColor: "#6CB096",
                btnTextColor: "#FFFFFF",
                backgroundColor: "#FFFFFF",
                isAnimatedBtn: true,
                cornerRadiusBtn: 10,
                flowType: 3,
                mrz: "",
                faceData: "",
                onResult: { [weak self] result in self?.handleResult(result) },
                onEvent: { [weak self] event in self?.handleEvent(event) },
                onShowLoading: { [weak self] in self?.showLoading() },
                onHideLoading: { [weak self] in self?.hideLoading() },
                onShowError: { [weak self] msg, vc in self?.handleError(msg, fromVC: vc) },
                onTimeoutScanNFC: { [weak self] completion in self?.handleTimeoutNFC(completion)}
            )
        }
    }
    
    
    // MARK: - Callback: Kết quả eKYC
    func handleResult(_ result: Any?) {
        print("eKYC hoàn tất, kết quả: \(String(describing: result))")
        
        // Nếu muốn chuyển về dictionary:
        if let result = result as? NSDictionary {
            print("Kết quả dưới dạng dictionary: \(result)")
        }
        
        // Hiển thị popup
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Hoàn tất", message: "eKYC thành công", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    
    // MARK: - Callback: Event (như trạng thái chụp ảnh, đọc NFC...)
    func handleEvent(_ event: String) {
        print("Sự kiện eKYC: \(event)")
    }
    
    
    // MARK: - Callback: Hiện Loading
    func showLoading() {
        print("Hiển thị loading")
        
        // ví dụ hiện spinner
        DispatchQueue.main.async {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.center = self.view.center
            indicator.startAnimating()
            indicator.tag = 999
            self.view.addSubview(indicator)
        }
    }
    
    
    // MARK: - Callback: Ẩn Loading
    func hideLoading() {
        print("Ẩn loading")
        
        DispatchQueue.main.async {
            if let indicator = self.view.viewWithTag(999) as? UIActivityIndicatorView {
                indicator.removeFromSuperview()
            }
        }
    }
    
    
    // MARK: - Callback: Hiển thị lỗi
    func handleError(_ message: String?, fromVC: UIViewController) {
        print("Lỗi eKYC: \(message ?? "Không xác định")")
        
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Lỗi",
                message: message ?? "Đã xảy ra lỗi không xác định",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Đóng", style: .default))
            fromVC.present(alert, animated: true)
        }
    }
    
    
    // MARK: - Callback: Timeout NFC
    func handleTimeoutNFC(_ completion: (() -> Void)?) {
        print("NFC Timeout")
        
        let alert = UIAlertController(
            title: "Hết thời gian quét NFC",
            message: "Bạn có muốn thử lại không?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Thử lại", style: .default, handler: { _ in
            completion?() // gọi lại completion để SDK chạy lại NFC
        }))
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel))
        self.present(alert, animated: true)
    }
}
