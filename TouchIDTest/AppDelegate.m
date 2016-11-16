//
//  AppDelegate.m
//  TouchIDTest
//
//  Created by xhm on 2016/11/15.
//  Copyright © 2016年 xhm. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import "UIView+Extension.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface AppDelegate ()
{
    UIView*view;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor=[UIColor whiteColor];
    [_window makeKeyAndVisible];
//    [[ViewController new] presentViewController:[BecomViewController new] animated:YES completion:nil];
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    _window.rootViewController=nav;
    view=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor=[UIColor grayColor];
    [self.window addSubview:view];
 
    [self.window bringSubviewToFront:view];
    
    [self addItemAsync];
    [self copyMatchingAsync];
//    [self evaluateAuthenticate];
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
     view.y=0;
//     [self deleteItemAsync];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)deleteItemAsync
{
    NSDictionary *query = @{
                            (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService: @"SampleService"
                            };
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        OSStatus status = SecItemDelete((__bridge CFDictionaryRef)(query));
        
    });
}
- (NSString *)keychainErrorToString: (NSInteger)error
{
    
    NSString *msg = [NSString stringWithFormat:@"%ld",(long)error];
    
    switch (error) {
        case errSecSuccess:
            msg = NSLocalizedString(@"SUCCESS", nil);
            break;
        case errSecDuplicateItem:
            msg = NSLocalizedString(@"ERROR_ITEM_ALREADY_EXISTS", nil);
            break;
        case errSecItemNotFound :
            msg = NSLocalizedString(@"ERROR_ITEM_NOT_FOUND", nil);
            break;
        case -26276: // this error will be replaced by errSecAuthFailed
            msg = NSLocalizedString(@"ERROR_ITEM_AUTHENTICATION_FAILED", nil);
            
        default:
            break;
    }
    
    return msg;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
    [self addItemAsync];
    [self copyMatchingAsync];
//    [self evaluateAuthenticate];
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)copyMatchingAsync
{
    NSDictionary *query = @{
                            (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService: @"SampleService",
                            (__bridge id)kSecReturnData: @YES,
                            (__bridge id)kSecUseOperationPrompt: NSLocalizedString(@"通过验证指纹解锁程序", nil)
                            };
    
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void){
        CFTypeRef dataTypeRef = NULL;
        
        OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)(query), &dataTypeRef);
        NSData *resultData = (__bridge NSData *)dataTypeRef;
        NSString * result = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        
        NSString *msg = [NSString stringWithFormat:NSLocalizedString(@"SEC_ITEM_COPY_MATCHING_STATUS", nil), [self keychainErrorToString:status]];
        if (status==0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                [UIView animateWithDuration:0.3 animations:^{
                    view.y=view.height;
                } completion:^(BOOL finished) {

                }];

            });
        }
        if (resultData)
            msg = [msg stringByAppendingString:[NSString stringWithFormat:NSLocalizedString(@"RESULT", nil), result]];
                //        [self printResult:self.textView message:msg];
    });
   
}

- (void)addItemAsync
{
    CFErrorRef error = NULL;
    SecAccessControlRef sacObject;
    
    // Should be the secret invalidated when passcode is removed? If not then use kSecAttrAccessibleWhenUnlocked
    sacObject = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
                                                kSecAccessControlUserPresence, &error);
    if(sacObject == NULL || error != NULL)
    {
        NSLog(@"can't create sacObject: %@", error);
        return;
    }

    NSDictionary *attributes = @{
                                 (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                                 (__bridge id)kSecAttrService: @"SampleService",
                                 (__bridge id)kSecValueData: [@"SECRET_PASSWORD_TEXT" dataUsingEncoding:NSUTF8StringEncoding],
                                 (__bridge id)kSecUseNoAuthenticationUI: @YES,
                                 (__bridge id)kSecAttrAccessControl: (__bridge id)sacObject
                                 };
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        OSStatus status =  SecItemAdd((__bridge CFDictionaryRef)attributes, nil);

    });
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
 
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
