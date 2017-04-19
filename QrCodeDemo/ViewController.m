//
//  ViewController.m
//  QrCodeDemo
//
//  Created by pzj on 2017/4/11.
//  Copyright © 2017年 pzj. All rights reserved.
//

#import "ViewController.h"
#import "ScanViewController.h"
#import "UIImage+QRCode.h"

@interface ViewController ()<ScanViewControllerDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *qrCodelImage;

@end

@implementation ViewController
{
    UILabel *scanResult;
    UITextField *textField;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"二维码";
    
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [scanBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(sacnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanBtn];
    
    scanResult = [[UILabel alloc] init];
    scanResult.textColor = [UIColor lightGrayColor];
    scanResult.font = [UIFont systemFontOfSize:14];
    [scanResult sizeToFit];
    [self.view addSubview:scanResult];
    
    textField = [[UITextField alloc] init];
    textField.delegate = self;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
    
    UIButton *creatQrCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [creatQrCodeBtn setTitle:@"生成二维码" forState:UIControlStateNormal];
    [creatQrCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [creatQrCodeBtn addTarget:self action:@selector(creatQrBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:creatQrCodeBtn];

    [scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(50);
    }];

    [scanResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scanBtn.mas_bottom).offset(5);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
    }];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scanBtn.mas_bottom).offset(10);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(50);
    }];
    
    [creatQrCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textField.mas_bottom).offset(10);
        make.left.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self qrCodelImage];
    
    [self.qrCodelImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(creatQrCodeBtn.mas_bottom).offset(20);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(100);
        make.left.mas_equalTo(50);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)sacnBtnClick
{
    NSLog(@"扫一扫");
    //扫描二维码的方法在进入的这个vc中
    ScanViewController *vc = [[ScanViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)creatQrBtnClick
{
    //生成二维码的方法：
    NSLog(@"生成二维码");
    NSString *str = textField.text;
    
    if (str.length>0) {
        self.qrCodelImage.image = [UIImage qrImageByContent:str];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请输入文字" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - ScanViewControllerDelegate
- (void)getScanResult:(NSString *)str
{
    scanResult.text = str;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [textField resignFirstResponder];
}

- (UIImageView *)qrCodelImage
{
    if (_qrCodelImage == nil) {
        _qrCodelImage = [[UIImageView alloc] init];
        _qrCodelImage.layer.shadowOffset = CGSizeMake(1, 2);
        [self.view addSubview:_qrCodelImage];
    }
    return _qrCodelImage;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
