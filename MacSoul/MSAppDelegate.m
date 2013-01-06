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

@synthesize nsm;

// this one is taken from apple documentation
- (void)activateStatusMenu {
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    
    NSStatusItem *theItem = [bar statusItemWithLength:NSVariableStatusItemLength];
    [theItem retain];
    
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Actions"];

    NSMenuItem *connect = [[NSMenuItem alloc] init];
    [connect setTitle:@"Connect"];
    [connect setAction:@selector(connect)];
    [menu addItem:connect];
    
    NSMenuItem *deconnect = [[NSMenuItem alloc] init];
    [deconnect setTitle:@"Deconnect"];
    [deconnect setAction:@selector(deconnect)];
    [menu addItem:deconnect];
    
    NSMenuItem *exit = [[NSMenuItem alloc] init];
    [exit setTitle:@"Exit"];
    [exit setAction:@selector(exit)];
    [menu addItem:exit];

    
    [theItem setMenu:menu];
    [theItem setTitle: NSLocalizedString(@"N",@"")];
    [theItem setHighlightMode:YES];
}

- (void)exit {
    [nsm exit];
    [nsm release];
    exit(0);
}

- (void)deconnect {
    [nsm exit];
}

- (void)connect {
    nsm = [[MSNetsoulManager alloc] init];
    [nsm connect:@"tcp://ns-server.epita.fr" port:4242];
    NSLog(@"CONNECTION");
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    [self activateStatusMenu];
    [pool drain];
}

@end
