//
//  ShowTimeVC.m
//  Mosaica
//
//  Created by jignesh solanki on 03/07/2018.
//  Copyright © 2018 jignesh solanki. All rights reserved.
//

#import "ShowTimeVC.h"
#import "ShowTimeCell.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"

@interface ShowTimeVC ()
-(void)handleFBSessionStateChangeWithNotification:(NSNotification *)notification;
@property AppDelegate *appDelegate;

@end

@implementation ShowTimeVC
@synthesize TableVW;


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
   
    
    
    self.appDelegate = [AppDelegate sharedInstance];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleFBSessionStateChangeWithNotification:)
                                                 name:@"SessionStateChangeNotification"
                                               object:nil];
    
    if (IS_IPAD)
    {
        static NSString *CellIdentifier = @"ShowTimeCellIpad";
        UINib *nib = [UINib nibWithNibName:@"ShowTimeCellIpad" bundle:nil];
        [TableVW registerNib:nib forCellReuseIdentifier:CellIdentifier];
        // News_TBL.estimatedRowHeight = 220;
        TableVW.rowHeight = UITableViewAutomaticDimension;
    }
    else
    {
        static NSString *CellIdentifier = @"ShowTimeCell";
        UINib *nib = [UINib nibWithNibName:@"ShowTimeCell" bundle:nil];
        [TableVW registerNib:nib forCellReuseIdentifier:CellIdentifier];
        // News_TBL.estimatedRowHeight = 220;
        TableVW.rowHeight = UITableViewAutomaticDimension;
    }
   
    
    refreshControl = [[UIRefreshControl alloc]init];
    [TableVW addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    [refreshControl setTintColor:[UIColor whiteColor]];
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
         [self GetShowtime];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    
   
}

- (void)refreshTable {
    //TODO: refresh your data
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self GetShowtime];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    
}

