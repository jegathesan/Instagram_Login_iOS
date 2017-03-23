//
//  InstagramLoginVC.m
//  InstagramLogin
//
//  Created by Jegathesan on 3/23/17.

#define INSTAGRAM_AUTHURL  @"https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&scope=%@&response_type=token"
#define COOKIE_DOMAIN @"www.instagram.com"
#import "InstagramLoginVC.h"

@interface InstagramLoginVC ()<UIWebViewDelegate>{
    ;
}

@end

@implementation InstagramLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView.delegate = self;
    [self loginIntoInstagram];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginIntoInstagram{
    
    NSAssert(_scope != nil, @"ERROR: SCOPE is missing");
    NSAssert(_cliendId != nil, @"ERROR: CLIENT ID is missing");
    NSAssert(_redirectURL != nil, @"ERROR: REDIRECT URL is missing");
    
    //Create login request
    NSString *requestUrl = [NSString stringWithFormat:INSTAGRAM_AUTHURL, _cliendId, _redirectURL, _scope];
    NSURL *authURL = [NSURL URLWithString:requestUrl];
    
    //Send auth request
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:authURL];
    [_webView loadRequest:request];
}

- (BOOL) checkRequestForCallbackURL: (NSURLRequest*) request
{
    NSString *currentURL = request.URL.absoluteString;
    //NSLog(@"Current URL :%@",currentURL);
    if([currentURL hasPrefix: _redirectURL])
    {
        //Extract access token from the url
        NSRange range = [currentURL rangeOfString: @"#access_token="];
        NSString *accessToken = [currentURL substringFromIndex: range.location+range.length];
        if (_delegate) {
            [_delegate didGetAccessToken:accessToken];
        }
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    return true;
}

//Logout the existing session
- (void)logoutSession{
    
    for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        if([[cookie domain] isEqualToString:COOKIE_DOMAIN]) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
}

#pragma mark - Actions
- (IBAction)closeWindow:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma args - WebView delegates
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return [self checkRequestForCallbackURL: request];
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
