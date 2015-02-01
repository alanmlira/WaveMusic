//
//  ALAppDelegate.m
//  WaveMusic
//
//  Created by Alan Magalhães Lira on 27/10/13.
//  Copyright (c) 2013 Alan Magalhães Lira. All rights reserved.
//

#import "ALAppDelegate.h"

#import "SWRevealViewController.h"
#import "FrontViewController.h"
#import "RearViewController.h"
#import "ALPlayerViewController.h"
#import "ALViewController.h"

@implementation ALAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize inicialViewController = _inicialViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
	UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = window;
    
    FrontViewController *frontViewController = [storyboard instantiateViewControllerWithIdentifier:@"front"];
	RearViewController *rearViewController = [storyboard instantiateViewControllerWithIdentifier:@"rear"];
    ALPlayerViewController *downViewController = [storyboard instantiateViewControllerWithIdentifier:@"player"];
    ALViewController *initViewController = [storyboard instantiateViewControllerWithIdentifier:@"inicial"];
    
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
    //UIViewController *downNavigationController = [[UINavigationController alloc] initWithRootViewController:downViewController];
    
    //NSLog(@"front %@ / %@ \n rear %@ / %@ \n player %@ / %@",frontNavigationController, frontNavigationController.view,rearNavigationController, rearNavigationController.view, downViewController, downViewController.view);//downNavigationController, downNavigationController.view);
    
    SWRevealViewController *mainRevealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController andDownViewController:downViewController];//downNavigationController];
    
    //mainRevealController.playerVC = [storyboard instantiateViewControllerWithIdentifier:@"player"];
    mainRevealController.delegate = (id)self;
    
    
    self.viewController = mainRevealController;
    initViewController.mainRevealController = self.viewController;
    self.inicialViewController = initViewController;
	[self.viewController.view setBackgroundColor:[UIColor whiteColor]];
	self.window.rootViewController = self.inicialViewController;
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
