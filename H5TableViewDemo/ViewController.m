//
//  ViewController.m
//  H5TableViewDemo
//
//  Created by 沈凯 on 2017/4/29.
//  Copyright © 2017年 神SKY. All rights reserved.
//

#import "ViewController.h"
#import "WebViewJavascriptBridge.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"H5TableViewDemo" ofType:@"html"]]]];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setValue:@"第一个Cell" forKey:@"name"];
    [dic1 setValue:@"1" forKey:@"index"];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setValue:@"第二个Cell" forKey:@"name"];
    [dic2 setValue:@"2" forKey:@"index"];
    
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setValue:@"第三个Cell" forKey:@"name"];
    [dic3 setValue:@"3" forKey:@"index"];
    
    NSArray *arr = @[dic1,dic2,dic3];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    //初始化bridge
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    
    [self.bridge registerHandler:@"GetData" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self.bridge callHandler:@"GetDataList" data:str];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
