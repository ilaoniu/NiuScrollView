//
//  NiuDataModel.m
//  NiuScrollView
//
//  Created by ilaoniu on 15-9-15.
//  Copyright (c) 2015年 ilaoniu. All rights reserved.
//

#import "NiuDataModel.h"

#define PATH [[NSBundle mainBundle]pathForResource:@"NiuScrollView.plist" ofType:nil]

@implementation NiuDataModel


-(instancetype)initWithImageName{
    if ([super init]) {
        _imageNameArray = [NSArray arrayWithContentsOfFile:PATH][0];
    }
    return self;
}

-(instancetype)initWithImageNameAndTitleArray{
    _titleArray = [NSArray arrayWithContentsOfFile:PATH][1];
    return [self initWithImageName];
}

+(id)DataModelWithImageName{
    return [[self alloc]initWithImageName];
}

+(id)DataModelWithImageNameAndTitleArray{
    return [[self alloc]initWithImageNameAndTitleArray];
}

@end
