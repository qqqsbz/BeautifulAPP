//
//  ViewController.m
//  BeautifulAPP
//
//  Created by coder on 16/5/20.
//  Copyright © 2016年 coder. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "XBTransition.h"
@interface ViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:78.f/255.f green:151.f/255.f blue:177.f/255.f alpha:1.0f];
    [self.contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
}

- (void)tapAction
{
    DetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([DetailViewController class])];
//    self.navigationController.delegate = vc;
//    [self.navigationController pushViewController:vc animated:YES];

    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [XBTransition transitionWithTransitionType:XBTransitionTypePush];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [XBTransition transitionWithTransitionType:XBTransitionTypePop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
