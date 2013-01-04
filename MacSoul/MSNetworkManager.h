//
//  MSNetworkManager.h
//  MacSoul
//
//  Created by Julien Bordellier on 04/01/13.
//  Copyright (c) 2013 Epitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSNetsoul.h"

@interface MSNetworkManager : NSObject <NSStreamDelegate> {
@public
    
    NSString            *host;
    int                 port;
    
@private
    MSNetsoul           *ns;
    NSInputStream       *inputStream;
    NSOutputStream      *outputStream;

}

- (void)setup;
- (void)close;
- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)event;
- (void)readIn:(NSString *)s;
- (void)writeOut:(NSString *)s;

@end
