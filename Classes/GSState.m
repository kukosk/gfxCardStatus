//
//  GSState.m
//  gfxCardStatus
//
//  Created by Cody Krieger on 6/20/11.
//  Copyright 2011 Cody Krieger. All rights reserved.
//

#import "GSState.h"
#import "PrefsController.h"
#import "GSProcess.h"

#define NOTIFICATION_QUEUE_NAME "com.codykrieger.gfxCardStatus.notificationQueue"

static dispatch_queue_t queue = NULL;

void DisplayReconfigurationCallback(CGDirectDisplayID display, 
                                    CGDisplayChangeSummaryFlags flags, 
                                    void *userInfo);

@implementation GSState

@synthesize delegate, 
            usingIntegrated, 
            usingLegacy,
            integratedString, 
            discreteString;

- (id)init {
    self = [super init];
    if (self) {
        NSDictionary *profile = nil; //[GSProcess getGraphicsProfile];
        usingLegacy = [(NSNumber *)[profile objectForKey:@"legacy"] boolValue];
        
        queue = dispatch_queue_create(NOTIFICATION_QUEUE_NAME, NULL);
        
        CGDisplayRegisterReconfigurationCallback(DisplayReconfigurationCallback,
                                                 (__bridge void *)self);
    }
    
    return self;
}

#pragma mark -
#pragma mark Notifications

void DisplayReconfigurationCallback(CGDirectDisplayID display, 
                                    CGDisplayChangeSummaryFlags flags, 
                                    void *userInfo) {
    
    if (flags & kCGDisplaySetModeFlag) {
        dispatch_async(queue, ^(void) {
            [NSThread sleepForTimeInterval:0.1];
            
            GSState *state = (__bridge GSState *)userInfo;
            
            BOOL nowIsUsingIntegrated = [GSMux isUsingIntegrated];
            GTMLoggerInfo(@"Integrated state: %i, previous state: %i", 
                          nowIsUsingIntegrated, 
                          [state usingIntegrated]);
            
            if ((nowIsUsingIntegrated != [state usingIntegrated])) {
                // gpu has indeed changed
                [state gpuChangedFrom:(nowIsUsingIntegrated ? 
                                       kGPUTypeDiscrete : kGPUTypeIntegrated)];
            } else {
                [state gpuChangedFrom:(nowIsUsingIntegrated ? 
                                       kGPUTypeIntegrated : kGPUTypeDiscrete)];
            }
        });
    }
}

- (void)gpuChangedFrom:(GPUType)from {
    self.usingIntegrated = !self.usingIntegrated;
    GPUType to = (self.usingIntegrated ? kGPUTypeIntegrated : kGPUTypeDiscrete);
    
    if ([delegate respondsToSelector:@selector(gpuChangedTo:from:)])
        [delegate gpuChangedTo:to from:from];
}

#pragma mark -
#pragma mark Singleton methods

+ (GSState *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static GSState *_sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

@end