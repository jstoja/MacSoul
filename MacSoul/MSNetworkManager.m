//
//  MSNetworkManager.m
//  MacSoul
//
//  Created by Julien Bordellier on 04/01/13.
//  Copyright (c) 2013 Epitech. All rights reserved.
//

#import "MSNetworkManager.h"


@implementation MSNetworkManager

- (void)setup {

    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    NSURL *url = [NSURL URLWithString:host];
    
    NSLog(@"Setting up connection to %@ : %i", [url absoluteString], port);
    CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, (CFStringRef)[url host], port, &readStream, &writeStream);
    if(!CFWriteStreamOpen(writeStream)) {
        NSLog(@"Error, writeStream not open");
        return;
    }
    
    NSLog(@"Status of outputStream: %li", [outputStream streamStatus]);
    NSLog(@"Opening streams.");
    
    inputStream = (NSInputStream *)readStream;
    outputStream = (NSOutputStream *)writeStream;
    
    [inputStream retain];
    [outputStream retain];
    
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [inputStream open];
    [outputStream open];
    
    ns = [[MSNetsoul alloc] init];
    return;
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)event {
    switch(event) {
        case NSStreamEventHasBytesAvailable: {
            if(stream == inputStream) {
                uint8_t buf[1024];
                NSInteger len = [inputStream read:buf maxLength:1024];
                if(len > 0) {
                    NSMutableData* data = [[NSMutableData alloc] initWithLength:0];
                    [data appendBytes: (const void *)buf length:len];
                    NSString *s = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                    [self readIn:s];
                    [data release];
                }
            }
            break;
        }
        default: {
            //NSLog(@"Stream is sending an Event: %li", event);
            break;
        }
    }
}

- (void)readIn:(NSString *)s {
    NSLog(@"Reading out the following: %@", s);
    NSString *answer = [ns manage:s];
    if (answer != nil) {
        [self writeOut:answer];
        [answer release];
    }
}

- (void)writeOut:(NSString *)s {
    uint8_t *buf = (uint8_t *)[s UTF8String];
    [outputStream write:buf maxLength:strlen((char *)buf)];
    NSLog(@"Writing out the following: %@", s);
}

- (void)close {
    NSLog(@"Closing streams.");
    
    [inputStream close];
    [outputStream close];
    
    [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [inputStream setDelegate:nil];
    [outputStream setDelegate:nil];
    
    [inputStream release];
    [outputStream release];
    
    inputStream = nil;
    outputStream = nil;
}
@end
