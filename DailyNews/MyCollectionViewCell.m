//
//  MyCollectionViewCell.m
//  DailyNews
//
//  Created by qianfeng on 15/6/6.
//  Copyright (c) 2015年 chelongfei. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "AnalyseNetData.h"
#import "MyImageView.h"

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.modelArray=[NSMutableArray array];
    [self addBottomImageViewWithFrame];
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    self.firstBottomImage.image=nil;
    self.secondBottomImage.image=nil;
    self.thirdBottomImage.image=nil;
}

-(void)addBottomImageViewWithFrame
{
    CGFloat padding=10;
    CGFloat width=60;
    CGFloat height=50;
    for (int index=0; index<2; index++) {
      CGRect frames=CGRectMake(20+(padding+width)*index, 500, width, height);
        MyImageView * imageView=[[MyImageView alloc]initWithFrame:frames];
        imageView.tag=300+index;
        __weak typeof(self) weakself=self;
        switch (index) {
            case 0:{
                _firstBottomImage=imageView;
                [_firstBottomImage setImageClickBlock:^(DataModel * model){
                    [weakself updateUIFromBottomModel:model];
                }];
                 [self addSubview:_firstBottomImage];
                break;}
            case 1:{
                _secondBottomImage=imageView;
                [_secondBottomImage setImageClickBlock:^(DataModel * model){
                    [weakself updateUIFromBottomModel:model];
                }];
                [self addSubview:_secondBottomImage];
                break;}
            case 2:{
                _thirdBottomImage=imageView;
                [_thirdBottomImage setImageClickBlock:^(DataModel * model){
                    [weakself updateUIFromBottomModel:model];
                }];
                [self addSubview:_thirdBottomImage];
                break;}
            default:
                break;
        }
    }
}

-(void)updateUIWithModel:(DataModel *)model
{
    [_landscapeImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_landscape]];
    _titleLabel.text=model.title;
    _contentTextView.text=model.content;
    [self textViewSetFrameWithString:model.content];
    [self setBottomImageFrameWithHeightOfTextView];
    if (model.album_count>0) {
        self.modelArray=[AnalyseNetData parsePageData:model.album];
        [self.modelArray addObject:model];
        [self.modelArray exchangeObjectAtIndex:0 withObjectAtIndex:self.modelArray.count-1];
        [self updateBottomImageViewWithArray:self.modelArray];
    }else{
         _firstBottomImage.userInteractionEnabled=NO;
         _secondBottomImage.userInteractionEnabled=NO;
        _thirdBottomImage.userInteractionEnabled=NO;
    }
}

-(void)updateUIFromBottomModel:(DataModel *)model
{
    [_landscapeImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_landscape]];
    _titleLabel.text=model.title;
    _contentTextView.text=model.content;
    [self textViewSetFrameWithString:model.content];
    [self setBottomImageFrameWithHeightOfTextView];
}
-(void)updateBottomImageViewWithArray:(NSArray *)array
{
    
    for (int index=0; index<[self.modelArray count]; index++) {
        DataModel * model=[self.modelArray objectAtIndex:index];
        switch (index) {
            case 0:
               [_firstBottomImage sd_setImageWithURL:[NSURL URLWithString:model.cover_thumb]];
                _firstBottomImage.userInteractionEnabled=YES;
                _firstBottomImage.model=model;
                break;
            case 1:
                [_secondBottomImage sd_setImageWithURL:[NSURL URLWithString:model.cover_thumb]];
                _secondBottomImage.userInteractionEnabled=YES;
                _secondBottomImage.model=model;
                break;
            case 2:
                [_thirdBottomImage sd_setImageWithURL:[NSURL URLWithString:model.cover_thumb]];
                _thirdBottomImage.model=model;
                _thirdBottomImage.userInteractionEnabled=YES;
                break;
            default:
                break;
        }
    }
}

-(void)textViewSetFrameWithString:(NSString *) string
{
    CGRect frame=_contentTextView.frame;
    frame.size.height=[self heightForString:string fontSize:14 andWidth:self.frame.size.width-35];
    [UIView animateWithDuration:0.5 animations:^{
      _contentTextView.frame=frame;
    }];
    
}

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    detailTextView.font = [UIFont systemFontOfSize:fontSize];
    detailTextView.text = value;
    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)];
    return deSize.height;
}

-(void)setBottomImageFrameWithHeightOfTextView
{
    CGRect frame=_firstBottomImage.frame;
    frame.origin.y=CGRectGetMaxY(_contentTextView.frame)+2;
    _firstBottomImage.frame=frame;
    frame.origin.x=CGRectGetMaxX(frame)+10;
    _secondBottomImage.frame=frame;
    frame.origin.x=CGRectGetMaxX(frame)+10;
    _thirdBottomImage.frame=frame;
}


@end