-(void)GetShowtime
{
    NSString *UserID=[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    
    if (!UserID)
    {
        [CommonWS Getmethod:[NSString stringWithFormat:@"%@%@",BaseUrl,Gettimetable] withCompletion:^(NSDictionary *response, BOOL success1)
         {
             [self handleOrderCardItemResponse:response];
         }];
    }
    else
    {
         [dictParams setObject:UserID  forKey:@"user_id"];
        [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@%@",BaseUrl,Gettimetable] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
         {
             [self handleOrderCardItemResponse:response];
         }];
    }
    
    
    
}

- (void)handleOrderCardItemResponse:(NSDictionary*)response
{
    if ([[response objectForKey:@"success"] boolValue] ==YES )
    {
        
        ShowTimeData=[[response objectForKey:@"data"]mutableCopy];
        [refreshControl endRefreshing];
        [TableVW reloadData];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (IS_IPAD)
    {
        return 115.0f;

    }
    return 115.0f;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ShowTimeData.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f; // you can have your own choice, of course
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier;
    if (IS_IPAD)
    {
        CellIdentifier = @"ShowTimeCellIpad";
        
    }
    else
    {
        CellIdentifier = @"ShowTimeCell";
        
    }
    ShowTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    }
    
    
    NSString *oldTime=[[ShowTimeData valueForKey:@"show_time"]objectAtIndex:indexPath.section];
    NSString *newTime = [oldTime substringToIndex:[oldTime length]-3];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    NSDate *date = [dateFormatter dateFromString:newTime];
    dateFormatter.dateFormat = @"hh:mm a";
    NSString *pmamDateString = [dateFormatter stringFromDate:date];
    
    NSString *oldate=[[ShowTimeData valueForKey:@"showend_date"]objectAtIndex:indexPath.section];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    dateFormatter1.dateFormat = @"yyyy-MM-dd";
    NSDate *date1 = [dateFormatter1 dateFromString:oldate];
    dateFormatter1.dateFormat = @"dd MMM yyyy";
    NSString *DateString = [dateFormatter1 stringFromDate:date1];
    
    cell.Title_LBL.text=[[ShowTimeData valueForKey:@"title"]objectAtIndex:indexPath.section];
    cell.Time_LBL.text=pmamDateString;
    cell.Description_LBL.text=[[ShowTimeData valueForKey:@"description"]objectAtIndex:indexPath.section];
    cell.Date_LBL.text=DateString;
    NSString *reminder_id=[[ShowTimeData valueForKey:@"reminder_id"]objectAtIndex:indexPath.section];
    
    
    if ([reminder_id isEqualToString:@""])
    {
         UIImage *btnImage = [UIImage imageNamed:@"bellIcon.png"];
        [cell.Bell_BTN setImage:btnImage forState:UIControlStateNormal];
    }
    else
    {
        UIImage *btnImage = [UIImage imageNamed:@"ENbellIcon.png"];
        [cell.Bell_BTN setImage:btnImage forState:UIControlStateNormal];
    }
    [cell.Bell_BTN addTarget:self action:@selector(BellBTN_Click:) forControlEvents:UIControlEventTouchUpInside];
    cell.Bell_BTN.tag=indexPath.section;
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)ConnetctWithFB
{
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
    {
        
        if ([FBSession activeSession].state != FBSessionStateOpen &&
            [FBSession activeSession].state != FBSessionStateOpenTokenExtended)
        {
            [self.appDelegate openActiveSessionWithPermissions:@[@"public_profile", @"email"] allowLoginUI:YES];
        }
        else{
            // Close an existing session.
            [[FBSession activeSession] closeAndClearTokenInformation];
            // Update the UI.
        }
    }
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
}

-(void)BellBTN_Click:(id)sender
{
    UIButton *instanceButton = (UIButton*)sender;
   
    NSString *chkFBLogin=[[NSUserDefaults standardUserDefaults]objectForKey:@"Login"];
    ShowID=[[ShowTimeData valueForKey:@"timetable_id"]objectAtIndex:instanceButton.tag];
    RemidnerID=[[ShowTimeData valueForKey:@"reminder_id"]objectAtIndex:instanceButton.tag];
    
    if ([chkFBLogin isEqualToString:@"YES"])
    {
         //[AppDelegate showErrorMessageWithTitle:@"" message:@"You are already login." delegate:nil];
        if ([RemidnerID isEqualToString:@""])
        {
            [self SetReminder];
        }
        else
        {
            [self UnSetReminder];
        }
        
    }
    else
    {
        [self ConnetctWithFB];
    }
}

#pragma mark - Private method implementation

-(void)handleFBSessionStateChangeWithNotification:(NSNotification *)notification
{
    NSLog(@"result");
    // Get the session, state and error values from the notification's userInfo dictionary.
    NSDictionary *userInfo = [notification userInfo];
    
    FBSessionState sessionState = [[userInfo objectForKey:@"state"] integerValue];
    NSError *error = [userInfo objectForKey:@"error"];
    
    // Handle the session state.
    // Usually, the only interesting states are the opened session, the closed session and the failed login.
    if (!error) {
        // In case that there's not any error, then check if the session opened or closed.
        if (sessionState == FBSessionStateOpen)
        {
            [FBRequestConnection startWithGraphPath:@"me"
                                         parameters:@{@"fields": @"first_name, last_name, picture.type(normal), email"}
                                         HTTPMethod:@"GET"
                                  completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                      if (!error) {
                                          NSLog(@"result=%@",result);
                                         
                                          FBSignIndictParams = [[NSMutableDictionary alloc] init];
                                          [FBSignIndictParams setObject:[result objectForKey:@"id"]  forKey:@"facebook_id"];
                                          [FBSignIndictParams setObject:@"ios"  forKey:@"device_type"];
                                          
                                          if (self.appDelegate.FCMDeviceToken)
                                          {
                                              [FBSignIndictParams setObject:self.appDelegate.FCMDeviceToken  forKey:@"fcm_token"];
                                          }
                                          else
                                          {
                                               [FBSignIndictParams setObject:@"DeviceToken"  forKey:@"fcm_token"];
                                          }
                                          [self CallFBLogin];
                                          
                                          // Get the user's profile picture.
                                          NSURL *pictureURL = [NSURL URLWithString:[[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"]];
                                      }
                                      else
                                      {
                                          NSLog(@"%@", [error localizedDescription]);
                                      }
                                  }];
            
        }
        else if (sessionState == FBSessionStateClosed || sessionState == FBSessionStateClosedLoginFailed){
            // A session was closed or the login was failed. Update the UI accordingly.
        }
    }
    else{
        // In case an error has occurred, then just log the error and update the UI accordingly.
        NSLog(@"Error: %@", [error localizedDescription]);
    }
}
-(void)CallFBLogin
{
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@%@",BaseUrl,FBLogin] withParam:FBSignIndictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleResponse:response];
     }];
}

- (void)handleResponse:(NSDictionary*)response
{
    if ([[response objectForKey:@"success"] boolValue] ==YES )
    {
        NSDictionary *datashow=[[response objectForKey:@"data"] mutableCopy];
        [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Login"];
        
         [[NSUserDefaults standardUserDefaults]setObject:[datashow valueForKey:@"user_id"] forKey:@"UserId"];
        //[AppDelegate showErrorMessageWithTitle:AlertTitleError message:@"Login Successfully." delegate:nil];
        [self SetReminder];
        
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
    
}
-(void)SetReminder
{
     NSString *UserID=[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:ShowID  forKey:@"timetable_id"];
    [dictParams setObject:UserID  forKey:@"user_id"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@%@",BaseUrl,SetReminderForShow] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleSetReminderResponse:response];
     }];
}

- (void)handleSetReminderResponse:(NSDictionary*)response
{
    if ([[response objectForKey:@"success"] boolValue] ==YES )
    {
        [self GetShowtime];
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:@"Show Active." delegate:nil];
        
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
    
}
-(void)UnSetReminder
{
    NSString *UserID=[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:ShowID  forKey:@"timetable_id"];
    [dictParams setObject:UserID  forKey:@"user_id"];
    [dictParams setObject:RemidnerID  forKey:@"reminder_id"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@%@",BaseUrl,UnSet_Reminder] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleunSetReminderResponse:response];
     }];
}

- (void)handleunSetReminderResponse:(NSDictionary*)response
{
    if ([[response objectForKey:@"success"] boolValue] ==YES )
    {
        [self GetShowtime];
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:@"Unset Reminder for this Show" delegate:nil];
        
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
    
}

- (IBAction)MenuBtn_Click:(id)sender {
      //[self.rootNav drawerToggle];
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
