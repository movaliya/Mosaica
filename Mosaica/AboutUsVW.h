//
//  AboutUsVW.h
//  Mosaica
//
//  Created by jignesh solanki on 03/07/2018.
//  Copyright © 2018 jignesh solanki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mosaica.pch"
@interface AboutUsVW : UIViewController<CCKFNavDrawerDelegate>
@property (strong, nonatomic) CCKFNavDrawer *rootNav;

@property (weak, nonatomic) IBOutlet UITextView *TextVW;

@end
