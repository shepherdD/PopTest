//
//  PopTestView.m
//  PopTest
//
//  Created by Wudi_Mac on 16/7/12.
//  Copyright © 2016年 Eddie. All rights reserved.
//

#import "PopTestView.h"
#import "POP.h"
#define UI_SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface PopTestView ()

@property (nonatomic) CALayer * contentLayer;
@property (nonatomic) CALayer * bgBtnLayer;
@property (nonatomic) CALayer * imgLayer;
@property (nonatomic) CALayer * countLabelLayer;

@end

@implementation PopTestView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.frame = CGRectMake(UI_SCREEN_WIDTH-145-4, 269, 145, 48);
    self.bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgBtn setFrame:CGRectMake(20, 8, 125, 40)];
    UIImage *bgImage = [UIImage imageNamed:@"222.png"];
    bgImage = [bgImage stretchableImageWithLeftCapWidth:bgImage.size.width-3 topCapHeight:bgImage.size.height-3];
    [self.bgBtn setBackgroundImage:bgImage forState:UIControlStateNormal];
    [self addSubview:self.bgBtn];
    
    self.img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    self.img.image = [UIImage imageNamed:@"111.png"];
    self.img.hidden = YES;
    [self addSubview:self.img];
    
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 3, 52, 12)];
    self.countLabel.hidden = YES;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"x1314"];
    [string addAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0 green:255 blue:252 alpha:1],
                            NSFontAttributeName : [UIFont systemFontOfSize:9],
                            NSStrokeWidthAttributeName : @-1,
                            NSStrokeColorAttributeName : [UIColor colorWithRed:39 green:36 blue:71 alpha:1]
                            } range:NSMakeRange(0, 1)];
    [string addAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0 green:255 blue:252 alpha:1],
                            NSFontAttributeName : [UIFont systemFontOfSize:13],
                            NSStrokeWidthAttributeName : @-1,
                            NSStrokeColorAttributeName : [UIColor colorWithRed:39 green:36 blue:71 alpha:1]
                            } range:NSMakeRange(1, string.length-1)];
    self.countLabel.attributedText = string;
    [self addSubview:self.countLabel];
    
    self.bgBtnLayer = self.bgBtn.layer;
    self.imgLayer = self.img.layer;
    self.countLabelLayer = self.countLabel.layer;
    self.contentLayer = self.layer;
    [self.layer addSublayer:self.bgBtnLayer];
    [self.layer addSublayer:self.imgLayer];
    [self.layer addSublayer:self.countLabelLayer];
}

- (void)startAnim
{
    [self.bgBtnLayer pop_removeAllAnimations];
    self.img.hidden = YES;
    self.countLabel.hidden = YES;

    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anim.springBounciness = 8;
    anim.springSpeed = 20;
    anim.fromValue = @(self.bgBtn.center.x+self.bgBtn.bounds.size.width/2);
    anim.toValue = @(self.bgBtn.center.x);
    anim.completionBlock =  ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            [self startImgAnim];
        }
    };

    [self.bgBtnLayer pop_addAnimation:anim forKey:@"positionX"];
}

- (void)startImgAnim
{
    [self.imgLayer pop_removeAllAnimations];
    self.img.hidden = NO;
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anim.fromValue = @(self.img.center.x+self.bounds.size.width);
    anim.springBounciness = 8;
    anim.springSpeed = 20;
    anim.toValue = @(self.img.center.x);
    anim.completionBlock =  ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            [self startCountLabelAnim];
        }
    };
    [self.imgLayer pop_addAnimation:anim forKey:@"positionX"];
}

- (void)startCountLabelAnim
{
    [self.countLabelLayer pop_removeAllAnimations];
    self.countLabel.hidden = NO;
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    anim.springBounciness = 8;
    anim.springSpeed = 20;
    anim.fromValue = [NSValue valueWithCGSize:CGSizeMake(3, 3)];
    anim.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    anim.completionBlock =  ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            [self startContentViewAnim];
        }
    };
    [self.countLabelLayer pop_addAnimation:anim forKey:@"positionX"];
}

- (void)startContentViewAnim
{
    [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y-self.bounds.size.height - 20, self.bounds.size.width, self.bounds.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self clearSelf];
    }];
}

- (void)clearSelf
{
    [self removeFromSuperview];
}

- (void)dealloc
{
    NSLog(@"dealloc");
}

@end
