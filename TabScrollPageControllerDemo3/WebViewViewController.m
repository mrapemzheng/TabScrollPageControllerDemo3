//
//  WebViewViewController.m
//  TabScrollPageControllerDemo3
//
//  Created by CHENG DE LUO on 15/9/12.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.kinggen.com.cn/"] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0];
    [self.webView loadRequest:urlrequest];
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
