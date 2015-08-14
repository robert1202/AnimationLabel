//
//  AnimationLabel.m
//  BCSliderDemo
//
//  Created by Fly on 15/8/11.
//  Copyright (c) 2015年 Mobs and Geeks. All rights reserved.
//

#import "AnimationLabel.h"

@interface AnimationLabel()

@property (assign, nonatomic) NSUInteger currentCount;

@property (strong, nonatomic) UILabel* frontLabel;
@property (strong, nonatomic) UILabel* backLabel;

@property (strong, nonatomic) NSArray* valueList;

@end

@implementation AnimationLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initContentLabel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initContentLabel];
    }
    return self;
}

#pragma mark - Animation Sections

- (void)autoSliderContent:(NSArray*)values{
    self.valueList = values;
    self.frontLabel.text = [values firstObject];
    if ([values count] <= 1) {
        return;
    }
    self.backLabel.text = values[1];
    [self prepareAnimation];

    [self performSelector:@selector(exchangeContentLabel) withObject:nil afterDelay:self.animtaionCircleDuration];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self prepareAnimation];
}

#pragma mark - SetAnimationProperty

- (void)prepareAnimation{
    switch (self.animationType) {
        case AnimationTypePushOut: {
            CGRect labelFrame = self.bounds;
            self.frontLabel.frame = labelFrame;
            labelFrame.origin.y = labelFrame.size.height;
            self.backLabel.frame  = labelFrame;
            break;
        }
        case AnimationTypeFadeOut: {
            self.frontLabel.alpha = 1.0f;
            self.backLabel.alpha = 0.0f;
            break;
        }
    }
}

- (void)startAnimation{
    switch (self.animationType) {
        case AnimationTypePushOut: {
            CGRect labelFrame = self.bounds;
            self.backLabel.frame = labelFrame;
            labelFrame.origin.y = -labelFrame.size.height;
            self.frontLabel.frame  = labelFrame;
            break;
        }
        case AnimationTypeFadeOut: {
            self.frontLabel.alpha = 0.0f;
            self.backLabel.alpha = 1.0f;
            break;
        }
    }
}

- (void)exchangeContentLabel{
    
    [self prepareAnimation];

    [UIView animateWithDuration:self.animtaionDuration animations:^{
        [self startAnimation];
    } completion:^(BOOL finished) {
        UILabel* tmpLabel = self.frontLabel;
        self.frontLabel = self.backLabel;
        self.backLabel = tmpLabel;
        
        NSString* backString = @"";
        if (self.currentCount + 1 < [self.valueList count]) {
            backString = self.valueList[self.currentCount+1];
        }else{
            backString = self.valueList[0];
        }
        self.backLabel.text = backString;
    }];
    self.currentCount++;
    if (self.currentCount >= [self.valueList count]) {
        self.currentCount = 0;
    }
    [self performSelector:@selector(exchangeContentLabel) withObject:nil afterDelay:self.animtaionCircleDuration];
}

#pragma mark - UI

- (void)initContentLabel{
    
    self.animtaionDuration = 1.0f;
    self.animtaionCircleDuration = 5.0f;
    
    self.clipsToBounds = YES;
    self.frontLabel = [[UILabel alloc] init];
    self.backLabel = [[UILabel alloc] init];
    
    self.animationType = AnimationTypePushOut;
    
    [self addSubview:self.backLabel];
    [self addSubview:self.frontLabel];
}

- (void)configLabel:(UILabel*)label{
    label.frame = self.bounds;
    label.alpha = 1.0f;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
}

#pragma mark - Reset 

- (void)setAnimationType:(AnimationType)animationType{
    _animationType = animationType;
    [self configLabel:self.frontLabel];
    [self configLabel:self.backLabel];
}

- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.backLabel.textColor = textColor;
    self.frontLabel.textColor = textColor;
}

- (void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    self.backLabel.font = textFont;
    self.frontLabel.font = textFont;
}

- (void)setAnimtaionDuration:(CGFloat)animtaionDuration{
    _animtaionDuration = MIN(animtaionDuration, 0.3);
}

- (void)setAnimtaionCircleDuration:(CGFloat)animtaionCircleDuration{
    _animtaionCircleDuration = MIN(animtaionCircleDuration, 2);
}

@end
