//
//  UIView+Image.m
//  GFBlurView
//
//  Created by 熊国锋 on 2017/3/6.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import "UIView+Image.h"

@implementation UIView (Image)

- (void)setImage:(UIImage *)image {
    self.layer.contents = (__bridge id)image.CGImage;
    self.layer.contentsCenter = CGRectMake(0, 0, 1, 1);
    self.layer.contentsGravity = @"resizeAspectFill";
}

@end
