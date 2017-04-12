# QrCodeDemo
系统原生方法生成二维码、扫描二维码demo
### 说明
#### 扫描二维码：
- 扫描二维码view封装到QRView中，
- 使用方法：实例化QRView这个view遵循其代理方法，并实现代理方法，代理方法中得到的就是扫描后的结果。代码如下

```
- (void)viewDidLoad {
[super viewDidLoad];
   self.title = @"扫一扫";
   _qrView = [[QRView alloc] initWithFrame:self.view.bounds];
_qrView.delegate = self;
   [self.view addSubview:_qrView];
}

#pragma mark - QRViewDelegate --- 扫描的结果
- (void)qrView:(QRView *)view ScanResult:(NSString *)result
{
[view stopScan];
NSLog(@"扫描结果：%@",result);
//根据扫描结果执行相应的操作。。。(跳转等。。。)
   /*
    * 这个里面是得到结果后执行的相应的操作
   if ([self respondsToSelector:@selector(getScanResult:)]) {
[self.delegate getScanResult:result];
[self.navigationController popViewControllerAnimated:YES];
}
   */
} 
```
#### 生成二维码：
- 生成二维码：是给UIImage写了一个category --- UIImage+QRCode
- 使用方法：实例化一个展示二维码的UIImageView，UIImageView的image 调用写好的方法即可。代码如下

```
  _qrCodelImage = [[UIImageView alloc] init];
_qrCodelImage.layer.shadowOffset = CGSizeMake(1, 2);
  [self.view addSubview:_qrCodelImage];

  //这里用Masonry来处理的尺寸具体使用方法可网上查找
  [_qrCodelImage mas_makeConstraints:^(MASConstraintMaker *make) {
make.top.equalTo(creatQrCodeBtn.mas_bottom).offset(20);
make.height.mas_equalTo(100);
make.width.mas_equalTo(100);
make.left.mas_equalTo(50);
}];

   //生成二维码 ---- 这一句是关键
   NSString *str = @"需要生成二维码的内容";
_qrCodelImage.image = [UIImage qrImageByContent:str];

```
