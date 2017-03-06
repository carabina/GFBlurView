//
//  GFBlurView.h
//  GFBlurView
//
//  Created by guofengld@gmail.com on 03/05/2017.
//  Copyright (c) 2017 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface UIView (Blur)

- (instancetype)initWithFrame:(CGRect)frame
              blurEffectStyle:(UIBlurEffectStyle)blurStyle
              vibrancyEnabled:(BOOL)vibrancyEnabled;

- (BOOL)getBlurEnabled;

- (UIBlurEffectStyle)getBlurStyle;
- (BOOL)getVibrancyEnabled;

- (void)setBlurStyle:(UIBlurEffectStyle)style vibrancyEnabled:(BOOL)vibrancyEnabled;


@end
