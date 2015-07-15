//
//  PageScrollView.m
//  CloudBuyer
//
//  Created by CHENG DE LUO on 15/7/13.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "PageScrollView.h"

@interface PageScrollView ()

@property (nonatomic, strong) NSMutableDictionary *pageViewDictionary;        //页字典

@end

@implementation PageScrollView

@synthesize currentIndex = _currentIndex;

- (instancetype)initWithFrame:(CGRect)frame withDelegate:(id<PageScrollViewDelegate>)delegate
{
    if (self = [super initWithFrame:frame]) {
        self.pageScrollViewdelegate = delegate;
        [self setup];
    }
    return self;
}

- (NSMutableDictionary *)pageViewDictionary
{
    if (!_pageViewDictionary) {
        NSInteger numberOfPage = [self.pageScrollViewdelegate numberOfPage:self];
        _pageViewDictionary = [NSMutableDictionary dictionaryWithCapacity:numberOfPage];
    }
    return _pageViewDictionary;
}

- (void)setup
{
    NSInteger numberOfPage = [self.pageScrollViewdelegate numberOfPage:self];
    self.contentSize = CGSizeMake((numberOfPage * self.width), self.height);
    self.pagingEnabled = YES;
    self.delegate = self;
    self.backgroundColor = [UIColor whiteColor];
    
    //允许UIViewController或者UIView
    UIView *firstView;
    id obj = [self.pageScrollViewdelegate pageScrollView:self pageViewAtIndex:0];
    if([obj isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)obj;
        [self.pageViewDictionary setObject:vc forKey:[NSNumber numberWithInteger:0]];
        firstView = vc.view;
    } else {
        [self.pageViewDictionary setObject:obj forKey:[NSNumber numberWithInteger:0]];
        firstView = obj;
    }
    
    firstView.frame = CGRectMake(0, 0, self.width, self.height);
    [self addSubview:firstView];
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.pageScrollViewdelegate && [self.pageScrollViewdelegate respondsToSelector:@selector(pageScrollViewDidScroll:)]) {
        [self.pageScrollViewdelegate pageScrollViewDidScroll:self];
    }
    
    CGFloat calcOffset = (scrollView.contentOffset.x + scrollView.width/2) / scrollView.width;
    if (self.currentIndex != floor(calcOffset)) {
        //设置当前页
        _currentIndex = floor(calcOffset); 
    }
    
    //滚动到某个下标 完成之后加载视图
    if (scrollView.contentOffset.x == (scrollView.width * _currentIndex)) {
        
        //发送委托
        if (self.pageScrollViewdelegate && [self.pageScrollViewdelegate respondsToSelector:@selector(pageScrollView:didScrollToIndex:)]) {
            [self.pageScrollViewdelegate pageScrollView:self didScrollToIndex:_currentIndex];
        }
        
        //如果当前页还未加载视图则加载
        id obj = [self.pageViewDictionary objectForKey:[NSNumber numberWithInteger:_currentIndex]];
        if (!obj) {
            obj = [self.pageScrollViewdelegate pageScrollView:self pageViewAtIndex:_currentIndex];
            [self.pageViewDictionary setObject:obj forKey:[NSNumber numberWithInteger:_currentIndex]];
        }
        
        UIView *theView;
        if([obj isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController *)obj;
            theView = vc.view;
        } else {
            theView = obj;
        }
        theView.frame = CGRectMake(_currentIndex * self.width, 0, self.width, self.height);
        [self addSubview:theView];
    }
}

- (void)scrollToIndex:(NSInteger)index;
{
    _currentIndex = index;
    
    [self setContentOffset:CGPointMake(_currentIndex * self.width, 0) animated:YES];
    
    //如果当前页还未加载视图则加载
    id obj = [self.pageViewDictionary objectForKey:[NSNumber numberWithInteger:_currentIndex]];
    if (!obj) {
        obj = [self.pageScrollViewdelegate pageScrollView:self pageViewAtIndex:_currentIndex];
        [self.pageViewDictionary setObject:obj forKey:[NSNumber numberWithInteger:_currentIndex]];
    }
    
    UIView *theView;
    if([obj isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)obj;
        theView = vc.view;
    } else {
        theView = obj;
    }
    theView.frame = CGRectMake(_currentIndex * self.width, 0, self.width, self.height);
    [self addSubview:theView];
}

@end
