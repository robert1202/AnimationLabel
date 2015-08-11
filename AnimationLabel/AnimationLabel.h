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

@property (assign, nonatomic) AnimationType    animationType;

- (void)autoSliderContent:(NSArray*)values;

@end
