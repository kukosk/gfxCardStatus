//
//  main.m
//  gfxCardStatusCLI
//
//  Created by John Doe on 29/05/14.
//  Copyright (c) 2014 zais. All rights reserved.
//

#import "GSMux.h"
#import "GSGPU.h"
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSLog(@": Starting ...");

        if (![GSMux switcherOpen]) {
            NSLog(@"Can't open connection to AppleGraphicsControl. This probably isn't a gfxCardStatus-compatible machine.");
            return 1;
        }
        
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
        //switch it not instant
        sleep(1);
        NSLog(@": Integrated GPU         : %@%s", [GSGPU integratedGPUName], ([GSMux isUsingIntegratedGPU] ? "\t(in use)" : ""));
        NSLog(@": Discrete GPU           : %@%s", [GSGPU discreteGPUName]  , ([GSMux isUsingDiscreteGPU]   ? "\t(in use)" : ""));
        NSLog(@": Switching mode         : %s %s %s %s",
              ([GSMux isUsingDynamicSwitching]     ? "dynamic"         : ""),
              ([GSMux isUsingOldStyleSwitchPolicy] ? "logout-required" : ""),
              ([GSMux isOnIntegratedOnlyMode]      ? "integrated-only" : ""),
              ([GSMux isOnDiscreteOnlyMode]        ? "discrete-only"   : ""));
        NSLog(@": Done.");
        
    }
    return 0;
}

