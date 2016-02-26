//
//  TabScrollView.m
//  CloudBuyer
//
//  Created by CHENG DE LUO on 15/5/5.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "TabScrollView.h"
#import <UIKit/UIKit.h>

//颜色
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFrom255RGBA(r, g, b, a) \
([UIColor colorWithRed: r/255.0 green: g/255.0 blue: b/255.0 alpha:a])

#define UIColorFrom255RGB(r, g, b) \
(UIColorFrom255RGBA(r, g, b, 1.0))


#define D_foregroundColor (UIColorFrom255RGB(51, 51, 51))
#define D_highlightColor (UIColorFrom255RGB(244, 53, 44))
#define D_font ([UIFont systemFontOfSize:14])
#define D_numberOfTabAtOnePage 4
#define D_tabMargin 15
#define D_LineHeight 2

@interface TabScrollView ()

@property (nonatomic, strong) UIButton *changePageButton;                       //翻页按钮

@property (nonatomic, strong) UIView *separatedUnderlineView;         //用于分割的下划线视图
@property (nonatomic, strong) NSMutableArray *tabSeparatedLineViewArray;        //tab分割线视图数据

@end

@implementation TabScrollView

//readonly / setter 要这里重新声明
@synthesize numberOfTabAtOnePage = _numberOfTabAtOnePage;
@synthesize arrayForTabDataSource = _arrayForTabDataSource;
@synthesize tabScrollViewDelegate = _tabScrollViewDelegate;
@synthesize foregroundColor = _foregroundColor;
@synthesize highlightColor = _highlightColor;
@synthesize font = _font;
@synthesize pagingEnabled = _pagingEnabled;

@synthesize separatedUnderlineView = _separatedUnderlineView;

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self initConfig];
        [self generateUI];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initConfig];
    [self generateUI];
}

- (void)setPagingEnabled:(BOOL)pagingEnabled
{
    _pagingEnabled = pagingEnabled;
    self.innerScrollView.pagingEnabled = _pagingEnabled;
}

//懒加载
- (NSMutableArray *)tabButtonArray
{
    if (!_tabButtonArray) {
        _tabButtonArray  = [NSMutableArray array];
    }
    return _tabButtonArray;
}

//懒加载
- (NSMutableArray *)tabSeparatedLineViewArray
{
    if (!_tabSeparatedLineViewArray) {
        _tabSeparatedLineViewArray  = [NSMutableArray array];
    }
    return _tabSeparatedLineViewArray;
}

- (NSInteger)numberOfTabAtOnePage
{
    if (self.tabScrollViewDelegate && [self.tabScrollViewDelegate respondsToSelector:@selector(numberOfTabAtOnePage:)]) {
        _numberOfTabAtOnePage = [self.tabScrollViewDelegate numberOfTabAtOnePage:self];
    } else {
        _numberOfTabAtOnePage = D_numberOfTabAtOnePage;
    }
    
    return _numberOfTabAtOnePage;
}

- (NSArray *)arrayForTabDataSource
{
    if (self.tabScrollViewDelegate && [self.tabScrollViewDelegate respondsToSelector:@selector(arrayForTabDataSource:)]) {
        _arrayForTabDataSource = [self.tabScrollViewDelegate arrayForTabDataSource:self];
    } else {
        _arrayForTabDataSource = [NSArray array];
    }
    return _arrayForTabDataSource;
}

- (UIColor *)foregroundColor
{
    if (!_foregroundColor) {
        _foregroundColor = D_foregroundColor;
    }
    return _foregroundColor;
}

- (UIFont *)font
{
    if (!_font) {
        _font = D_font;
    }
    return _font;
}

- (UIColor *)highlightColor
{
    if (!_highlightColor) {
        _highlightColor = D_highlightColor;
    }
    return _highlightColor;
}

- (void)setTabScrollViewDelegate:(id<TabScrollViewDelegate>)tabScrollViewDelegate
{
    _tabScrollViewDelegate = tabScrollViewDelegate;
    [self generateUI];
}

- (void)setForegroundColor:(UIColor *)foregroundColor
{
    _foregroundColor = foregroundColor;
    
    [self.changePageButton setTitleColor:_foregroundColor forState:UIControlStateNormal];
    NSInteger i = 0;
    for (UIButton *b in self.tabButtonArray) {
        if (i != self.currentSelectIndex) {
            [b setTitleColor:_foregroundColor forState:UIControlStateNormal];
        }
        i ++;
    }
}

