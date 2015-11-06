//
//  PageScrollView.h
//  CloudBuyer
//
//  Created by CHENG DE LUO on 15/7/13.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Utils.h"

@class PageScrollView;
@protocol PageScrollViewDelegate <NSObject>

@required
//页数
- (NSInteger)numberOfPage:(PageScrollView *)pageScrollView;

//指定下标的页视图
- (id)pageScrollView:(PageScrollView *)pageScrollView  pageViewAtIndex:(NSInteger)index;

@optional
//正在滚动   
- (void)pageScrollViewDidScroll:(PageScrollView *)pageScrollView;

//已经滚动到下标
- (void)pageScrollView:(PageScrollView *)pageScrollView didScrollToIndex:(NSInteger)index;

@end

/**
 *  页滚动视图
 *
 *  @author apem
 */

@interface PageScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, assign, readonly) NSInteger currentIndex;       //当前下标
@property (nonatomic, assign) id<PageScrollViewDelegate> pageScrollViewdelegate;    //委托
@property (nonatomic, assign) BOOL warmAnimated;      //和谐动画 默认NO

/**
 *  初始化
 *
 *  @param frame    位置和大小
 *  @param delegate 委托
 *
 *  @return 页滚动视图
 */
- (instancetype)initWithFrame:(CGRect)frame withDelegate:(id<PageScrollViewDelegate>)delegate;

/**
 *  初始化
 */
- (void)setup;

/**
 *  滚动到指定下标
 *
 *  @param index 下标
 */
- (void)scrollToIndex:(NSInteger)index;

@end
