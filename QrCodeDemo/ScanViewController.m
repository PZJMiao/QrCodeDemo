//
//  ScanViewController.m
//  QrCodeDemo
//
//  Created by pzj on 2017/4/11.
//  Copyright © 2017年 pzj. All rights reserved.
//

#import "ScanViewController.h"
#import "QRView.h"

@interface ScanViewController ()<QRViewDelegate>

@property (nonatomic, strong) QRView *qrView;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫一扫";
    /**
     * 调用扫描二维码的view的方法
     * 遵循代理，实现代理方法
     */
    [self.view addSubview:self.qrView];
}

#pragma mark - QRViewDelegate --- 扫描的结果
- (void)qrView:(QRView *)view ScanResult:(NSString *)result
{
    [view stopScan];
    NSLog(@"扫描结果：%@",result);
    //根据扫描结果执行相应的操作。。。(跳转等。。。)
    if ([self respondsToSelector:@selector(getScanResult:)]) {
        [self.delegate getScanResult:result];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (QRView *)qrView
{
    if (_qrView == nil) {
        _qrView = [[QRView alloc] initWithFrame:self.view.bounds];
        _qrView.delegate = self;
    }
    return _qrView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
