//
//  GSAppDelegate.m
//  gfxCardStatusCLI
//
//  Created by Jakub Kleň on 15/06/14.
//  Copyright (c) 2014 zais. All rights reserved.
//

#import "GSAppDelegate.h"
#import "GSMux.h"
#import "GSGPU.h"


@interface GSAppDelegate () <GSGPUDelegate>

@end


@implementation GSAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@": Starting ...");
    
    if (![GSMux switcherOpen]) {
        NSLog(@"Can't open connection to AppleGraphicsControl. This probably isn't a gfxCardStatus-compatible machine.");
    }
    else {
        NSArray *args = [[NSProcessInfo processInfo] arguments];
        if ([args indexOfObject:@"--discrete"] != NSNotFound) {
            NSLog(@": Switching to descrete  : %s", [GSMux setMode:GSSwitcherModeForceDiscrete] ? "success" : "FAIL");
        } else if ([args indexOfObject:@"--integrated"] != NSNotFound) {
            NSLog(@": Switching to integrated: %s", [GSMux setMode:GSSwitcherModeForceIntegrated] ? "success" : "FAIL");
        } else if ([args indexOfObject:@"--dynamic"] != NSNotFound) {
            NSLog(@": Switching to dynomic    status: %s", [GSMux setMode:GSSwitcherModeDynamicSwitching] ? "success" : "FAIL");
        } else if (![GSGPU isLegacyMachine]) {
            // Set the machine to dynamic switching to get it out of any kind of
            // weird state from the get go.
            [GSMux setMode:GSSwitcherModeDynamicSwitching];
        }
        
        //so that CGDisplayRegisterReconfigurationCallback is called...
        [GSGPU registerForGPUChangeNotifications:self];
        
        //switch it not instant
        sleep(1);
        
        NSLog(@": Integrated GPU         : %@%@", ([GSMux isUsingIntegratedGPU] ? @"(in use) " : @""), [GSGPU integratedGPUName]);
        NSLog(@": Discrete GPU           : %@%@", ([GSMux isUsingDiscreteGPU]   ? @"(in use) " : @""), [GSGPU discreteGPUName]);
        NSLog(@": Switching mode         : %s %s %s %s",
              ([GSMux isUsingDynamicSwitching]     ? "dynamic"         : ""),
              ([GSMux isUsingOldStyleSwitchPolicy] ? "logout-required" : ""),
              ([GSMux isOnIntegratedOnlyMode]      ? "integrated-only" : ""),
              ([GSMux isOnDiscreteOnlyMode]        ? "discrete-only"   : ""));
        NSLog(@": Done.");
    }
}

- (void)GPUDidChangeTo:(GSGPUType)gpu
{
    
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    return NSTerminateNow;
}

@end
