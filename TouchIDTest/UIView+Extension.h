//
//  UIView+Extension.h
//  CommunityService
//
//  Created by zhangmm on 15/5/11.
//  Copyright (c) 2015年 movitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
//+ (UIView *)createButtonAndLilterImageView:(NSArray *)TitleArray withImageView:(NSArray *)ImageArray withRect:(CGRect)rect;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@end
