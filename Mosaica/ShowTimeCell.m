//
//  ShowTimeCell.m
//  Mosaica
//
//  Created by jignesh solanki on 03/07/2018.
//  Copyright © 2018 jignesh solanki. All rights reserved.
//

#import "ShowTimeCell.h"

@implementation ShowTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.BackGrgnVIEW.layer.cornerRadius = 5.0;
    self.BackGrgnVIEW.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
