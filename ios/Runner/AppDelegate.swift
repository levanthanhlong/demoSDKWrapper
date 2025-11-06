import Flutter
import UIKit
import KalapaSDK
import CmcEkycSDK
@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        guard let controller = window?.rootViewController as? FlutterViewController else {
            fatalError("rootViewController is not FlutterViewController")
        }
        
        let channel = FlutterMethodChannel(name: "kalapa_sdk_channel", binaryMessenger: controller.binaryMessenger)
        
        channel.setMethodCallHandler { (call, result) in
            switch call.method {
            case "setupSDK":
                //                Task{
                //                    //let vc = ViewController()
                //                    //SDKServices.shared.setupKalapaSDK(result: result);
                //                    // Tạo một view controller để present eKYC
                //                    ViewController.shared.viewDidLoad()
                //                    result(1)
                //                }
                DispatchQueue.main.async {
                    Task {
                        await CmcEkycManager.shared.startEkyc(
                            from: controller,
                            session: "5bb42ea331ee010001a0b7d7438s78vt8g62oul6943cra01xf28u48n",
                            baseUrl: ApiServices.baseURLString2,
                            language: "vi",
                            mainColor: "#6CB096",
                            btnTextColor: "#FFFFFF",
                            backgroundColor: "#FFFFFF",
                            isAnimatedBtn: true,
                            cornerRadiusBtn: 10,
                            flowType: 1,
                            mrz: "",
                            faceData: "",
                            onResult: { resultData in
                                print("✅ eKYC hoàn tất: \(String(describing: resultData))")
                            },
                            onEvent: { event in
                                print("📍 Sự kiện eKYC: \(event)")
                            },
                            onShowLoading: {
                                print("⏳ Hiện loading")
                            },
                            onHideLoading: {
                                print("✅ Ẩn loading")
                            },
                            onShowError: { msg, vc in
                                let alert = UIAlertController(
                                    title: "Lỗi",
                                    message: msg ?? "Đã xảy ra lỗi không xác định",
                                    preferredStyle: .alert
                                )
                                alert.addAction(UIAlertAction(title: "OK", style: .default))
                                vc.present(alert, animated: true)
                            },
                            onTimeoutScanNFC: { completion in
                                print("⏰ NFC Timeout")
                                completion?()
                            }
                        )
                    }
                    result(1)
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

