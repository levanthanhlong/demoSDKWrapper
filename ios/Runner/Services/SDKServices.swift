import UIKit
import Flutter
import KalapaSDK
class SDKServices {
    static let shared = SDKServices()

    private init() {}

    func setupKalapaSDK(result: @escaping FlutterResult) {
        let appearance = KLPAppearance.Builder()
            .withLanguage("vi")               // ngôn ngữ
            .withMainColor("3270EA")          // màu button
            .withMainTextColor("000000")      // màu tiêu đề
            .withBtnTextColor("FFFFFF")       // chữ button màu trắng, tương phản
            .withBackgroundColor("FFFFFF")    // nền SDK
            .withIsAnimatedButton(true)
            .withCornerRadiusButton(10)
            .build()

        let config = KLPConfig.Builder(session: "5bb42ea331ee010001a0b7d7438s78vt8g62oul6943cra01xf28u48n")
            .withAppearance(appearance)
            .withBaseUrl(ApiServices.baseURLString)
            .withResultHandler(self._resultHandler(_:))
            .withShowLoadingHandler(self._showLoadingHandler(_:))

        Task { @MainActor in
            do {
                let finalConfig = try await config.build()
                guard let rootVC = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
                    result(FlutterError(code: "NO_ROOT_VC", message: "Cannot find rootViewController", details: nil))
                    return
                }

                // START SDK
//                Kalapa.shared.run(flowType: KLPFlowType.nfc_only(mrz: nil, faceData: nil), withConfig: finalConfig)
                Kalapa.shared.run(flowType: .ekyc, withConfig: finalConfig)
                result(true)
            } catch {
                print(error)
                result(FlutterError(code: "BUILD_ERROR", message: "\(error)", details: nil))
            }
        }
    }

    private func _resultHandler(_ result: KalapaSDK.KalapaResult?) {
        print("Result: \(String(describing: result))")
    }

    private func _cancelSessionHandler() {
        print("User cancelled the flow")
    }

    private func _expiredHandler() {
        print("Session expired")
    }

    private func _showLoadingHandler(_ fromVC: UIViewController?) {
        print("Show loading")
    }

    private func _hideLoadingHandler() {
        print("Hide loading")
    }
}
