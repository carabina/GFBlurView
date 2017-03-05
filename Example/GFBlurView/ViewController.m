//
//  ViewController.m
//  GFBlurView
//
//  Created by guofengld@gmail.com on 03/05/2017.
//  Copyright (c) 2017 guofengld@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import <GFBlurView/GFBlurView.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_main_bg"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //第一个方块 View
    UIView *rectView = [[UIView alloc] initWithFrame:CGRectZero blurEffectStyle:UIBlurEffectStyleDark];
    [self.view addSubview:rectView];
    [rectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(rectView.mas_width).multipliedBy(.75);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_centerY);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:38];
    label.textColor = [UIColor whiteColor];
    label.text = @"测试 Label 01";
    [rectView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(rectView);
    }];
    
    //第二个方块 View
//    
//    rectView = [[UIView alloc] initWithFrame:CGRectZero];
//    [self.view addSubview:rectView];
//    [rectView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(self.view).multipliedBy(.8);
//        make.height.equalTo(rectView.mas_width);
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(self.view.mas_centerY);
//    }];
//    
//    label = [[UILabel alloc] init];
//    label.font = [UIFont systemFontOfSize:38];
//    label.textColor = [UIColor whiteColor];
//    label.text = @"测试 Label 02";
//    [rectView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(rectView);
//    }];
//    
//    [rectView setBlurStyle:UIBlurEffectStyleLight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
