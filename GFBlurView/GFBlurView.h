//
//  GFBlurView.h
//  Pods
//
//  Created by 熊国锋 on 2017/3/5.
//
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface UIView (Blur)

- (instancetype)initWithFrame:(CGRect)frame blurEffectStyle:(UIBlurEffectStyle)blurStyle;

- (BOOL)getBlurEnabled;

- (UIBlurEffectStyle)getBlurStyle;

- (void)setBlurStyle:(UIBlurEffectStyle)style;

@end
