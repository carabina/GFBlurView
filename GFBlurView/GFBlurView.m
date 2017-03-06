//
//  GFBlurView.m
//  GFBlurView
//
//  Created by guofengld@gmail.com on 03/05/2017.
//  Copyright (c) 2017 guofengld@gmail.com. All rights reserved.
//

#import "GFBlurView.h"
#import <objc/runtime.h>

#define BLUR_STYLE_KEY          @"blur.style.key"
#define BLUR_VIEW_KEY           @"blur.view.key"
#define BLUR_VIBRANCY_KEY       @"blur.vibrancy.key"
#define BLUR_VIBRANCY_VIEW_KEY  @"blur.vibrancy.view.key"
#define BLUR_CONTENT_VIEW_KEY   @"blur.content.view.key"

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

- (instancetype)initWithFrame:(CGRect)frame
              blurEffectStyle:(UIBlurEffectStyle)blurStyle
              vibrancyEnabled:(BOOL)vibrancyEnabled {
    
    if (self = [self initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self installBlurViewWithStyle:blurStyle
                       vibrancyEnabled:vibrancyEnabled];
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

- (void)saveBlurStyle:(UIBlurEffectStyle)style {
    NSNumber *number = @(style);
    objc_setAssociatedObject(self, BLUR_STYLE_KEY, number, OBJC_ASSOCIATION_COPY);
}

- (UIVisualEffectView *)getBlurView {
    return objc_getAssociatedObject(self, BLUR_VIEW_KEY);
}

- (void)setBlurView:(UIVisualEffectView *)view {
    objc_setAssociatedObject(self, BLUR_VIEW_KEY, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)getVibrancyEnabled {
    NSNumber *number = objc_getAssociatedObject(self, BLUR_VIBRANCY_KEY);
    return [number integerValue];
}

- (void)saveVibrancyEnabled:(BOOL)vibrancyEnabled {
    NSNumber *number = @(vibrancyEnabled);
    objc_setAssociatedObject(self, BLUR_VIBRANCY_KEY, number, OBJC_ASSOCIATION_COPY);
}

- (UIVisualEffectView *)getVibrancyView {
    return objc_getAssociatedObject(self, BLUR_VIBRANCY_VIEW_KEY);
}

- (void)setVibrancyView:(UIVisualEffectView *)vibrancyView {
    objc_setAssociatedObject(self, BLUR_VIBRANCY_VIEW_KEY, vibrancyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)getContentView{
    return objc_getAssociatedObject(self, BLUR_CONTENT_VIEW_KEY);
}

- (void)setContentView:(UIView *)view {
    objc_setAssociatedObject(self, BLUR_CONTENT_VIEW_KEY, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)installBlurViewWithStyle:(UIBlurEffectStyle)style
                 vibrancyEnabled:(BOOL)vibrancyEnabled {
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self addSubview:blurView];
    [blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self setBlurView:blurView];
    [self saveBlurStyle:style];
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor clearColor];
    
    if (vibrancyEnabled) {
        UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:effect];
        UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
        [blurView.contentView addSubview:vibrancyEffectView];
        [vibrancyEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(blurView.contentView);
        }];
        
        [self saveVibrancyEnabled:vibrancyEnabled];
        [self setVibrancyView:vibrancyEffectView];
        
        [vibrancyEffectView.contentView addSubview:contentView];
    }
    else {
        [blurView.contentView addSubview:contentView];
    }
    
    [self setContentView:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (BOOL)constrait:(NSLayoutConstraint *)constrait refersTo:(UIView *)view {
    return (constrait.firstItem == view || constrait.secondItem == view);
}

- (NSArray *)internalConstraitsOf:(UIView *)view {
    NSMutableArray *constraits = @[].mutableCopy;
    for (NSLayoutConstraint *item in view.constraints) {
        if ([self constrait:item refersTo:view] && (item.firstAttribute == NSLayoutAttributeWidth || item.firstAttribute == NSLayoutAttributeHeight)) {
            [constraits addObject:item];
        }
    }
    
    return constraits.copy;
}

- (NSArray *)externalConstraitsOf:(UIView *)view {
    NSMutableArray *constraits = @[].mutableCopy;
    
    UIView *superView = view.superview;
    while (superView) {
        for (NSLayoutConstraint *item in superView.constraints) {
            if (item.firstItem == view || item.secondItem == view) {
                [constraits addObject:item];
            }
        }
        superView = superView.superview;
    }
    
    return constraits.copy;
}

- (void)setBlurStyle:(UIBlurEffectStyle)style vibrancyEnabled:(BOOL)vibrancyEnabled {
    UIView *superView = self.superview;
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    
    [self setBlurView:blurView];
    [self saveBlurStyle:style];
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor clearColor];
    
    if (vibrancyEnabled) {
        UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:effect];
        UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
        [blurView.contentView addSubview:vibrancyEffectView];
        [vibrancyEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(blurView.contentView);
        }];
        
        [self saveVibrancyEnabled:vibrancyEnabled];
        [self setVibrancyView:vibrancyEffectView];
        
        [vibrancyEffectView.contentView addSubview:contentView];
    }
    else {
        [blurView.contentView addSubview:contentView];
    }
    
    [self setContentView:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(blurView);
    }];
    
    NSArray *internalConstraits = [self internalConstraitsOf:self];
    NSArray *externalConstraits = [self externalConstraitsOf:self];
    
    [self removeConstraints:internalConstraits];
    [self removeFromSuperview];
    self.backgroundColor = [UIColor clearColor];
    
    [superView addSubview:blurView];
    [contentView addSubview:self];
    [blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [internalConstraits enumerateObjectsUsingBlock:^(NSLayoutConstraint *item, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLayoutConstraint *constrait = [NSLayoutConstraint constraintWithItem:item.firstItem == self?contentView:item.firstItem
                                                                     attribute:item.firstAttribute
                                                                     relatedBy:item.relation
                                                                        toItem:item.secondItem
                                                                     attribute:item.secondAttribute
                                                                    multiplier:item.multiplier
                                                                      constant:item.constant];
        
        [contentView addConstraint:constrait];
    }];
    
    [externalConstraits enumerateObjectsUsingBlock:^(NSLayoutConstraint *item, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLayoutConstraint *constrait = [NSLayoutConstraint constraintWithItem:item.firstItem == self?contentView:item.firstItem
                                                                     attribute:item.firstAttribute
                                                                     relatedBy:item.relation
                                                                        toItem:item.secondItem
                                                                     attribute:item.secondAttribute
                                                                    multiplier:item.multiplier
                                                                      constant:item.constant];
        
        [superView addConstraint:constrait];
    }];
}

#pragma mark - hooked methods

- (void)blurAddSubview:(UIView *)view {
    if ([self getBlurEnabled]) {
        [[self getContentView] addSubview:view];
    }
    else {
        [self blurAddSubview:view];
    }
}

@end
