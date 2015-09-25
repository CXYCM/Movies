//
//  insTableViewCell.h
//  邀影
//
//  Created by ZY on 15/9/23.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol insTableViewCellDelegate;
@interface insTableViewCell : UITableViewCell
@property (weak, nonatomic) id<insTableViewCellDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *way;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *movie;
@property (weak, nonatomic) IBOutlet UILabel *say;
@property (weak, nonatomic) IBOutlet UIButton *App;
- (IBAction)AppAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end
@protocol insTableViewCellDelegate <NSObject>

@required
- (void)cellLongPressAtIndexPath:(NSIndexPath *)indexPath;
- (void)photoTapAtIndexPath:(NSIndexPath *)indexPath;
- (void)applyPressed:(NSIndexPath *)indexPath;

@end