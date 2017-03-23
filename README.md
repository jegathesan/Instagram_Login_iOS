# Instagram_Login_iOS
Instagram Login iOS is useful for you if you're building an iOS app that requires Instagram authentication. Using this SDK you can authenticate the users in Instagram and receive the ACCESS_TOKEN. This token can be used for any further API Requests (Post, Media, Followers etc)

Let's get start

# Register Application in Instagram

In order to register your application, you must have an Instagram account. If you don’t have an Instagram account create a new one.

   1. Open the following link in browser:  http://instagram.com/developer/register/
   2. Go to “Register Your Application” and then click on the “Register New Client” button.
   3. Fill the information in Details Tab i.e, Application Name, Redirect url, Description etc. the "Redirect url” specifies where you want the users to be redirected to when they authorise the application.
  
![Details](https://github.com/jegathesan/Instagram_Login_iOS/blob/master/help_details.png)

   4. In Security Tab un check the "Disable implicit OAuth"
  
![Security](https://github.com/jegathesan/Instagram_Login_iOS/blob/master/helf_security.png)

   5. You can get a Client Id after application has registered successfully.
  
![Client Id](https://github.com/jegathesan/Instagram_Login_iOS/blob/master/help_clientid.png)


# Integrate into your iOS Application

Launch the login dialog

	InstagramLoginVC *instaLogVC = [[InstagramLoginVC alloc] initWithNibName:@"InstagramLoginVC" bundle:nil];
    instaLogVC.scope = @"basic"; //Permissions ask to user 
    instaLogVC.redirectURL = @"http://localhost/instagramlogin"; //Configured in Instagram
    instaLogVC.cliendId = @"YOUR_CLIENT_ID";
    instaLogVC.delegate = self;
    [self presentViewController:instaLogVC animated:YES completion:nil];

If you want more scope access then build a scope as

    @"likes+comments+relationships"

You will get access token in delegate method

    #pragma mark - InstagramLogin Delegates
	- (void)didGetAccessToken:(NSString *)accessToken{
	    NSLog(@"Access Token : %@", accessToken);
	    [self getUserInformation:accessToken];
	}

Sample code to get user information using Access Token

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

Reference URL

API End Points : https://www.instagram.com/developer/endpoints/

Authentication : https://www.instagram.com/developer/authentication/
