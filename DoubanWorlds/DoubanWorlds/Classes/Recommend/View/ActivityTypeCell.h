//
//  ActivityTypeCell.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/31.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTypeCell : UITableViewCell

+(CGFloat)getCellHeight;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic ,copy) NSString *title;

@end
