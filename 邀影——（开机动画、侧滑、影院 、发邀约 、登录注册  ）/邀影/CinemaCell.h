//
//  CinemaCell.h
//  邀影
//
//  Created by 陈铭铭铭铭 on 15/9/22.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CinemaModel;
@interface CinemaCell : UITableViewCell
{
    UILabel *_ratingLabel1;
    UILabel *_ratingLabel2;
    UILabel *_priceLabel;
    UIImageView *_seatIcon;
    UIImageView *_couponIcon;
}
@property(nonatomic,retain) CinemaModel *cinemaModel;
@end
