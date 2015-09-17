//
//  NiuScrollView.m
//  NiuScrollView
//
//  Created by ilaoniu on 15-9-15.
//  Copyright (c) 2015年 ilaoniu. All rights reserved.
//

#import "NiuScrollView.h"
#import "FuncPublic.h"

#define SCROLLVIEW_WIDTH self.bounds.size.width    //ScrollView的宽度
#define SCROLLVIEW_HEIGHT self.bounds.size.height  //ScrollView的高度

static CGFloat const changeImageTime = 4.0;
static NSInteger currentImage = 1; //记录中间图片的下标，开始总是1

@implementation NiuScrollView{
    //图片文字label
    UILabel *_label;
    
    //循环滚动的三个视图
    UIImageView *_leftImageView;
    UIImageView *_centerImageView;
    UIImageView *_rightImageView;
    
    //循环滚动的周期时间
    NSTimer *_moveTime;
    
    //用于确定滚动是由人导致的还是计时器到了，系统滚动则为YES，客户滚动为NO
    //（PS.在客户端中客户滚动一个广告后，这个广告的计时器要归零并重新计时）
    BOOL _isTimeUp;
    
    //给每张图片添加一个lable说明（可选）
    UILabel *_leftLabel;
    UILabel *_centerLabel;
    UILabel *_rightLabel;

}

#pragma mark - 自由指定SV占用的frame
-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = YES;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake(SCROLLVIEW_WIDTH, 0);
        self.contentSize = CGSizeMake(SCROLLVIEW_WIDTH*3, SCROLLVIEW_HEIGHT);
        self.delegate = self;
        
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCROLLVIEW_WIDTH, SCROLLVIEW_HEIGHT)];
        [self addSubview:_leftImageView];
        
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCROLLVIEW_WIDTH, 0, SCROLLVIEW_WIDTH, SCROLLVIEW_HEIGHT)];
        [self addSubview:_centerImageView];
        
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCROLLVIEW_WIDTH*2, 0, SCROLLVIEW_WIDTH, SCROLLVIEW_HEIGHT)];
        [self addSubview:_rightImageView];
       
        _moveTime = [NSTimer scheduledTimerWithTimeInterval:changeImageTime target:self selector:@selector(imageMove) userInfo:nil repeats:YES];
        _isTimeUp = NO;
    }
    return self;
}

#pragma mark - 给当前ImageView添加手势
-(void)addTapToScrollViewWithObject:(id)object andSEL:(SEL)sel{
    _centerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:object action:sel];
    [_centerImageView addGestureRecognizer:tap];
}

#pragma mark - 计时器到时，系统滚动图片
-(void)imageMove{
    [self setContentOffset:CGPointMake(SCROLLVIEW_WIDTH*2, 0) animated:YES];
    _isTimeUp = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

#pragma mark - 图片停止时，调用该函数复用滚动视图
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.contentOffset.x == 0) {
        currentImage = (currentImage-1)%_imageNameArray.count;
        _pageControl.currentPage = (_pageControl.currentPage-1)%_imageNameArray.count;
    }else if (self.contentOffset.x == SCROLLVIEW_WIDTH*2){
        currentImage = (currentImage+1)%_imageNameArray.count;
        _pageControl.currentPage = (_pageControl.currentPage+1)%_imageNameArray.count;
    }else{
        return;
    }
    
    _leftImageView.image = [UIImage imageNamed:_imageNameArray[(currentImage-1)%_imageNameArray.count]];
    _leftLabel.text = _titleArray[(currentImage-1)%_imageNameArray.count];
    _centerImageView.image = [UIImage imageNamed:_imageNameArray[(currentImage)%_imageNameArray.count]];
    _centerLabel.text = _titleArray[(currentImage)%_imageNameArray.count];
    _rightImageView.image = [UIImage imageNamed:_imageNameArray[(currentImage+1)%_imageNameArray.count]];
    _rightLabel.text = _titleArray[(currentImage+1)%_imageNameArray.count];
    
    self.contentOffset = CGPointMake(SCROLLVIEW_WIDTH, 0);
    
    NSString *imageArrayCountStr = [NSString stringWithFormat:@"%lu",_imageNameArray.count];
    NSString *currentImageStr = [NSString stringWithFormat:@"%ld",currentImage-1];
    
    [FuncPublic SaveDefaultInfo:imageArrayCountStr andKey:@"imageArrayCount"];
    [FuncPublic SaveDefaultInfo:currentImageStr andKey:@"currentImage"];
    
    //手动控制图片应该取消那个三秒的计时器
    if (!_isTimeUp) {
        [_moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:changeImageTime]];
    }
    _isTimeUp = NO;
}

