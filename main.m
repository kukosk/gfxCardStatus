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
            NSLog(@": Switching to descrete       : %s", [GSMux setMode:GSSwitcherModeForceDiscrete]    ? "success" : "FAIL");
        } else if ([args indexOfObject:@"--integrated"] != NSNotFound) {
            NSLog(@": Switching to integrated     : %s", [GSMux setMode:GSSwitcherModeForceIntegrated]  ? "success" : "FAIL");
        } else if ([args indexOfObject:@"--dynamic"] != NSNotFound) {
            NSLog(@": Switching to dynomic    status: %s", [GSMux setMode:GSSwitcherModeDynamicSwitching] ? "success" : "FAIL");
        } else if (![GSGPU isLegacyMachine]) {
            // Set the machine to dynamic switching to get it out of any kind of
            // weird state from the get go.
            [GSMux setMode:GSSwitcherModeDynamicSwitching];
        }

        //NSLog(@": GPUs present                : %@",   [GSGPU getGPUNames]);
        NSLog(@": Integrated GPU              : %@",   [GSGPU integratedGPUName]);
        NSLog(@": Discrete GPU                : %@",   [GSGPU discreteGPUName]);
        NSLog(@": isUsingIntegratedGPU        : %s",   [GSMux isUsingIntegratedGPU]        ? "true" : "false");
        NSLog(@": isUsingDiscreteGPU          : %s",   [GSMux isUsingDiscreteGPU]          ? "true" : "false");
        NSLog(@": isUsingDynamicSwitching     : %s",   [GSMux isUsingDynamicSwitching]     ? "true" : "false");
        NSLog(@": isUsingOldStyleSwitchPolicy : %s",   [GSMux isUsingOldStyleSwitchPolicy] ? "true" : "false");
        NSLog(@": isOnIntegratedOnlyMode      : %s",   [GSMux isOnIntegratedOnlyMode]      ? "true" : "false");
        NSLog(@": isOnDiscreteOnlyMode        : %s",   [GSMux isOnDiscreteOnlyMode]        ? "true" : "false");


        NSLog(@": Done.");
        
    }
    return 0;
}

