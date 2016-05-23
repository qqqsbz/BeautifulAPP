//
//  XBPushTransition.h
//  BeautifulAPP
//
//  Created by coder on 16/5/20.
//  Copyright © 2016年 coder. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,XBTransitionType) {
    XBTransitionTypePush = 0,
    XBTransitionTypePop
};
@interface XBTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(XBTransitionType)type;

- (instancetype)initWithTransitionType:(XBTransitionType)type;

@end
