//
//  LocationHeadView.m
//  Travel
//
//  Created by qianfeng on 15/6/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LocationHeadView.h"
#import "UIImageView+WebCache.h"

@implementation LocationHeadView

//@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
//@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
//@property (weak, nonatomic) IBOutlet UILabel *userName;
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

- (void)awakeFromNib {
    // Initialization code
}

-(void)updateHeadViewWithModel:(RecommendModel *)model
{
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"zbg_p9_cover_def_mid_round_corner.9.png"]];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"zbg_p9_cover_def_mid_round_corner.9.png"]];
    self.userName.text=model.username;
    self.titleLabel.text=model.title;
    self.countLabel.text=model.count;
    self.descriptionTextView.text=model.debugDescription;
}

-(CGFloat)getHeadHeightWithModel:(RecommendModel *)model width:(CGFloat)width
{
    CGFloat height=[self heightForString:model.description fontSize:16 andWidth:width];
    return 357+height;
}

#pragma mark


- (float) heightForString:(NSString *)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width
{
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    detailTextView.font = [UIFont boldSystemFontOfSize:fontSize];
    detailTextView.text = value;
    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)];
    self.descriptionTextView.frame=CGRectMake(self.descriptionTextView.frame.origin.x, self.descriptionTextView.frame.origin.y,width, deSize.height);
    return deSize.height;
}

@end
