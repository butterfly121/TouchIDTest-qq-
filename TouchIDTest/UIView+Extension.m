//
//  UIView+Extension.m
//  CommunityService
//
//  Created by zhangmm on 15/5/11.
//  Copyright (c) 2015年 movitech. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
//+ (UIView *)createButtonAndLilterImageView:(NSArray *)TitleArray withImageView:(NSArray *)ImageArray withRect:(CGRect)rect{
//    UIView *Myview = [[UIView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
//    Myview.backgroundColor = [UIColor whiteColor];
//    for (int i = 0; i < TitleArray.count; i++) {
//        UIButton *button = [BasicControls creatButtonWithFrame:CGRectMake(14+i *(Myview.frame.size.width - 28)/TitleArray.count, 10, (Myview.size.width - 50)/TitleArray.count, 30) target:self sel:nil tag:i image:nil title:TitleArray[i]];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:button.height * 0.4];
//        [Myview addSubview:button];
//        button.tag = 1000000 + i;
//        
//        NSString *ImageView = ImageArray[0];
//        UIImageView *imageView = [BasicControls creatImageViewWithFrame:CGRectMake(button.frame.origin.x +button.size.width - 25, button.size.height-2, 15, 15) imageName:ImageView];
//        [Myview addSubview:imageView];
//        
//        if (i > 0 && i <TitleArray.count) {
//            UIView *TwoLineView = [[UIView alloc] initWithFrame:CGRectMake(8+i *(Myview.frame.size.width - 20)/TitleArray.count, 0, 2, Myview.frame.size.height)];
//            TwoLineView.backgroundColor = [UIColor colorWithRed:202/255.0 green:202/255.0 blue:202/255.0 alpha:1];
//            [Myview addSubview:TwoLineView];
//        }
//        
//    }
//    return Myview;
//}
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setMaxX:(CGFloat)maxX
{
    self.x = maxX - self.width;
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxY:(CGFloat)maxY
{
    self.y = maxY - self.height;
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

@end
