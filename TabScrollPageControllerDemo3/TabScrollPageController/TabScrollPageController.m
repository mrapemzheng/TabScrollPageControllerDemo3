//
//  TabScrollPageController.m
//  CloudBuyer
//
//  Created by CHENG DE LUO on 15/7/14.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "TabScrollPageController.h"

@interface TabScrollPageController ()

@property (nonatomic, assign) UIView *tabFatherView;        //标签滚动视图的父视图
@property (nonatomic, assign) UIView *pageFatherView;       //页滚动视图的父视图
@property (nonatomic, assign) CGRect tabScrollViewFrame;    //标签滚动视图的frame
@property (nonatomic, assign) CGRect pageScrollViewFrame;   //页滚动视图的frame

@property (nonatomic, strong) NSArray *tabArray;            //标签数组
@property (nonatomic, strong) NSArray *pageArray;           //数组
@property (nonatomic, assign) NSInteger numberOfTabAtOnePage;//选项卡的数量每页

@end

@implementation TabScrollPageController

- (instancetype)initWithTabFatherView:(UIView *)tabFatherView tabScrollViewFrame:(CGRect)tabScrollViewFrame pageFatherView:(UIView *)pageFatherView pageScrollViewFrame:(CGRect)pageScrollViewFrame tabArray:(NSArray *)tabArray pageArray:(NSArray *)pageArray numberOfTabAtOnePage:(NSInteger)numberOfTabAtOnePage;
{
    if(self = [super init]) {
        self.tabFatherView = tabFatherView;
        self.pageFatherView = pageFatherView;
        self.tabScrollViewFrame = tabScrollViewFrame;
        self.pageScrollViewFrame = pageScrollViewFrame;
        self.tabArray = tabArray;
        self.pageArray = pageArray;
        self.numberOfTabAtOnePage = numberOfTabAtOnePage;
        [self setup];
    }
    return self;
}

- (void)addToSuperView
{
    [self.tabFatherView addSubview:self.tabScrollView];
    [self.pageFatherView addSubview:self.pageScrollView];
}

- (void)setTabScrollViewFrame:(CGRect)tabScrollViewFrame
{
    _tabScrollViewFrame = tabScrollViewFrame;
    self.tabScrollView.frame = _tabScrollViewFrame;
}

- (void)setPageScrollViewFrame:(CGRect)pageScrollViewFrame
{
    _pageScrollViewFrame = pageScrollViewFrame;
    self.pageScrollView.frame = _pageScrollViewFrame;
}

- (void)setup
{
    _tabScrollView = [[TabScrollView alloc] initWithFrame:self.tabScrollViewFrame];
    _tabScrollView.tabScrollViewDelegate = self;
    
    _pageScrollView = [[PageScrollView alloc] initWithFrame:self.pageScrollViewFrame withDelegate:self];
}

#pragma mark - TabScrollViewDelegate

- (NSInteger)numberOfTabAtOnePage:(TabScrollView *)tabScrollView
{
    return self.numberOfTabAtOnePage;
}

//选显卡数据源数组
- (NSArray *)arrayForTabDataSource:(TabScrollView *)tabScrollView
{
    return self.tabArray;
}

//选项被选中
- (void)tabScrollView:(TabScrollView *)tabScrollView didSelectTabAtIndex:(NSInteger)index
{
    [self.pageScrollView scrollToIndex:index];
}

#pragma mark - PageScrollViewDelegate

//页数
- (NSInteger)numberOfPage:(PageScrollView *)pageScrollView
{
    return self.pageArray.count;
}

//指定下标的页视图
- (id)pageScrollView:(PageScrollView *)pageScrollView pageViewAtIndex:(NSInteger)index
{
    return [self.pageArray objectAtIndex:index];
}

//正在滚动
- (void)pageScrollViewDidScroll:(PageScrollView *)pageScrollView
{
    
}

- (void)pageScrollView:(PageScrollView *)pageScrollView didScrollToIndex:(NSInteger)index
{
    [self.tabScrollView selectAtIndex:index animated:YES];
}

#pragma mark - private methods

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
