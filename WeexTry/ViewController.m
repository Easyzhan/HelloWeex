//
//  ViewController.m
//  WeexTry
//
//  Created by Zin_戦 on 17/2/13.
//  Copyright © 2017年 Zin_戦. All rights reserved.
//

#import "ViewController.h"
#import <WeexSDK/WeexSDK.h>
@interface ViewController ()

@property (nonatomic, strong) WXSDKInstance *instance;
@property (nonatomic, strong) UIView *weexView;

@end

@implementation ViewController
{
    NSURL *jsUrl;
}

- (instancetype)initWithJs:(NSString *)filePath
{
    self = [super init];
    if (self) {
        //远程js文件  http://127.0.0.1:8081/weex_tmp/h5_render/?hot-reload_controller&page=helloWeex.js
//                NSString *path=@"http://ofp8nns2c.bkt.clouddn.com/weex-bootstra.js";
        //本地js文件
        NSString *path=[NSString stringWithFormat:@"file://%@/js/%@",[NSBundle mainBundle].bundlePath,filePath];
        NSLog(@"-----path:%@",path);
        jsUrl=[NSURL URLWithString:path];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
    _instance.frame=self.view.frame;
    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
    };
    _instance.onFailed = ^(NSError *error) {
        NSLog(@"加载错误");
    };
    
    _instance.renderFinish = ^ (UIView *view) {
        NSLog(@"加载完成");
    };
    if (!jsUrl) {
        return;
    }
    [_instance renderWithURL: jsUrl];
    self.view.backgroundColor=[UIColor whiteColor];
    
}


- (void)dealloc
{
    [_instance destroyInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
