//
//  NSURLRequest+HTTPSSupport.h
//  InstagramLogin
//
//  Created by Jegathesan on 3/23/17.

#import <Foundation/Foundation.h>

@interface NSURLRequest (HTTPSSupport)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host;
@end
