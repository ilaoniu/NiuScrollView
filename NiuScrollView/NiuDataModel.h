//
//  NiuDataModel.h
//  NiuScrollView
//
//  Created by ilaoniu on 15-9-15.
//  Copyright (c) 2015年 ilaoniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NiuDataModel : NSObject

@property(nonatomic,retain)NSArray *imageNameArray;
@property(nonatomic,retain)NSArray *titleArray;

-(instancetype)initWithImageName;
-(instancetype)initWithImageNameAndTitleArray;
+(id)DataModelWithImageName;
+(id)DataModelWithImageNameAndTitleArray;

@end
