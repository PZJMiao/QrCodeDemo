//
//  ScanViewController.m
//  QrCodeDemo
//
//  Created by pzj on 2017/4/11.
//  Copyright © 2017年 pzj. All rights reserved.
//

#import "ScanViewController.h"
#import "QRView.h"

@interface ScanViewController ()<QRViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) QRView *qrView;

@end

@implementation ScanViewController
#pragma mark - lifeCycle                    - Method -
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫一扫";
    /**
     * 调用扫描二维码的view的方法
     * 遵循代理，实现代理方法
     */
    [self.view addSubview:self.qrView];
}

#pragma mark - privateMethods               - Method -

#pragma mark - eventResponse                - Method -

#pragma mark - notification                 - Method -

#pragma mark - customDelegate               - Method -
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
//选择相册中的二维码图片进行识别
- (void)selectPhotoQRCode
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark - objective-cDelegate          - Method -
#pragma mark - UINavigationControllerDelegate,UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //获取选中的照片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    //初始化 将类型设置为二维码
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
    [picker dismissViewControllerAnimated:YES completion:^{
        //设置数组，放置识别完之后的数据
        NSArray *features = [detector featuresInImage:[CIImage imageWithData:UIImagePNGRepresentation(image)]];
        //判断是否有数据（即是否是二维码）
        if (features.count >= 1) {
            //取第一个元素就是二维码所存放的文本信息
            CIQRCodeFeature *feature = features[0];
            NSString *scannedResult = feature.messageString;
            //通过对话框的形式呈现
            [self alertControllerMessage:scannedResult];
        }else{
            [self alertControllerMessage:@"这不是一个二维码"];
        }
    }];
}

//由于要写两次，所以就封装了一个方法
- (void)alertControllerMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - getters and setters          - Method -
- (QRView *)qrView
{
    if (_qrView == nil) {
        _qrView = [[QRView alloc] initWithFrame:self.view.bounds];
        _qrView.delegate = self;
        _qrView.isHasFlash = NO;//闪光灯 关闭与否
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
