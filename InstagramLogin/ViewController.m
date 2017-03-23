//
//  ViewController.m
//  InstaLog
//
//  Created by Jegathesan on 3/23/17.

#import "ViewController.h"
#import "InstagramLoginVC.h"

@interface ViewController ()<InstagramLoginDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getUserInformation:(NSString *)accessToken{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSString *endUrl = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/?access_token=%@",accessToken];
    NSURL *url = [NSURL URLWithString:endUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            NSDictionary *userDetails = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:kNilOptions
                                                                          error:&error];
            NSLog(@"User Details: %@", userDetails);
        }
    }];
    
    [dataTask resume];
}

#pragma mark - Actions
- (IBAction)loginWithInstagram:(id)sender {
    InstagramLoginVC *instaLogVC = [[InstagramLoginVC alloc] initWithNibName:@"InstagramLoginVC" bundle:nil];
    instaLogVC.scope = @"basic";
    instaLogVC.redirectURL = @"http://localhost/demo#access_token=dsfgsdfgsdfg";
    instaLogVC.cliendId = @"b815f2defb6748b0acd1f6964e7599ee";
    instaLogVC.delegate = self;
    instaLogVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:instaLogVC animated:YES completion:nil];
}

#pragma mark - InstagramLogin Delegates
- (void)didGetAccessToken:(NSString *)accessToken{
    NSLog(@"Access Token : %@", accessToken);
    [self getUserInformation:accessToken];
}



@end
