//
//  ShowTimeVC.h
//  Mosaica
//
//  Created by jignesh solanki on 03/07/2018.
//  Copyright © 2018 jignesh solanki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mosaica.pch"
#import <FacebookSDK/FacebookSDK.h>

@interface ShowTimeVC : UIViewController<FBLoginViewDelegate,CCKFNavDrawerDelegate>
{
    NSMutableDictionary *ShowTimeData;
    UIRefreshControl *refreshControl;
    NSMutableDictionary *FBSignIndictParams;
    NSString *ShowID,*RemidnerID;

}
@property (strong, nonatomic) CCKFNavDrawer *rootNav;
@property (weak, nonatomic) IBOutlet UITableView *TableVW;

@end
