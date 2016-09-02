//
//  UIView+Extension.h
//  ScrollTitleMenuDemo
//
//  Created by langyue on 16/9/2.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)


-(void)setX:(CGFloat)x;
-(void)setY:(CGFloat)y;
-(void)setWidth:(CGFloat)width;
-(void)setHeight:(CGFloat)height;
-(CGFloat)x;
-(CGFloat)y;
-(CGFloat)width;
-(CGFloat)height;
-(CGFloat)centerX;
-(void)setCenterX:(CGFloat)centerX;
-(CGFloat)centerY;
-(void)setCenterY:(CGFloat)centerY;
-(void)setSize:(CGSize)size;
-(CGSize)size;
-(CGFloat)right;
-(CGFloat)bottom;
-(void)setRight:(CGFloat)right;
-(void)setBottom:(CGFloat)bottom;
+(instancetype)viewFromXib;

@end
