//
//  NSURLRequest+HTTPSSupport.m
//  InstagramLogin
//
//  Created by Jegathesan on 3/23/17.

#import "NSURLRequest+HTTPSSupport.h"

@implementation NSURLRequest (HTTPSSupport)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}
@end
