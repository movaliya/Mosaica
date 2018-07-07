//
//  ContactUsVW.m
//  Mosaica
//
//  Created by jignesh solanki on 03/07/2018.
//  Copyright © 2018 jignesh solanki. All rights reserved.
//

#import "ContactUsVW.h"
#import "AppDelegate.h"

@interface ContactUsVW ()

@end

@implementation ContactUsVW
@synthesize NameView,EmailView,MessageView,SubmitBtn;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self prefersStatusBarHidden];
    
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    [self.rootNav.pan_gr setEnabled:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.NameView.layer.cornerRadius = 10.0;
    self.NameView.clipsToBounds = YES;
    self.NameView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.NameView.layer.borderWidth = 1.0f;
    
    self.EmailView.layer.cornerRadius = 10.0;
    self.EmailView.clipsToBounds = YES;
    self.EmailView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.EmailView.layer.borderWidth = 1.0f;
    
    self.MessageView.layer.cornerRadius = 10.0;
    self.MessageView.clipsToBounds = YES;
    self.MessageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.MessageView.layer.borderWidth = 1.0f;
    
    self.SubmitBtn.layer.cornerRadius = 10.0;
    self.SubmitBtn.clipsToBounds = YES;
    
    [self.NameTXT setValue:[UIColor whiteColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    [self.EmailTXT setValue:[UIColor whiteColor]
                forKeyPath:@"_placeholderLabel.textColor"];
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self GetSOCOLINK];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    
    
    // Do any additional setup after loading the view.
}
- (IBAction)MenuBtn_click:(id)sender
{
    //[self.rootNav drawerToggle];
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)GetSOCOLINK
{
    
    [CommonWS Getmethod:[NSString stringWithFormat:@"%@%@",BaseUrl,Getsociallink] withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleSocialItemResponse:response];
     }];
    /*
     [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@%@",BaseUrl,Gettimetable] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
     [self handleOrderCardItemResponse:response];
     }];*/
}
- (void)handleSocialItemResponse:(NSDictionary*)response
{
    if ([[response objectForKey:@"success"] boolValue] ==YES )
    {
        socialLinkData=[[response objectForKey:@"data"]mutableCopy];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
- (IBAction)SubmitBtn_Click:(id)sender
{
    if ([_NameTXT.text isEqualToString:@""])
    {
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter Name" delegate:nil];
    }
    else if ([_EmailTXT.text isEqualToString:@""])
    {
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter Email" delegate:nil];
    }
    else if (![AppDelegate IsValidEmail:_EmailTXT.text])
    {
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter valid email" delegate:nil];
    }
    else if ([_MessageTXTVW.text isEqualToString:@""])
    {
        [AppDelegate showErrorMessageWithTitle:@"Error!" message:@"Please enter Message" delegate:nil];
    }
    else
    {
        BOOL internet=[AppDelegate connectedToNetwork];
        if (internet)
            [self CallSendFeedback];
        else
            [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    }
}
-(void)CallSendFeedback
{
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:_NameTXT.text  forKey:@"name"];
    [dictParams setObject:_EmailTXT.text  forKey:@"email"];
    [dictParams setObject:_MessageTXTVW.text  forKey:@"message"];
    
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@%@",BaseUrl,ContactUsLink] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleResponse:response];
     }];
}
- (void)handleResponse:(NSDictionary*)response
{
    if ([[response objectForKey:@"success"] boolValue] ==YES )
    {
        _NameTXT.text=@"";
        _EmailTXT.text=@"";
        _MessageTXTVW.text=@"Message";
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:@"Message Send Successfully." delegate:nil];
        
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
    
}

- (void) blinkAndFlipButtonAnimationWithText: (UIButton*) button
{
    [UIView animateWithDuration:0.7f
                     animations:^
     {
         [button setAlpha:0.5f];
     }
                     completion:^(BOOL finished)
     {
         [button setAlpha:1.0f];
         //[button setBackgroundImage:[UIImage imageNamed:@"abc.png"] forState:UIControlStateNormal];
     }
     ];
}

- (IBAction)Youtube_Click:(id)sender
{
    [self blinkAndFlipButtonAnimationWithText:sender];
    
    [self blinkAndFlipButtonAnimationWithText:sender];
    NSString *urlSTR=[[socialLinkData valueForKey:@"youtube"] objectAtIndex:0];
    
    NSURL *url = [NSURL URLWithString:urlSTR];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
   
}
- (IBAction)FB_Click:(id)sender
{
    [self blinkAndFlipButtonAnimationWithText:sender];
    
    NSString *urlSTR=[[socialLinkData valueForKey:@"facebook"] objectAtIndex:0];
    
    NSURL *url = [NSURL URLWithString:urlSTR];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}
- (IBAction)GPlus_Click:(id)sender
{
    [self blinkAndFlipButtonAnimationWithText:sender];
    
    NSString *urlSTR=[[socialLinkData valueForKey:@"googleplus"] objectAtIndex:0];
    
    NSURL *url = [NSURL URLWithString:urlSTR];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}
- (IBAction)Instragram_Click:(id)sender
{
    [self blinkAndFlipButtonAnimationWithText:sender];
    
    NSString *urlSTR=[[socialLinkData valueForKey:@"instagram"] objectAtIndex:0];
    
    NSURL *url = [NSURL URLWithString:urlSTR];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}
- (IBAction)TwitterClick:(id)sender
{
    [self blinkAndFlipButtonAnimationWithText:sender];
    
    NSString *urlSTR=[[socialLinkData valueForKey:@"twitter"] objectAtIndex:0];
    
    NSURL *url = [NSURL URLWithString:urlSTR];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}
- (IBAction)WordPress_Click:(id)sender
{
    [self blinkAndFlipButtonAnimationWithText:sender];
    
    NSString *urlSTR=[[socialLinkData valueForKey:@"websiteurl"] objectAtIndex:0];
    
    NSURL *url = [NSURL URLWithString:urlSTR];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    self.MessageTXTVW.textColor=[UIColor whiteColor];
    
    //Message_Icon.image=[UIImage imageNamed:@"MessageIconEnable"];
    
    
    if ([textView.text isEqualToString:@"Message"]) {
        textView.text = @"";
        textView.textColor = [UIColor whiteColor]; //optional
    }
    [textView becomeFirstResponder];
}


-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    self.MessageTXTVW.textColor=[UIColor whiteColor];
    
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Message";
        textView.textColor = [UIColor whiteColor]; //optional
    }
    [textView resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
