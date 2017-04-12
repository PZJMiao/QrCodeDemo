//
//  ScanViewController.h
//  QrCodeDemo
//
//  Created by pzj on 2017/4/11.
//  Copyright © 2017年 pzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScanViewControllerDelegate <NSObject>

- (void)getScanResult:(NSString *)str;

@end

@interface ScanViewController : UIViewController<ScanViewControllerDelegate>

@property (nonatomic, weak) id<ScanViewControllerDelegate>delegate;

@end
