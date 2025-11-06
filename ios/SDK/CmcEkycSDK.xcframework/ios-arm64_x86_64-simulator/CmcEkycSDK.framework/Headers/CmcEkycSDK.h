//
//  CmcEkycSDK.h
//  CmcEkycSDK
//
//  Created by Thành on 31/10/2025.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//! Project version number for CmcEkycSDK.
FOUNDATION_EXPORT double CmcEkycSDKVersionNumber;

//! Project version string for CmcEkycSDK.
FOUNDATION_EXPORT const unsigned char CmcEkycSDKVersionString[];

/// SDK chính của CmcEkyc (wrapper cho KalapaSDK)
@interface CmcEkycManager : NSObject

/// Singleton instance (truy cập bằng [CmcEkycManager shared])
+ (instancetype)shared;

/// Bắt đầu flow eKYC.
///
/// @param viewController UIViewController hiện tại để trình bày flow.
/// @param session Chuỗi session eKYC (do backend tạo).
/// @param baseUrl API base URL.
/// @param language Ngôn ngữ giao diện (mặc định: "vi").
/// @param mainColor Màu chính của giao diện.
/// @param btnTextColor Màu chữ của nút.
/// @param backgroundColor Màu nền giao diện.
/// @param isAnimatedBtn Có bật animation cho nút không.
/// @param cornerRadiusBtn Độ bo góc của nút.
/// @param flowType Kiểu luồng eKYC (1: ekyc, 2: nfcEkyc, 3: nfcOnly, 4: passport).
/// @param mrz Chuỗi MRZ (nếu có, chỉ dùng cho flow NFC).
/// @param faceData Dữ liệu khuôn mặt (nếu có, chỉ dùng cho flow NFC-only).
/// @param onResult Callback khi hoàn thành.
/// @param onEvent Callback khi có event.
/// @param onShowLoading Callback hiển thị loading.
/// @param onHideLoading Callback ẩn loading.
/// @param onShowError Callback hiển thị lỗi.
/// @param onTimeoutScanNFC Callback khi NFC scan timeout.
- (void)startEkycFrom:(UIViewController *)viewController
              session:(NSString *)session
              baseUrl:(NSString *)baseUrl
             language:(nullable NSString *)language
            mainColor:(nullable NSString *)mainColor
         btnTextColor:(nullable NSString *)btnTextColor
      backgroundColor:(nullable NSString *)backgroundColor
        isAnimatedBtn:(BOOL)isAnimatedBtn
      cornerRadiusBtn:(CGFloat)cornerRadiusBtn
             flowType:(NSInteger)flowType
                  mrz:(nullable NSString *)mrz
             faceData:(nullable NSString *)faceData
             onResult:(nullable void (^)(id _Nullable result))onResult
              onEvent:(nullable void (^)(NSString *event))onEvent
        onShowLoading:(nullable void (^)(void))onShowLoading
        onHideLoading:(nullable void (^)(void))onHideLoading
          onShowError:(nullable void (^)(NSString *_Nullable message, UIViewController *fromVC))onShowError
      onTimeoutScanNFC:(nullable void (^)(void (^_Nullable completion)(void)))onTimeoutScanNFC;

/// Convert Field object to NSDictionary.
/// @param field Đối tượng Field (ẩn implementation bên trong SDK).
- (nullable NSDictionary<NSString *, id> *)fieldToDictionary:(nullable id)field;

@end

NS_ASSUME_NONNULL_END