- (void)setHighlightColor:(UIColor *)highlightColor
{
    _highlightColor = highlightColor;
    [self.changePageButton setTitleColor:_highlightColor forState:UIControlStateNormal];
    
    //设置选中之后的高亮效果
    if (self.currentSelectIndex != -1 && self.tabButtonArray.count != 0) {
        UIButton *b = [self.tabButtonArray objectAtIndex:self.currentSelectIndex];
        [b setTitleColor:_highlightColor forState:UIControlStateNormal];
        [b setTitleColor:_highlightColor forState:UIControlStateHighlighted];
    }
    self.underLineV.backgroundColor = _highlightColor;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    for (UIButton *b in self.tabButtonArray) {
        b.titleLabel.font = _font;
    }
}

- (void)setTabMagin:(CGFloat)tabMagin
{
    _tabMagin = tabMagin;
    [self generateUI];
}

- (void)setShowSeparatedUnderline:(BOOL)showSeparatedUnderline
{
    _showSeparatedUnderline = showSeparatedUnderline;
    self.separatedUnderlineView.hidden = !_showSeparatedUnderline;
}

- (void)setShowTabSeparatedLineView:(BOOL)showTabSeparatedLineView
{
    _showTabSeparatedLineView = showTabSeparatedLineView;
    for (UIView *tabLineV in self.tabSeparatedLineViewArray) {
        tabLineV.hidden = !_showTabSeparatedLineView;
    }
}

- (void)setSeparatedLineColor:(UIColor *)separatedLineColor
{
    _separatedLineColor = separatedLineColor;
    self.separatedUnderlineView.backgroundColor = _separatedLineColor;
    for (UIView *tabLineV in self.tabSeparatedLineViewArray) {
        tabLineV.backgroundColor = _separatedLineColor;
    }
}

- (void)setTabSeparatedLineHeight:(CGFloat)tabSeparatedLineHeight
{
    _tabSeparatedLineHeight = tabSeparatedLineHeight;
    for (UIView *tabLineV in self.tabSeparatedLineViewArray) {
        tabLineV.height = tabSeparatedLineHeight;
        tabLineV.centerY = self.innerScrollView.height / 2;
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)selectAtIndex:(NSInteger)index animated:(BOOL)animated
{
    _currentSelectIndex = index;
    NSInteger currentPageIndex = floor(index / self.numberOfTabAtOnePage);
    UIButton *currentBtn = [self.tabButtonArray objectAtIndex:_currentSelectIndex];
    
    for (UIButton *b in self.tabButtonArray) {
        [b setTitleColor:self.foregroundColor forState:UIControlStateNormal];
    }
    [((UIButton *)currentBtn) setTitleColor:self.highlightColor forState:UIControlStateNormal];
    
    __weak typeof(self) ws = self;
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.animating = YES;
            ws.underLineV.left = currentBtn.left;
            [ws.innerScrollView setContentOffset:CGPointMake(currentPageIndex * ws.innerScrollView.width, ws.innerScrollView.top)];
        } completion:^(BOOL finished) {
            self.animating = NO;
        }];
    } else {
        self.animating = NO;
        ws.underLineV.left = currentBtn.left;
        [ws.innerScrollView setContentOffset:CGPointMake(currentPageIndex * ws.innerScrollView.width, ws.innerScrollView.top)];
    }
    
    //委托
    if (self.tabScrollViewDelegate && [self.tabScrollViewDelegate respondsToSelector:@selector(tabScrollView:didSelectTabAtIndex:)]) {
        [self.tabScrollViewDelegate tabScrollView:self didSelectTabAtIndex: index];
    }
}

#pragma mark - private methods

