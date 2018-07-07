//
//  HomeVC.h
//  Mosaica
//
//  Created by jignesh solanki on 03/07/2018.
//  Copyright © 2018 jignesh solanki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mosaica.pch"

@interface HomeVC : UIViewController<CCKFNavDrawerDelegate,UIWebViewDelegate>
{
    NSMutableDictionary *BannerData;
}
@property (weak, nonatomic) IBOutlet UITableView *tableVW;

@property (strong, nonatomic) CCKFNavDrawer *rootNav;
@end
