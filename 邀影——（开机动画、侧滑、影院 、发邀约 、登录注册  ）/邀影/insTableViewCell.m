//
//  insTableViewCell.m
//  邀影
//
//  Created by ZY on 15/9/23.
//  Copyright (c) 2015年 罗凌云. All rights reserved.
//

#import "insTableViewCell.h"

@implementation insTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)AppAction:(UIButton *)sender forEvent:(UIEvent *)event {
    if (_delegate && [_delegate respondsToSelector:@selector(applyPressed:)]) {
        [_delegate applyPressed:_indexPath];
    }
}
@end
