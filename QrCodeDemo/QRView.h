//
//  QRView.h
//  QrCodeDemo
//
//  Created by pzj on 2017/4/11.
//  Copyright © 2017年 pzj. All rights reserved.
//

/**
 * 二维码扫描
 */
#import <UIKit/UIKit.h>

@class QRView;

@protocol QRViewDelegate <NSObject>
/**
 代理回调扫描结果

 @param view 扫一扫试图
 @param result 扫描结果
 */
- (void)qrView:(QRView *)view ScanResult:(NSString *)result;

@end

@interface QRView : UIView<QRViewDelegate>

@property (nonatomic,weak)id<QRViewDelegate>delegate;

@property (nonatomic, assign, readonly) CGRect scanViewFrame;

- (void)startScan;
- (void)stopScan;

@end
