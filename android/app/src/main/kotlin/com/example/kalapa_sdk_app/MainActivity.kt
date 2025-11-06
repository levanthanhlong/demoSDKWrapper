package com.example.kalapa_sdk_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {
    private val chanel = "sdk_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            chanel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "setupSDK" -> {
                   // IOKyc ioKyc = new IOKyc(APP_ID, LICENSE_KEY, false);
                    //val ioKyc: IOKyc = IOKyc(APP_ID, LICENSE_KEY, false)





//                    val config = CmcEkycConfig(
//                        session = "",
//                        baseUrl = "",
//
//                        )
//
//                    CmcEkycSdkMain.setupSDK(this, config)


                    //                   CmcEkycSdkMain.sayHello()
//                    val config = CmcEkycConfig(
//
//                    )
                    // CmcEkycSdkMain.setupSDK()
//                    CmcEkycSdkMain.setupSDK(this)
//                    CmcEkycSdkMain.setupSDK(
//                        activity = this,             // Activity hiện tại
//                        session = "SESSION_ID_HERE", // Mỗi lần xác thực cần session
//                        baseUrl = "http://192.168.1.43:3000", // Base URL của backend
//                        language = "vi",             // "vi" hoặc "en"
//                        mainColor = "#62A583",
//                        backgroundColor = "#FFFFFF",
//                        mainTextColor = "#65657B",
//                        btnTextColor = "#FFFFFF",
//                        livenessVersion = 1,         // version kiểm tra sống động
//                        valueNFCTimeoutSeconds = 180,
//                        isRequireQRCode = false,
//                        documentType = CmcEkycSdkMediaType.FRONT,
//                        enableStrictLiveness = false,
//                        customer = null,
//                        mrz = null,
//                        faceData = null,
//                        leftoverSession = null,
//                        flow = "ekyc",
//                        onComplete = { result ->
//                            // Khi xác thực thành công
//                            Log.d("eKYC", "Result: $result")
//                        },
//                        onError = { code ->
//                            // Khi có lỗi
//                            Log.e("eKYC", "Error: $code")
//                        },
//                        onExpired = {
//                            // Khi session hết hạn
//                            Log.w("eKYC", "Session expired")
//                        }
//                    )

                    result.success(1)
                }

                else -> result.notImplemented()
            }
        }
    }

}
