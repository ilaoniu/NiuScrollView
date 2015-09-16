//
//  ViewController.m
//  NiuScrollView
//
//  Created by ilaoniu on 15-9-15.
//  Copyright (c) 2015年 ilaoniu. All rights reserved.
//


#import "ViewController.h"
#import "NiuScrollView.h"
#import "NiuDataModel.h"

#define UISCREEN_HEIGHT self.view.bounds.size.height
#define UISCREEN_WIDTH self.view.bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createScrollView];
}

#pragma mark - 创建SV滚动视图
-(void)createScrollView{
    NiuScrollView *scrollView = [[NiuScrollView alloc]initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, 150)];
    NiuDataModel *dataModel = [[NiuDataModel alloc]initWithImageNameAndTitleArray];
    
    scrollView.imageNameArray = dataModel.imageNameArray;
    scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
    
    [scrollView setTitleArray:dataModel.titleArray withShowStyle:TitleShowStyleLeft];
    
    scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self.view addSubview:scrollView]; 
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
