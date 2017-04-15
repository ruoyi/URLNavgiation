//
//  URLNavigation.m
//  dailycare
//
//  Created by ruoyi on 15/10/21.
//  Copyright © 2015年 ruoyi. All rights reserved.
//

#import "URLNavigation.h"

@implementation URLNavigation

#pragma mark - Public Method

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!viewController) {
        return;
    }
  
    [self pushViewController:viewController animated:animated replace:NO];
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated replace:(BOOL)replace {
    if (!viewController) {
        return;
    }
    
    viewController.hidesBottomBarWhenPushed = YES;
    UINavigationController *navigationController = [self currentNavigationViewController];
    if (replace && navigationController.viewControllers.count > 1) {
        NSArray *viewControllers = [navigationController.viewControllers subarrayWithRange:NSMakeRange(0, navigationController.viewControllers.count-1)];
        [navigationController setViewControllers:[viewControllers arrayByAddingObject:viewController] animated:animated];
    } else {
        [navigationController pushViewController:viewController animated:animated];
    }

}

+ (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!viewController) {
        return;
    }
    
    UIViewController *currentViewController = [self currentViewController];
    [currentViewController presentViewController:viewController animated:animated completion:nil];
}

+ (void)presentViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                  autoWithNav:(BOOL)autoWith {
    
    if (!viewController) {
        return;
    }
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [self presentViewController:viewController animated:animated];
        return;
    }
    
    if (autoWith) {
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
        [self presentViewController:nav animated:animated];
    } else {
        [self presentViewController:viewController animated:animated];
    }

}

+ (void)dismissCurrentAnimated:(BOOL)animated {
    UIViewController *currentViewController = [self currentViewController];
    if(currentViewController.navigationController){
      if(currentViewController.navigationController.viewControllers.count == 1){
          if(currentViewController.presentingViewController){
              [currentViewController dismissViewControllerAnimated:animated completion:nil];
          }
      }else{
          [currentViewController.navigationController popViewControllerAnimated:animated];
      }
    }else if(currentViewController.presentingViewController){
      [currentViewController dismissViewControllerAnimated:animated completion:nil];
    }
}

+ (void)dismissToSecondViewAnimated:(BOOL)animated {
    UIViewController *currentViewController = [self currentViewController];
    if(currentViewController){
        if(currentViewController.navigationController){
            if(currentViewController.navigationController.viewControllers.count == 1){
                if(currentViewController.presentingViewController){
                    [currentViewController dismissViewControllerAnimated:animated completion:nil];
                }
            }else if (currentViewController.navigationController.viewControllers.count == 2){
                [currentViewController.navigationController popViewControllerAnimated:animated];
            }else if (currentViewController.navigationController.viewControllers.count > 2){
                [currentViewController.navigationController popToViewController:[currentViewController.navigationController.viewControllers objectAtIndex:1] animated:animated];
            }
        }else if(currentViewController.presentingViewController){
            [currentViewController dismissViewControllerAnimated:animated completion:nil];
        }
    }
}

+ (void)dismissToRootNavi:(BOOL)animated {
    UIViewController *currentViewController = [self currentViewController];
    if (currentViewController.navigationController) {
        [currentViewController.navigationController popToRootViewControllerAnimated:animated];
    }
}

+ (void)dismissAllPresentedVC {
    UIViewController *currentViewController = [self currentViewController];
    if(currentViewController.navigationController) {
        if(currentViewController.navigationController.viewControllers.count == 1){
            if(currentViewController.presentingViewController){
                [currentViewController dismissViewControllerAnimated:NO completion:^{
                    [self dismissAllPresentedVC];
                }];
            }
        } else {
            [currentViewController.navigationController popToRootViewControllerAnimated:NO];
            [self dismissAllPresentedVC];
        }
    } else if(currentViewController.presentingViewController) {
        [currentViewController dismissViewControllerAnimated:NO completion:^{
            [self dismissAllPresentedVC];
        }];
    }
}

#pragma mark - Private Methods

+ (UIViewController*)currentViewController {
  UIViewController* rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
  return [self currentViewControllerFrom:rootViewController];
}

+ (UINavigationController*)currentNavigationViewController {
  UIViewController* currentViewController = [self currentViewController];
  return currentViewController.navigationController;
}

+ (UIViewController*)currentViewControllerFrom:(UIViewController*)viewController {
  if ([viewController isKindOfClass:[UINavigationController class]]) {
    UINavigationController* navigationController = (UINavigationController *)viewController;
    return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
  } else if([viewController isKindOfClass:[UITabBarController class]]) {
    UITabBarController* tabBarController = (UITabBarController *)viewController;
    return [self currentViewControllerFrom:tabBarController.selectedViewController];
  } else if(viewController.presentedViewController != nil) {
    return [self currentViewControllerFrom:viewController.presentedViewController];
  } else {
    return viewController;
  }
}

+ (void)toTabBarIndex:(NSUInteger)index {
    NSObject<UIApplicationDelegate> *delegate = [UIApplication sharedApplication].delegate;
    id controller = delegate.window.rootViewController;
    if ([controller isKindOfClass:[UITabBarController class]]) {
        if (index < [(UITabBarController *)controller viewControllers].count) {
            [(UITabBarController *)controller setSelectedIndex:index];
        }
    }
}

@end
