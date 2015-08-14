//
//  AnimationLabel.h
//  BCSliderDemo
//
//  Created by Fly on 15/8/11.
//  Copyright (c) 2015年 Mobs and Geeks. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AnimationType) {
    AnimationTypePushOut,//由下自上顶掉上一条最新内容
    AnimationTypeFadeOut,//渐隐显示出新的一条
};

@interface AnimationLabel : UIView

@property (assign, nonatomic) AnimationType animationType;
@property (strong, nonatomic) UIColor       *textColor;
@property (strong, nonatomic) UIFont        *textFont;

//动画的执行时间默认1s 最小值为0.3s
@property (assign, nonatomic) CGFloat       animtaionDuration;
//循环动画的时间间隔，如果为0就只执行一次，默认5s 最小值为2s
@property (assign, nonatomic) CGFloat       animtaionCircleDuration;


- (void)autoSliderContent:(NSArray*)values;

@end
