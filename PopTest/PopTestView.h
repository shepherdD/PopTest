//
//  PopTestView.h
//  PopTest
//
//  Created by Wudi_Mac on 16/7/12.
//  Copyright © 2016年 Eddie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopTestView : UIView

@property (strong, nonatomic) UIButton *bgBtn;
@property (strong, nonatomic) UIImageView *img;
@property (strong, nonatomic) UILabel *countLabel;

- (void)startAnim;
- (void)startContentViewAnimImmediately;

@end
