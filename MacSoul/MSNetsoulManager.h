//
//  MSNetsoulManager.h
//  MacSoul
//
//  Created by Julien Bordellier on 04/01/13.
//  Copyright (c) 2013 Epitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSNetworkManager.h"

@interface MSNetsoulManager : NSObject {
@private
    MSNetworkManager    *nm;
}

- (void)connect:(NSString*)host port:(int)port;

@end
