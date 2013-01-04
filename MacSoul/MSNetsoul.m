//
//  MSNetsoul.m
//  MacSoul
//
//  Created by Julien Bordellier on 04/01/13.
//  Copyright (c) 2013 Epitech. All rights reserved.
//

#include <time.h>
#import <CommonCrypto/CommonDigest.h>
#import "MSNetsoul.h"

@implementation MSNetsoul

- (NSString*)manage:(NSString *)data {
    NSRange range;
    range.location = 0;
    range.length = 5;
    if ([data compare:@"salut" options:NSLiteralSearch range:range] == NSOrderedSame) {
        state = 0;
        return [self saveKeys:data];
    } else if ([data compare:@"rep 002 -- cmd end\n"] == NSOrderedSame) {
        if (state == 0) {
            state = 1;
            return [self authenticate];
        } else if (state == 1) {
            state = 2;
            return [[NSString alloc] initWithFormat:@"user_cmd state %@:%ld\n", @"actif", time2posix(time(NULL))];
        } else {
            return nil;
        }
    } else if ([data compare:@"rep 031 -- ext user already loged\n"] == NSOrderedSame) {
        return @"exit\n";
    }
    range.length = 4;
    if ([data compare:@"ping" options:NSLiteralSearch range:range] == NSOrderedSame) {
        return data;
    }
    return nil;
}

-(NSString*)authenticate {
    NSString *input = [[NSString alloc] initWithFormat:@"%@-%@/%@%@", md5_key, ip_key, port_key, PASSWORD];
    unsigned char *result = alloca(17);
    CC_MD5([input UTF8String], (int)[input length], result);
    
    NSString *rep = [[NSString alloc] initWithFormat:@"ext_user_log %@ %02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x none nowhere\n", LOGIN,
                     result[0], result[1], result[2], result[3],
                     result[4], result[5], result[6], result[7],
                     result[8], result[9], result[10], result[11],
                     result[12], result[13], result[14], result[15]];
    return rep;
}

-(NSString*)saveKeys: (NSString*)data {
    NSArray *keys = [data componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    md5_key = [keys[2] copy];
    ip_key = [keys[3] copy];
    port_key = [keys[4] copy];
    return @"auth_ag ext_user none none\n";
}

-(NSArray*)handshake:(NSString*)data {
    return nil;
}

@end
