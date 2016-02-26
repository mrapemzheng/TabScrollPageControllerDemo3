//
//  TabScrollPageController.h
//  CloudBuyer
//
//  Created by CHENG DE LUO on 15/7/14.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TabScrollView.h"
#import "PageScrollView.h"
#import "UIView+Utils.h"

@class TabScrollPageController;
@protocol TabScrollPageControllerDelegate <NSObject>

//选中一个
@optional
- (void)tabScrollPageController:(TabScrollPageController *)tabScrollPageController didSelectAtIndex:(NSInteger)index;
@end

/**
 *  标签滚动页控制器
 *
 *  @author apem
 */

@interface TabScrollPageController : UIView<TabScrollViewDelegate, PageScrollViewDelegate>

@property (nonatomic, strong) TabScrollView *tabScrollView;         //标签滚动视图
@property (nonatomic, strong) PageScrollView *pageScrollView;       //页滚动视图
@property (nonatomic, assign) CGRect pageScrollViewFrame;   //页滚动视图的frame
@property (nonatomic, strong) id<TabScrollPageControllerDelegate> delegate;

/**
 *  初始化
 *
 *  @param tabScrollViewFrame 标签滚动视图的frame
 *  @param pageScrollViewFrame 页滚动视图的frame
 *  @param tabArray       标签名称数组
 *  @param pageArray      页数组 view/controller 数组
 *  @param numberOfTabAtOnePage 选项卡的数量每页
 *
 *  @return 标签滚动页控制器
 */
- (instancetype)initWithTabFatherView:(UIView *)tabFatherView tabScrollViewFrame:(CGRect)tabScrollViewFrame pageFatherView:(UIView *)pageFatherView pageScrollViewFrame:(CGRect)pageScrollViewFrame tabArray:(NSArray *)tabArray pageArray:(NSArray *)pageArray numberOfTabAtOnePage:(NSInteger)numberOfTabAtOnePage;

/**
 *  初始化
 */
- (void)setup;

/**
 *  添加进入对应的父视图
 */
- (void)addToSuperView;
@end
