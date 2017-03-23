//
//  InstagramLoginVC.h
//  InstagramLogin
//
//  Created by Jegathesan on 3/23/17.

#import <UIKit/UIKit.h>

@protocol InstagramLoginDelegate <NSObject>

@required

- (void)didGetAccessToken:(NSString *)accessToken;

@end


@interface InstagramLoginVC : UIViewController
@property (weak, nonatomic) id <InstagramLoginDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) NSString *authUrl, *cliendId, *clientSceret, *redirectURL, *scope;
- (void)logoutSession;

@end
