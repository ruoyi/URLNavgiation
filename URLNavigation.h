//
//  URLNavigation.h
//  dailycare
//
//  Created by ruoyi on 15/10/21.
//  Copyright © 2015年 ruoyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface URLNavigation : NSObject

+ (UIViewController*)currentViewController;

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
//替换当前页面
+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated replace:(BOOL)replace;

+ (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated;

+ (void)presentViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                  autoWithNav:(BOOL)autoWith;

+ (void)dismissCurrentAnimated:(BOOL)animated;

+ (void)dismissToSecondViewAnimated:(BOOL)animated;

+ (void)dismissToRootNavi:(BOOL)animated;

+ (void)dismissAllPresentedVC;

//tabBar 跳转
+ (void)toTabBarIndex:(NSUInteger)index;

@end
