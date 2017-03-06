//
//  ViewController.m
//  GFBlurView
//
//  Created by guofengld@gmail.com on 03/05/2017.
//  Copyright (c) 2017 guofengld@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import <GFBlurView/GFBlurView.h>
#import "UIView+Image.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    //set a background image for the view
    [self.view setImage:[UIImage imageNamed:@"icon_main_bg"]];
    
    //The first area initialized directly with blur style and vibrancy
    UIView *rectView = [[UIView alloc] initWithFrame:CGRectZero
                                     blurEffectStyle:UIBlurEffectStyleDark
                                     vibrancyEnabled:YES];
    [self.view addSubview:rectView];
    [rectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(rectView.mas_width).multipliedBy(.66);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_centerY);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:38];
    label.textColor = [UIColor whiteColor];
    label.text = @"Testing Label 00";
    [rectView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(rectView);
    }];
    
    //Then the second area, normally initialized
    rectView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:rectView];
    [rectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(rectView.mas_width).multipliedBy(.66);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_centerY);
    }];
    
    label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:38];
    label.textColor = [UIColor whiteColor];
    label.text = @"Testing Label 10";
    [rectView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(rectView);
        make.bottom.equalTo(rectView.mas_centerY);
    }];
    
    //After the area was initialized, we change the blur style of it
    [rectView setBlurStyle:UIBlurEffectStyleLight
           vibrancyEnabled:YES];
    
    //And continue to add sub view
    label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:38];
    label.textColor = [UIColor whiteColor];
    label.text = @"Testing Label 11";
    [rectView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(rectView);
        make.top.equalTo(rectView.mas_centerY);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
