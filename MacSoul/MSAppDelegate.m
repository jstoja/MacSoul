//
//  MSAppDelegate.m
//  MacSoul
//
//  Created by Julien Bordellier on 03/01/13.
//  Copyright (c) 2013 Epitech. All rights reserved.
//

#import "MSAppDelegate.h"
#import "MSNetsoulManager.h"

@implementation MSAppDelegate

// this one is taken from apple documentation
- (void)activateStatusMenu {
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    
    NSStatusItem *theItem = [bar statusItemWithLength:NSVariableStatusItemLength];
    [theItem retain];
    
    [theItem setTitle: NSLocalizedString(@"N",@"")];
    [theItem setHighlightMode:YES];
    //[theItem setMenu:theMenu];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    MSNetsoulManager *nsm = [[MSNetsoulManager alloc] init];
    
    [self activateStatusMenu];
    [nsm connect:@"tcp://ns-server.epita.fr" port:4242];
    [pool drain];
}

@end