#pragma mark - 设置SV用到的图片
-(void)setImageNameArray:(NSArray *)imageNameArray{
    _imageNameArray = imageNameArray;
    
    _leftImageView.image = [UIImage imageNamed:_imageNameArray[0]];
    _centerImageView.image = [UIImage imageNamed:_imageNameArray[1]];
    _rightImageView.image = [UIImage imageNamed:_imageNameArray[2]];
}

#pragma mark - 创建pageControl,指定其显示样式
-(void)setPageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle{
    if (PageControlShowStyle == UIPageControlShowStyleNone) {
        return;
    }
    
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.numberOfPages = _imageNameArray.count;
    
    if (PageControlShowStyle == UIPageControlShowStyleLeft) {
        _pageControl.frame = CGRectMake(10, CGRectGetMaxY(self.frame) - 20, 20*_pageControl.numberOfPages, 20);
    }else if (PageControlShowStyle == UIPageControlShowStyleCenter){
        _pageControl.frame = CGRectMake(0, 0, 20*_pageControl.numberOfPages, 20);
        _pageControl.center = CGPointMake(SCROLLVIEW_WIDTH/2.0, CGRectGetMaxY(self.frame) - 10);
    }else{
        _pageControl.frame = CGRectMake(SCROLLVIEW_WIDTH-20*_pageControl.numberOfPages, CGRectGetMaxY(self.frame)-20, 20*_pageControl.numberOfPages, 20);
    }
    
    _pageControl.currentPage = 0;
    _pageControl.enabled = NO;
    [self performSelector:@selector(addPageControl) withObject:nil afterDelay:0.1f];
}

-(void)addPageControl{
    [[self superview]addSubview:_pageControl];

}

#pragma mark - 设置每张图对应的说明文字
-(void)setTitleArray:(NSArray *)titleArray withShowStyle:(TitleShowStyle)titleShowStyle{
    _titleArray = titleArray;
    
    if (titleShowStyle == TitleShowStyleNone) {
        return;
    }
    
    _leftLabel = [[UILabel alloc]init];
    _centerLabel = [[UILabel alloc]init];
    _rightLabel = [[UILabel alloc]init];
    
    _leftLabel.frame = CGRectMake(10, SCROLLVIEW_HEIGHT-40, SCROLLVIEW_WIDTH-20, 20);
    [_leftImageView addSubview:_leftLabel];
    _centerLabel.frame = CGRectMake(10, SCROLLVIEW_HEIGHT-40, SCROLLVIEW_WIDTH-20, 20);
    [_centerImageView addSubview:_centerLabel];
    _rightLabel.frame = CGRectMake(10, SCROLLVIEW_HEIGHT-40, SCROLLVIEW_WIDTH-20, 20);
    [_rightImageView addSubview:_rightLabel];
    
    if (titleShowStyle == TitleShowStyleLeft) {
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _centerLabel.textAlignment = NSTextAlignmentLeft;
        _rightLabel.textAlignment = NSTextAlignmentLeft;
    }else if (titleShowStyle == TitleShowStyleCenter){
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _centerLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.textAlignment = NSTextAlignmentCenter;
    }else{
        _leftLabel.textAlignment = NSTextAlignmentRight;
        _centerLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    
    _leftLabel.text = _titleArray[0];
    _centerLabel.text = _titleArray[1];
    _rightLabel.text = _titleArray[2];
}

@end
