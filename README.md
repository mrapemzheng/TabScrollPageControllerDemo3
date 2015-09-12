# TabScrollPageControllerDemo3

滚动标签页视图控制器

具体使用:
 NSArray *tabArray = [NSArray arrayWithObjects:@"标签1", @"标签2", @"标签3", @"标签4", @"标签5", @"标签6", nil];
    NSMutableArray *pageArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 6; i ++) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        if (i == 0) {
            v.backgroundColor = [UIColor redColor];
            [pageArray addObject:v];
        } else if(i == 1) {
            v.backgroundColor = [ UIColor grayColor];
            UIViewController *vc = [UIViewController new
                                    ];
            vc.view.backgroundColor = [UIColor grayColor];
            [pageArray addObject:vc];
        } else if(i == 2) {
            v.backgroundColor = [ UIColor blueColor];
            [pageArray addObject:v];
        }else if(i == 3) {
            v.backgroundColor = [ UIColor purpleColor];
            [pageArray addObject:v];
        }else if(i == 4) {
            v.backgroundColor = [ UIColor blackColor];
            [pageArray addObject:v];
        }else if(i == 5) {
            v.backgroundColor = [ UIColor yellowColor];
            [pageArray addObject:v];
        }
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //选项滚动页视图
    tabScrollPageController = [[TabScrollPageController alloc] initWithTabFatherView:self.view tabScrollViewFrame:CGRectMake(0, 64, self.view.width, 40) pageFatherView:self.view pageScrollViewFrame:CGRectMake(0, 64+40, self.view.width, self.view.height - (64+40)) tabArray:tabArray pageArray:pageArray numberOfTabAtOnePage:5];
    [tabScrollPageController addToSuperView];
    tabScrollPageController.tabScrollView.backgroundColor = [UIColor whiteColor];
    tabScrollPageController.tabScrollView.foregroundColor = [UIColor blackColor];
    tabScrollPageController.tabScrollView.highlightColor = [UIColor redColor];
