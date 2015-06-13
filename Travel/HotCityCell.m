//
//  HotCityCell.m
//  Travel
//
//  Created by qianfeng on 15/6/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HotCityCell.h"
#import "UIImageView+WebCache.h"

@implementation HotCityCell

- (void)awakeFromNib {
    // Initialization code
}
//iew *imageView;
//*cnnameLabel;
//*ennameLabel;
-(void)updateCellUIWithModel:(DesHotCityModel *)model
{
    self.cnnameLabel.text=model.name;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"zbg_p9_cover_def_mid_round_corner.9.png"]];
}

@end
