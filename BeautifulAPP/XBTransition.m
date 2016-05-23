//
//  XBPushTransition.m
//  BeautifulAPP
//
//  Created by coder on 16/5/20.
//  Copyright © 2016年 coder. All rights reserved.
//
#define kBackButton 50
#define kAvatarImageView 50
#import "XBTransition.h"
#import "ViewController.h"
#import "DetailViewController.h"
@interface XBTransition()
@property (assign, nonatomic) XBTransitionType  type;
@end
@implementation XBTransition

+ (instancetype)transitionWithTransitionType:(XBTransitionType)type
{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(XBTransitionType)type
{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return .8f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    switch (_type) {
        case XBTransitionTypePush:
            [self pushAnimation:transitionContext];
            break;
        case XBTransitionTypePop:
            [self popAnimation:transitionContext];
            break;
    }
}

- (void)pushAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    ViewController *fromVC = [[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].childViewControllers lastObject];
    DetailViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIImageView *coverImageView = toVC.coverImageView;
    CGRect coverFrame = coverImageView.frame;
    coverImageView.frame = [fromVC.coverImageView convertRect:fromVC.coverImageView.bounds toView:containerView];
    
    UIButton *backButton = toVC.backButton;
    CGRect backFrame = backButton.frame;
    CGRect backChangeFrame = backButton.frame;
    backChangeFrame.origin.x -= kBackButton;
    backButton.frame = backChangeFrame;
    
    UIImageView *avatarImageView = toVC.avatarImageView;
    CGPoint avatarCenter = avatarImageView.center;
    avatarImageView.center = CGPointMake(-kAvatarImageView, containerView.center.y);
    
    UILabel *textLabel = toVC.textView;
    CGRect textFrame = textLabel.frame;
    textLabel.frame = CGRectMake(0, CGRectGetHeight(containerView.frame), CGRectGetWidth(textFrame), CGRectGetHeight(textFrame));
    
    UIView *titleView = toVC.titleView;
    CGPoint titleOrigin = titleView.frame.origin;
    
    CGRect titleFrame  = titleView.frame;
    titleFrame.origin = textLabel.frame.origin;
    titleView.frame = titleFrame;
    titleView.alpha = 0.5f;
    
    UIView *contentView = toVC.contentView;
    CGRect contentFrame = contentView.frame;
    
    contentView.frame = CGRectMake(CGRectGetMinX(contentFrame), CGRectGetMaxY(coverImageView.frame), CGRectGetWidth(contentFrame), CGRectGetHeight(contentFrame));
    
    [containerView addSubview:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:0 animations:^{
        backButton.frame = backFrame;
        coverImageView.frame = coverFrame;
        avatarImageView.center = avatarCenter;
        textLabel.frame = textFrame;
        contentView.frame = contentFrame;
        
        CGRect frameOrigin = titleView.frame;
        frameOrigin.origin = titleOrigin;
        titleView.frame = frameOrigin;
        titleView.alpha = 1.f;
        
        
    } completion:^(BOOL finished) {
        toVC.coverImageView.hidden = NO;
        [transitionContext completeTransition:YES];
        
        [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            toVC.menuView.alpha = 1.f;
        } completion:^(BOOL finished) {
            
        }];
    }];
    
}

- (void)popAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    DetailViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UINavigationController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view atIndex:0];
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:0 animations:^{
        CGFloat x = CGRectGetWidth(containerView.frame);
        CGRect frame = fromVC.view.frame;
        frame.origin = CGPointMake(x, 0);
        fromVC.view.frame = frame;
    } completion:^(BOOL finished) {
        [fromVC.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

@end
