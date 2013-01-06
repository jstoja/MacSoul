//
//  MSNetsoulManager.m
//  MacSoul
//
//  Created by Julien Bordellier on 04/01/13.
//  Copyright (c) 2013 Epitech. All rights reserved.
//

#import "MSNetsoulManager.h"

@implementation MSNetsoulManager
- (void)connect:(NSString*)host port:(int)port {
    if (nm == nil) {
        nm = [[MSNetworkManager alloc] init];
        nm->host = host;
        nm->port = port;
        [nm setup];
    }
}

- (void)exit {
    if (nm != nil) {
        [nm writeOut:@"exit"];
        [nm close];
        [nm release];
    }
}
@end
