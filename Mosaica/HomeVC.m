//
//  HomeVC.m
//  Mosaica
//
//  Created by jignesh solanki on 03/07/2018.
//  Copyright © 2018 jignesh solanki. All rights reserved.
//

#import "HomeVC.h"
#import "HomeCELL1.h"
#import "HomeCELL2.h"
#import "UIButton+WebCache.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "AppDelegate.h"

@interface HomeVC ()
{
    UIRefreshControl *refreshControl;
}
@property AppDelegate *appDelegate;

@end

@implementation HomeVC
@synthesize tableVW;

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
    static NSString *CellIdentifier1 = @"HomeCELL1";
    static NSString *CellIdentifier2 = @"HomeCELL2";
    
    UINib *nib = [UINib nibWithNibName:@"HomeCELL1" bundle:nil];
    [tableVW registerNib:nib forCellReuseIdentifier:CellIdentifier1];
    
    nib = [UINib nibWithNibName:@"HomeCELL2" bundle:nil];
    [tableVW registerNib:nib forCellReuseIdentifier:CellIdentifier2];
    
    refreshControl = [[UIRefreshControl alloc]init];
    [tableVW addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    [refreshControl setTintColor:[UIColor whiteColor]];
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self performSelector:@selector(GetBanner) withObject:nil afterDelay:0.0f];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    
    
}

- (void)refreshTable
{
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
        [self performSelector:@selector(GetBanner) withObject:nil afterDelay:0.0f];
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
}

-(void)GetBanner
{
    [CommonWS Getmethod:[NSString stringWithFormat:@"%@%@",BaseUrl,bannerLink] withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleBannerResponse:response];
     }];
}

- (void)handleBannerResponse:(NSDictionary*)response
{
    if ([[response objectForKey:@"success"] boolValue] ==YES )
    {
        BannerData=[[response objectForKey:@"data"]mutableCopy];
        [refreshControl endRefreshing];
        [tableVW reloadData];
    }
    else
    {
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 200.0f;
    }
    else
    {
        return 180.0f;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return BannerData.count+1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.; // you can have your own choice, of course
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier1 = @"HomeCELL1";
   // static NSString *CellIdentifier2 = @"HomeCELL2";
    
    // Upper Cell
    if (indexPath.section ==0)
    {
        
//        static NSString *CellIdentifier = @"HomeCELL1";
//        HomeCELL1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        cell=nil;
//        if (cell == nil)
//        {
//            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        }
        
        HomeCELL1 *cell = (HomeCELL1 *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        cell.TVWebview.backgroundColor=[UIColor blackColor];
        cell.TVWebview.delegate = self;
        cell.TVWebview.allowsInlineMediaPlayback       = YES;
        cell.TVWebview.mediaPlaybackRequiresUserAction = YES;
        [cell.TVWebview.scrollView setShowsVerticalScrollIndicator:NO];
        cell.TVWebview.scrollView.contentSize = CGSizeMake(cell.TVWebview.frame.size.width, cell.TVWebview.frame.size.height);
        
        CGFloat width = cell.TVWebview.frame.size.width;
        CGFloat height = cell.TVWebview.frame.size.height;
        
        //NSString *URL = [NSString stringWithFormat:@"<iframe width=\"%f\" height=\"%f\" src=\"http://dcunilive28-lh.akamaihd.net/i/dclive_1@624576/master.m3u8\" frameborder=\"0\" allowfullscreen></iframe>", width-10 , height];
          NSString *URL = [NSString stringWithFormat:@"<iframe width=\"%f\" height=\"%f\" src=\"http://dcunilive28-lh.akamaihd.net/i/dclive_1@624576/master.m3u8\" frameborder=\"0\" rel=0& cc_load_policy=1 &autoplay=false <style>body {background-color: transparent;}</style></iframe>", width , height];
        
        
        
        [cell.TVWebview loadHTMLString:URL baseURL:nil];
        cell.TVWebview.backgroundColor=[UIColor blackColor];
        cell.backgroundColor=[UIColor blackColor];
        cell.TVWebview.opaque = NO;
        cell.TVWebview.scrollView.contentOffset = CGPointMake(-200, 200);

        
//        NSString *embedHTML = @"<script id=\"107751_c_466205\" width=\"320\" height=\"200\" src=\"//player.dacast.com/js/player.js\"  class=\"dacast-video\"></script> <video autoplay=\"true\" stretch=\"false\"> <source type=\"application/x-mpegurl\" src=\"http://dcunilive28-lh.akamaihd.net/i/dclive_1@624576/master.m3u8\"> </video> </div><iframe src=\"//iframe.dacast.com/b/107751/c/466205\" width=\"320\" height=\"200\" frameborder=\"0\" scrolling=\"no\" allow=\"autoplay\" allowfullscreen webkitallowfullscreen mozallowfullscreen oallowfullscreen msallowfullscreen></iframe>";
//        cell.backgroundColor=[UIColor clearColor];
//        [cell.TVWebview loadHTMLString:embedHTML baseURL:nil];
        return cell;
    }
    
    // Down cell
    else
    {
        
        static NSString *CellIdentifier = @"HomeCELL2";
        HomeCELL2 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell=nil;
        if (cell == nil)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        }
        
        //HomeCELL2 *cell = (HomeCELL2 *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
       
        
        NSString *imagePath=[[BannerData valueForKey:@"image"]objectAtIndex:indexPath.section-1];
        
        [cell.BannerImgVW sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"placeholder_img"]];
        [cell.BannerImgVW setShowActivityIndicatorView:YES];
        cell.BannerImgVW.layer.masksToBounds=YES;
        cell.BannerImgVW.layer.cornerRadius=5.0f;
        
        [cell.BannerButton addTarget:self action:@selector(Banner_Click:) forControlEvents:UIControlEventTouchUpInside];
        cell.BannerButton.tag=indexPath.section;
        return cell;
    }
}

-(void)Banner_Click:(id)sender
{
    UIButton *instanceButton = (UIButton*)sender;
    NSLog(@"Tag=%ld",(long)instanceButton.tag);
    
    NSString *urlSTR=[[BannerData valueForKey:@"url"] objectAtIndex:instanceButton.tag-1];
    
    NSURL *url = [NSURL URLWithString:urlSTR];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)MenuBtn_Action:(id)sender
{
     [self.rootNav drawerToggle];
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
