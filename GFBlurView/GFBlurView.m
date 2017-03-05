//
//  GFBlurView.m
//  Pods
//
//  Created by 熊国锋 on 2017/3/5.
//
//

#import "GFBlurView.h"
#import <objc/runtime.h>

#define BLUR_STYLE_KEY    @"blur.style.key"

@implementation UIView (Blur)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(addSubview:);
        SEL swizzledSelector = @selector(blurAddSubview:);
        
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }
        else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (instancetype)initWithFrame:(CGRect)frame blurEffectStyle:(UIBlurEffectStyle)blurStyle {
    if (self = [self initWithFrame:frame]) {
        
    }
    
    return self;
}

- (BOOL)getBlurEnabled {
    NSNumber *number = objc_getAssociatedObject(self, BLUR_STYLE_KEY);
    return number != nil;
}

- (UIBlurEffectStyle)getBlurStyle {
    NSNumber *number = objc_getAssociatedObject(self, BLUR_STYLE_KEY);
    return [number integerValue];
}

- (void)setBlurStyle:(UIBlurEffectStyle)style {
    NSNumber *number = @(style);
    objc_setAssociatedObject(self, BLUR_STYLE_KEY, number, OBJC_ASSOCIATION_COPY);
}

- (void)blurAddSubview:(UIView *)view {
    [self blurAddSubview:view];
}

@end
