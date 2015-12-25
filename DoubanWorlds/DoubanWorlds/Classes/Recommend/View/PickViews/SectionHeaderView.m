//
//  SectionHeaderView.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/23.
//  Copyright © 2015年 LYoung. All rights reserved.
//


#import "SectionHeaderView.h"

@interface SectionHeaderView ()

@property (nonatomic, strong) UILabel *headerLabel;

@end

@implementation SectionHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 25);
        self.backgroundColor = KColor(235, 235, 241);
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    _headerLabel = [[UILabel alloc] init];
    _headerLabel.frame = CGRectMake(15, 0, 200, 25);
    _headerLabel.textColor = [UIColor grayColor];
    _headerLabel.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:_headerLabel];
}


-(void)setText:(NSString *)text{
    _text = text;
    _headerLabel.text = text;
}

+(CGFloat)getSectionHeadHeight{
    return 25;
}

@end
