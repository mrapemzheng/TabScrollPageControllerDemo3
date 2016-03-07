//
//  ViewController.m
//  TabScrollPageControllerDemo
//
//  Created by CHENG DE LUO on 15/7/14.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Utils.h"
#import "TabScrollPageController.h"
#import "WebViewViewController.h"

@interface ViewController ()<TabScrollPageControllerDelegate>
{
//    TabScrollPageController *tabScrollPageController;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect rect = [UIScreen mainScreen].bounds;
    
    //设置数据
    NSArray *tabArray = [NSArray arrayWithObjects:@"标签1", @"标签2", @"标签3", @"标签4", @"标签5", @"标签6", @"标签7", nil];
    NSMutableArray *pageArray = [NSMutableArray array];
    for (NSInteger i = 0; i < tabArray.count; i ++) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        if (i == 0) {
            WebViewViewController *webViewViewController2 = [[WebViewViewController alloc] initWithNibName:@"WebViewViewController" bundle:[NSBundle mainBundle]];
            webViewViewController2.webUrlStr = @"https://github.com/AFNetworking/AFNetworking";
            [pageArray addObject:webViewViewController2];
        } else if(i == 1) {
            
            WebViewViewController *webViewViewController = [[WebViewViewController alloc] initWithNibName:@"WebViewViewController" bundle:[NSBundle mainBundle]];
            [pageArray addObject:webViewViewController];
        } else if(i == 2) {
            WebViewViewController *webViewViewController2 = [[WebViewViewController alloc] initWithNibName:@"WebViewViewController" bundle:[NSBundle mainBundle]];
            webViewViewController2.webUrlStr = @"https://www.baidu.com/";
            [pageArray addObject:webViewViewController2];
        }else if(i == 3) {
            WebViewViewController *webViewViewController3 = [[WebViewViewController alloc] initWithNibName:@"WebViewViewController" bundle:[NSBundle mainBundle]];
            webViewViewController3.webUrlStr = @"https://www.tmall.com/";
            [pageArray addObject:webViewViewController3];
            
        }else if(i == 4) {
            WebViewViewController *webViewViewController3 = [[WebViewViewController alloc] initWithNibName:@"WebViewViewController" bundle:[NSBundle mainBundle]];
            webViewViewController3.webUrlStr = @"http://www.jd.com/";
            [pageArray addObject:webViewViewController3];
        }else if(i == 5) {
            WebViewViewController *webViewViewController3 = [[WebViewViewController alloc] initWithNibName:@"WebViewViewController" bundle:[NSBundle mainBundle]];
            webViewViewController3.webUrlStr = @"http://github.com/";
            [pageArray addObject:webViewViewController3];
            
        } else if(i == 6) {
            
            WebViewViewController *webViewViewController3 = [[WebViewViewController alloc] initWithNibName:@"WebViewViewController" bundle:[NSBundle mainBundle]];
            webViewViewController3.webUrlStr = @"http://www.dongting.com/";
            [pageArray addObject:webViewViewController3];
        }
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //选项滚动页视图
    TabScrollPageController *tabScrollPageController = [[TabScrollPageController alloc] initWithTabFatherView:self.view tabScrollViewFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 40) pageFatherView:self.view pageScrollViewFrame:CGRectMake(0, 64+40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - (64+40)) tabArray:tabArray pageArray:pageArray numberOfTabAtOnePage:5];
    [tabScrollPageController addToSuperView];
    tabScrollPageController.tabScrollView.tabMagin = 10;
    tabScrollPageController.tabScrollView.showTabSeparatedLineView = YES;
    tabScrollPageController.tabScrollView.showSeparatedUnderline = YES;
    tabScrollPageController.tabScrollView.separatedLineColor = [UIColor grayColor];
    tabScrollPageController.tabScrollView.separatedLineHeight = 0.5;
    tabScrollPageController.tabScrollView.tabSeparatedLineHeight = 14;
    tabScrollPageController.tabScrollView.backgroundColor = [UIColor whiteColor];
    tabScrollPageController.tabScrollView.foregroundColor = [UIColor blackColor];
    tabScrollPageController.tabScrollView.highlightColor = [UIColor redColor];
    tabScrollPageController.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TabScrollPageControllerDelegate

- (void)tabScrollPageController:(TabScrollPageController *)tabScrollPageController didSelectAtIndex:(NSInteger)index
{
    UIButton *b = [tabScrollPageController.tabScrollView.tabButtonArray objectAtIndex:index];
    
}

@end
