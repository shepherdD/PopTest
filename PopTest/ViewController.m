//
//  ViewController.m
//  PopTest
//
//  Created by Wudi_Mac on 16/7/12.
//  Copyright © 2016年 Eddie. All rights reserved.
//

#import "ViewController.h"
#import "PopTestView.h"

@interface ViewController ()

@property (strong, nonatomic) PopTestView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor blueColor];
    btn.titleLabel.text = @"开始";
    [btn  addTarget:self action:@selector(statAnim) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)statAnim
{
    if (self.contentView == nil) {
        PopTestView *contentView = [[PopTestView alloc] init];
        [self.view addSubview:contentView];
        [contentView startAnim];
        self.contentView = contentView;
    }else
    {
        [self.contentView startContentViewAnimImmediately];
        self.contentView = nil;
        PopTestView *contentView = [[PopTestView alloc] init];
        [self.view addSubview:contentView];
        [contentView startAnim];
        self.contentView = contentView;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