//生成界面
- (void)generateUI
{
    self.tabButtonArray = [NSMutableArray array];
    self.tabSeparatedLineViewArray = [NSMutableArray array];
    [self removeAllSubviews];
    
    CGRect rect = CGRectMake(0, 0, self.width, self.height);
    self.innerScrollView = [[UIScrollView alloc] initWithFrame:rect];
    [self addSubview:self.innerScrollView];
    
    CGFloat height = self.innerScrollView.height;
    
    CGFloat tabMargin = ((_tabMagin > 0) ? _tabMagin : D_tabMargin);
    _tabMagin = tabMargin;
    
    NSInteger numberOfTabAtOnePage = self.numberOfTabAtOnePage;
    NSArray *arrayForTabDataSource = self.arrayForTabDataSource;
    CGFloat width = (self.innerScrollView.width - ((numberOfTabAtOnePage + 1) *tabMargin))/ numberOfTabAtOnePage;
    
    for (NSInteger i = 0; i < arrayForTabDataSource.count; i ++) {
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect rect = CGRectMake(((i+1) * tabMargin) + (i * width), 0, width, height);
        b.frame = rect;
        [b setTitle:[arrayForTabDataSource objectAtIndex:i] forState:UIControlStateNormal];
        [b setTitleColor:self.foregroundColor forState:UIControlStateNormal];
        b.titleLabel.font = self.font;
        [b addTarget:self action:@selector(tabButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.innerScrollView addSubview:b];
        
        //如果选中则字体highligh
        if (i == self.currentSelectIndex) {
            [b setTitleColor:self.highlightColor forState:UIControlStateNormal];
        }
        
        //按钮加入数组
        [self.tabButtonArray addObject:b];
        
        //tab分割线
        //非最后一个
        if (i < (arrayForTabDataSource.count - 1)) {
            UIView *tabLineV = [[UIView alloc] initWithFrame:CGRectMake((_tabMagin/2 + ((width + tabMargin)*(i+1))), (height - (self.tabSeparatedLineHeight * 2)), self.separatedLineHeight, self.tabSeparatedLineHeight)];
            tabLineV.backgroundColor = self.separatedLineColor;
            tabLineV.hidden = !self.showTabSeparatedLineView;
            [self.innerScrollView addSubview:tabLineV];
            
            [self.tabSeparatedLineViewArray addObject:tabLineV];
        }
        
    }
    
    self.underLineV = [[UIView alloc] initWithFrame:CGRectMake(tabMargin , self.height - D_LineHeight, width, D_LineHeight)];
    self.underLineV.backgroundColor = self.highlightColor;
    [self.innerScrollView addSubview:self.underLineV];
    
    //翻页按钮
    self.changePageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changePageButton.backgroundColor = [UIColor clearColor];
    self.changePageButton.frame = CGRectMake(self.width - 20, 0, 20, self.height);
    [self.changePageButton setImage:[UIImage imageNamed:@"icon-arrow-up.png"] forState:UIControlStateNormal];
    [self.changePageButton setTitleColor:self.foregroundColor forState:UIControlStateNormal];
    [self.changePageButton addTarget:self action:@selector(pagingButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.changePageButton];
    
    NSInteger multiple = 0;
    if (arrayForTabDataSource.count % numberOfTabAtOnePage == 0) {
        multiple = arrayForTabDataSource.count / numberOfTabAtOnePage;
    } else {
        multiple = (arrayForTabDataSource.count / numberOfTabAtOnePage) + 1;
    }
    self.innerScrollView.contentSize = CGSizeMake(multiple * self.width, height);
    self.innerScrollView.pagingEnabled = YES;
    self.innerScrollView.showsHorizontalScrollIndicator = NO;
    
    //分割下划线
    _separatedUnderlineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - self.separatedLineHeight, self.width, self.separatedLineHeight)];
    [self addSubview:_separatedUnderlineView];
    _separatedUnderlineView.backgroundColor = self.separatedLineColor;
    _separatedUnderlineView.hidden = !self.showSeparatedUnderline;
    
    //设置前景色
    [self setForegroundColor:self.foregroundColor];
    //设置高亮色
    [self setHighlightColor:self.highlightColor];
}

//初始化配置
- (void)initConfig
{
    //初始化基本参数
    self.backgroundColor = [UIColor whiteColor];
    self.currentSelectIndex = 0;
    
    _separatedLineHeight = 0.5;
    _showSeparatedUnderline = YES;
    _showTabSeparatedLineView = NO;
    _separatedLineColor = UIColorFromRGB(0xd9d9d9);
    _tabSeparatedLineHeight = 14;
    
    _animated = YES;
}

- (void)tabButtonDidClick:(id)sender
{
    NSInteger index = [self.tabButtonArray indexOfObject:sender];
    
    [self selectAtIndex:index animated:self.animated];
}

- (void)pagingButtonDidClick:(id)sender
{
    CGPoint contentOffset = [self.innerScrollView contentOffset];
    [self.innerScrollView scrollRectToVisible:CGRectMake(contentOffset.x + self.width, contentOffset.y, self.width, self.height) animated:YES];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
