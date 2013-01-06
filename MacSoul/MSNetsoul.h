//
//  MSNetsoul.h
//  MacSoul
//
//  Created by Julien Bordellier on 04/01/13.
//  Copyright (c) 2013 Epitech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSNetsoul : NSObject {
@private
    int         state;
    NSString    *md5_key;
    NSString    *ip_key;
    NSString    *port_key;
}

#define LOGIN @"bordel_j"
#define PASSWORD @""

-(NSArray*)handshake:(NSString*)data;
-(NSString*)manage:(NSString*)data;
@end
