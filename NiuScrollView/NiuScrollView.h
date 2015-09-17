//
//  NiuScrollView.h
//  NiuScrollView
//
//  Created by ilaoniu on 15-9-15.
//  Copyright (c) 2015年 ilaoniu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIPageControlShowStyle) {
    UIPageControlShowStyleNone,//default
    UIPageControlShowStyleLeft,
    UIPageControlShowStyleCenter,
    UIPageControlShowStyleRight,
};

typedef NS_ENUM(NSUInteger, TitleShowStyle) {
    TitleShowStyleNone,
    TitleShowStyleLeft,
    TitleShowStyleCenter,
    TitleShowStyleRight,
};

@interface NiuScrollView : UIScrollView<UIScrollViewDelegate>

@property(nonatomic,retain)UIPageControl *pageControl;
@property(nonatomic,retain)NSArray *imageNameArray;
@property(nonatomic,retain)NSArray *titleArray;
@property(nonatomic,assign)UIPageControlShowStyle PageControlShowStyle;
@property(nonatomic,assign)TitleShowStyle titleShowStyle;

-(void)setTitleArray:(NSArray *)titleArray withShowStyle:(TitleShowStyle)titleShowStyle;
-(void)addTapToScrollViewWithObject:(id)object andSEL:(SEL)sel;

@end
