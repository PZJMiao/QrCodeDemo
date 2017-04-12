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
    if ([self respondsToSelector:@selector(getScanResult:)]) {
        [self.delegate getScanResult:result];
        [self.navigationController popViewControllerAnimated:YES];
    }
} 
```
