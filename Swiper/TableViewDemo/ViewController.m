//
//  ViewController.m
//  TableViewDemo
//
//  Created by 沈凯 on 2018/4/8.
//  Copyright © 2018年 Ssky. All rights reserved.
//

#import "ViewController.h"
#import "WebViewJavascriptBridge.h"
@interface ViewController ()
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.scrollView.scrollEnabled = NO;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"TableViewDemo" ofType:@"html"]]]];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setValue:@"第一个Cell" forKey:@"name"];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setValue:@"第二个Cell" forKey:@"name"];
    
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setValue:@"第三个Cell" forKey:@"name"];
    
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    [dic4 setValue:@"第四个Cell" forKey:@"name"];
    
    NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
    [dic5 setValue:@"第五个Cell" forKey:@"name"];
    
    NSArray *arr = @[dic1,dic2,dic3,dic4,dic5];
    
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
