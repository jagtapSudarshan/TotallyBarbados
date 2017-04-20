//
//  AppDelegate.m
//  TotallyBarbados
//
//  Created by Sudarshan on 6/21/16.
//  Copyright © 2016 Uniken. All rights reserved.

#import "RequestUtility.h"

@implementation RequestUtility

NSString *const kBaseUrl = @"http://amolcentos.cloudapp.net:8080/APIBanking"; /**Actual url **/
NSString *const kstatusparam = @"status";
NSString *const ksuccessparam = @"success";
NSString *const kerrorparam = @"error";



+ (RequestUtility *)sharedRequestUtility {
  __strong static RequestUtility *httpRequestUtility = nil;
  static dispatch_once_t onceToken1;
  dispatch_once(&onceToken1, ^{
    httpRequestUtility = [[self alloc] init];
  });
  return httpRequestUtility;
}

-(void)doRequestfor:(NSString*)url withParameters:(NSDictionary*)params onComplete:(void (^)(bool status, NSDictionary  *response))completionBlock{
  
  if ([self isNetworkAvailable]) {
//    NSString *urlString = [NSString stringWithFormat:@"%@/%@",kBaseUrl,url];
//    NSArray *key = [params allKeys];
//    NSArray *values = [params allValues];
//    for (int i =0; i<[key count]; i++) {
//      NSMutableString *string = [NSMutableString stringWithFormat:@"%@=%@&",[key objectAtIndex:i],[values objectAtIndex:i]];
//      urlString = [urlString stringByAppendingFormat:@"%@",string];
//    }
//    urlString = [urlString substringToIndex:[urlString length]-1];
//    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
//    NSLog(@" $$$$$ \n\n The url string is %@ $$$$ \n\n",urlString);
    NSURL *URL = [NSURL URLWithString:url];
    NSURLSessionConfiguration *configuration;
    configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:URL];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request1 completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
      if (data.length>0) {
        NSString* responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"\n\n\n The reponse from server is : %@ \n\n", responseString);
        NSDictionary* responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:kNilOptions
                                                                             error:&error];
        //if ([[responseDictionary valueForKey:kstatusparam] isEqualToString:ksuccessparam]) {
          completionBlock(YES,responseDictionary);
        //}else{
          //completionBlock(NO,responseDictionary);
        //}
      }else{
        NSMutableDictionary* responseDictionary = [[NSMutableDictionary alloc]init];
        [responseDictionary setValue:@"The request timed out" forKey:@"error"];
        completionBlock(NO,responseDictionary);
      }
    }];
    [task resume];
  }else{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NetworkConnectivity"
                                                        object:nil];
  }
}


-(void)doPostRequestfor:(NSString*)url withParameters:(NSDictionary*)params onComplete:(void (^)(bool status, NSDictionary  *response))completionBlock{
  if ([self isNetworkAvailable]) {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    if (params.count>0) {
      NSArray *key = [params allKeys];
      NSArray *values = [params allValues];
      NSMutableString *postData = [[NSMutableString alloc]init];
      for (int i =0; i<[key count]; i++) {
        NSString *str =[NSString stringWithFormat:@"%@=%@&",[key objectAtIndex:i],[values objectAtIndex:i]];
        [postData appendString:str];
      }
      postData = (NSMutableString*)[postData substringToIndex:[postData length]-1];
      NSData* data=[postData dataUsingEncoding:NSUTF8StringEncoding];
      [request setHTTPBody:data];
    }
    else{
      
    }
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      if (data.length>0) {
        NSString* responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"\n\n\n The reponse from server is : %@ \n\n", responseString);
        NSDictionary* responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:kNilOptions
                                                                             error:&error];
        completionBlock(YES,responseDictionary);
        
      }else{
        NSMutableDictionary* responseDictionary = [[NSMutableDictionary alloc]init];
        [responseDictionary setValue:@"The request timed out" forKey:@"error"];
        completionBlock(NO,responseDictionary);
      }
    }];
    
    [postDataTask resume];
  }else{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NetworkConnectivity"
                                                        object:nil];
  }
}

- (BOOL)isNetworkAvailable
{
  CFNetDiagnosticRef dReference;
  dReference = CFNetDiagnosticCreateWithURL (kCFAllocatorDefault, (__bridge CFURLRef)[NSURL URLWithString:@"www.apple.com"]);
  CFNetDiagnosticStatus status;
  status = CFNetDiagnosticCopyNetworkStatusPassively (dReference, NULL);
  CFRelease (dReference);
  if ( status == kCFNetDiagnosticConnectionUp )
  {
    NSLog (@"Connection is Available");
    return YES;
  }
  else
  {
    NSLog (@"Connection is down");
    return NO;
  }
}

@end
