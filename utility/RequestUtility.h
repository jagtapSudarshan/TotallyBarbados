//
//  AppDelegate.m
//  TotallyBarbados
//
//  Created by Sudarshan on 6/21/16.
//  Copyright © 2016 Uniken. All rights reserved.

#import <Foundation/Foundation.h>

@interface RequestUtility : NSObject <NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLSessionTaskDelegate>

/** URL Constants ***/
extern NSString *const kBaseUrl;
extern NSString *const kstatusparam;
extern NSString *const ksuccessparam;
extern NSString *const kerrorparam;
+ (RequestUtility *)sharedRequestUtility;
-(void)doRequestfor:(NSString*)url withParameters:(NSDictionary*)params onComplete:(void (^)(bool status, NSDictionary  *response))completionBlock;
-(void)doPostRequestfor:(NSString*)url withParameters:(NSDictionary*)params onComplete:(void (^)(bool status, NSDictionary  *response))completionBlock;
@end
