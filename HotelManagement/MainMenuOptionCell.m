//
//  MainMenuOptionCell.m
//  HotelManagement
//
//  Created by Edrease Peshtaz on 10/6/15.
//  Copyright © 2015 cf. All rights reserved.
//

#import "MainMenuOptionCell.h"

@implementation MainMenuOptionCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  if (self) {
    
    self.titleLabel = [[UILabel alloc]init];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.titleLabel setNumberOfLines:1];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:self.titleLabel];
    
  }
  
  return self;
  
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
