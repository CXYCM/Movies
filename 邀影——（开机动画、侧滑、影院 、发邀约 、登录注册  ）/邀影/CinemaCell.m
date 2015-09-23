//
//  CinemaCell.m
//  邀影
//
//  Created by 陈铭铭铭铭 on 15/9/22.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//
#import "CinemaCell.h"
#import "CinemaModel.h"

#import "UIViewExt.h"
#define rgb(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define kFontColor rgb(253, 216, 0, 1)
@implementation CinemaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
        //辅助图标
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)awakeFromNib
{
    [self _initViews];
    //辅助图标
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
}
- (void)_initViews
{
    _ratingLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
    _ratingLabel1.font = [UIFont systemFontOfSize:14];
    _ratingLabel1.textColor = kFontColor;
    _ratingLabel1.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_ratingLabel1];
    
    _ratingLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
    _ratingLabel2.font = [UIFont systemFontOfSize:12];
    _ratingLabel2.textColor = kFontColor;
    _ratingLabel2.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_ratingLabel2];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _priceLabel.font = [UIFont systemFontOfSize:18];
    _priceLabel.textColor = kFontColor;
    _priceLabel.backgroundColor = [UIColor clearColor];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceLabel];
    
    //选座图标
    _seatIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cinemaSeatMark@2x.png"]];
    [self.contentView addSubview:_seatIcon];
    
    //优惠券图标
    _couponIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cinemaCouponMark@2x.png"]];
    [self.contentView addSubview:_couponIcon];
    
    //影院标题
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.font = [UIFont systemFontOfSize:16];
    
    //子标题
    self.detailTextLabel.textColor = [UIColor grayColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:13];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.textLabel.superview == nil) {
        [self.contentView addSubview:self.textLabel];
    }
    if (self.detailTextLabel.superview == nil) {
        [self.contentView addSubview:self.detailTextLabel];
    }
    //影院名称
    self.textLabel.frame = CGRectMake(10, 5, 0, 0);
    self.textLabel.text = self.cinemaModel.name;
    [self.textLabel sizeToFit];
    if (self.textLabel.width > 200) {
        self.textLabel.width = 200;
    }
    //附近商区名称
    self.detailTextLabel.frame = CGRectMake(self.textLabel.left, self.textLabel.bottom+5, 0, 0);
    self.detailTextLabel.text = self.cinemaModel.circleName;
    [self.detailTextLabel sizeToFit];
    //价格
    NSString *price = self.cinemaModel.lowPrice;
    if (price.length == 0) {
        _priceLabel.text = nil;
    } else
    {
        int priceValue = [price intValue];
        _priceLabel.text = [NSString stringWithFormat:@"￥%d",priceValue];
        [_priceLabel sizeToFit];
        _priceLabel.right = self.width - 30;
        _priceLabel.top = 20;
    }
    //评分
    //9.1
    NSString *grade = self.cinemaModel.grade;
    if (grade.length > 0 && [grade floatValue] > 0) {
        NSArray *comp = [grade componentsSeparatedByString:@"."];
        if (comp.count == 2) {
            NSString *r1 = [comp objectAtIndex:0];
            NSString *r2 = [comp objectAtIndex:1];
            
            _ratingLabel1.text = [NSString stringWithFormat:@"%@.",r1];
            _ratingLabel2.text = [NSString stringWithFormat:@"%@分",r2];
        }
        
        _ratingLabel1.frame = CGRectMake(self.textLabel.right+5, self.textLabel.top, 0, 0);
        [_ratingLabel1 sizeToFit];
        
        _ratingLabel2.frame = CGRectMake(_ratingLabel1.right, self.textLabel.top, 0, 0);
        [_ratingLabel2 sizeToFit];
    } else
    {
        _ratingLabel1.text = nil;
        _ratingLabel2.text = nil;
    }
    //图标
    //选座
    BOOL isSeat = [self.cinemaModel.isSeatSupport boolValue];
    //优惠券
    BOOL isCoupon = [self.cinemaModel.isCouponSupport boolValue];
    if (isSeat) {
        _seatIcon.hidden = NO;
        _seatIcon.frame = CGRectMake(10, self.detailTextLabel.bottom+5, 15, 15);
    } else
    {
        _seatIcon.hidden = YES;
        _seatIcon.frame = CGRectZero;
    }
    
    if (isCoupon) {
        _couponIcon.hidden = NO;
        _couponIcon.frame = CGRectMake(_seatIcon.right+5, self.detailTextLabel.bottom+5, 15, 15);
    } else
    {
        _couponIcon.hidden = YES;
        _couponIcon.frame = CGRectZero;
    }
}
@end
