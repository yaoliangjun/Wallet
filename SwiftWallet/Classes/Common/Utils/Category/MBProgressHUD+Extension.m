//
//  MBProgressHUD+Extension.m
//
//
//  Created by yaoliangjun on 2017/10/27.
//  Copyright © 2017年 weiqitong. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kHUDBackgroundColor kHexRGB(0x000000)
#define kHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static NSTimeInterval delayInterval = HUDDurationLong;
static CGFloat alpha = 0.7;

@implementation MBProgressHUD (Extension)

#pragma mark - 显示然后消失
/** 默认的HUD，2秒后消失 */
+ (void)showWithStatus:(NSString *)status
{
    [self showWithStatus:status duration:delayInterval];
}

/**
 HUD消失后再做一些事情
 @param status 显示的文字
 @param completionHandle 回调
 */
+ (void)showWithStatus:(NSString *)status completionHandle:(void(^)())completionHandle
{
    [self showWithStatus:status duration:delayInterval];

    if (completionHandle) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            completionHandle();
        });
    }
}

/**
 HUD消失后再做一些事情:显示1秒
 @param status 显示的文字
 @param completionHandle 回调
 */
+ (void)showShortWithStatus:(NSString *)status completionHandle:(void(^)())completionHandle
{
    [self showWithStatus:status duration:HUDDurationShort];

    if (completionHandle) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(HUDDurationShort * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            completionHandle();
        });
    }
}

/**
 HUD消失后再做一些事情:显示2秒
 @param status 显示的文字
 @param completionHandle 回调
 */
+ (void)showLongWithStatus:(NSString *)status completionHandle:(void(^)())completionHandle
{
    [self showWithStatus:status duration:HUDDurationLong];

    if (completionHandle) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(HUDDurationLong * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            completionHandle();
        });
    }
}

/**
 HUD消失后再做一些事情
 @param status 显示的文字
 @param duration 显示多久,单位是秒
 @param completionHandle 回调
 */
+ (void)showWithStatus:(NSString *)status duration:(float)duration completionHandle:(void(^)())completionHandle
{
    [self showWithStatus:status duration:duration];

    if (completionHandle) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            completionHandle();
        });
    }
}

/**
 显示一个HUD
 @param status 需要显示的文字
 @param duration 显示多久,单位是秒
 */
+ (void)showWithStatus:(NSString *)status duration:(float)duration
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD defaultHUD];
        hud.mode = MBProgressHUDModeText;
        hud.label.font = [UIFont systemFontOfSize:12];
        hud.label.text = status;
        hud.label.textColor = [UIColor whiteColor];
        hud.label.numberOfLines = 0;
        [hud hideAnimated:NO afterDelay:duration];
    });
}

    // 显示一个图片HUD
+ (void)showStatus:(NSString *)status imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD defaultHUD];
        hud.mode = MBProgressHUDModeCustomView;
        UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        hud.customView = [[UIImageView alloc] initWithImage:image];
        hud.square = YES;
        hud.label.font = [UIFont systemFontOfSize:12];
        hud.label.text = status;
        hud.label.numberOfLines = 0;
        [hud hideAnimated:NO afterDelay:delayInterval];
    });
}

/** 获取一个通用的HUD */
+ (MBProgressHUD *)defaultHUD
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.bezelView.backgroundColor = kHUDBackgroundColor;
    hud.bezelView.alpha = alpha;
    hud.bezelView.layer.cornerRadius = 5;
    hud.contentColor = [UIColor whiteColor];

    return hud;
}

#pragma mark - 持续显示
/** 显示菊花HUD */
+ (void)showLoading
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD defaultHUD];
        CGFloat hudWH = 100;
        CGRect frame = hud.frame;
        frame = CGRectMake((SCREEN_WIDTH - hudWH) / 2, (SCREEN_HEIGHT - hudWH) / 2, hudWH, hudWH);
        hud.frame = frame;
        kKeyWindow.userInteractionEnabled = NO; // 禁止交互
    });
}

/** 显示带文字的菊花HUD */
+ (void)showLoadingWithStatus:(NSString *)status
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD defaultHUD];
        hud.label.text = status;
        hud.label.numberOfLines = 0;
        hud.label.font = [UIFont systemFontOfSize:12];
    });
}

/** 隐藏菊花HUD */
+ (void)dismiss
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:kKeyWindow];
        [hud hideAnimated:NO];
        kKeyWindow.userInteractionEnabled = YES; // 允许交互
    });
}

@end

