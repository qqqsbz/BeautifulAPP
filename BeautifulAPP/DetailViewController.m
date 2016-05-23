//
//  DetailViewController.m
//  BeautifulAPP
//
//  Created by coder on 16/5/20.
//  Copyright © 2016年 coder. All rights reserved.
//

#import "DetailViewController.h"
#import "XBTransition.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.backButton.layer.masksToBounds = YES;
    self.backButton.layer.cornerRadius  = CGRectGetWidth(self.backButton.frame) / 2.f;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    return [XBTransition transitionWithTransitionType:operation == UINavigationControllerOperationPush ? XBTransitionTypePush : XBTransitionTypePop];
}

- (IBAction)backAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
