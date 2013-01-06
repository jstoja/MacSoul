//
//  MSAppDelegate.h
//  MacSoul
//
//  Created by Julien Bordellier on 03/01/13.
//  Copyright (c) 2013 Epitech. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MSNetsoulManager.h"

@interface MSAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) MSNetsoulManager *nsm;

@end
