//
//  YLExpandCell.h
//  YLExpandCell
//
//  Created by YL on 16/9/30.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YLExpandCellBlock)();

@class YLExpandModel;

@interface YLExpandCell : UITableViewCell

@property (nonatomic, strong) YLExpandModel *model;

@property (nonatomic, copy) YLExpandCellBlock  expandBlock;

@end
