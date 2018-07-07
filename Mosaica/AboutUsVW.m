//
//  AboutUsVW.m
//  Mosaica
//
//  Created by jignesh solanki on 03/07/2018.
//  Copyright © 2018 jignesh solanki. All rights reserved.
//

#import "AboutUsVW.h"

@interface AboutUsVW ()

@end

@implementation AboutUsVW

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self prefersStatusBarHidden];
    
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    [self.rootNav.pan_gr setEnabled:YES];
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self GetAbout];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
}
-(void)GetAbout
{
    
    [CommonWS Getmethod:[NSString stringWithFormat:@"%@%@",BaseUrl,aboutLink] withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleaboutResponse:response];
     }];
    
}
- (void)handleaboutResponse:(NSDictionary*)response
{
    if ([[response objectForKey:@"success"] boolValue] ==YES )
    {
        NSMutableDictionary *About=[[response objectForKey:@"data"]mutableCopy];
        _TextVW.text=[[About valueForKey:@"content"]objectAtIndex:0];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)MenuBtn_Click:(id)sender
{
   // [self.rootNav drawerToggle];
    [self.navigationController popViewControllerAnimated:YES];

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
