//
//  ContactUsVW.h
//  Mosaica
//
//  Created by jignesh solanki on 03/07/2018.
//  Copyright © 2018 jignesh solanki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mosaica.pch"

@interface ContactUsVW : UIViewController<CCKFNavDrawerDelegate>
{
    NSMutableDictionary *socialLinkData;
}
@property (strong, nonatomic) CCKFNavDrawer *rootNav;
@property (weak, nonatomic) IBOutlet UIView *NameView;
@property (weak, nonatomic) IBOutlet UIView *EmailView;
@property (weak, nonatomic) IBOutlet UIView *MessageView;
@property (weak, nonatomic) IBOutlet UIButton *SubmitBtn;
@property (weak, nonatomic) IBOutlet UITextField *NameTXT;
@property (weak, nonatomic) IBOutlet UITextField *EmailTXT;
@property (weak, nonatomic) IBOutlet UITextView *MessageTXTVW;
@property (strong, nonatomic) IBOutlet UIView *Youtube_BTN;

@end
