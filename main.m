//
//  main.m
//  gfxCardStatusCLI
//
//  Created by John Doe on 29/05/14.
//  Copyright (c) 2014 zais. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GSAppDelegate.h"

int main(int argc, const char * argv[])
{
    GSAppDelegate *delegate = [[GSAppDelegate alloc] init];
    
    [[NSApplication sharedApplication] setDelegate:delegate];
    [NSApp run];
    
    return 0;
}

