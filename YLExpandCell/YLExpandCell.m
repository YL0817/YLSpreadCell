//
//  YLExpandCell.m
//  YLExpandCell
//
//  Created by YL on 16/9/30.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "YLExpandCell.h"
#import "YLExpandModel.h"
#import "Masonry.h"

@interface YLExpandCell()

@property (nonatomic, strong) MASConstraint *widthConstraint;

@property (nonatomic, strong) UILabel       *contentLabel;

@property (nonatomic, strong) UIButton      *expandButton;

@end

@implementation YLExpandCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.exclusiveTouch = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.expandButton];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(@10);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10);
            make.bottom.equalTo(self.expandButton.mas_top);
            _widthConstraint = make.height.equalTo(@20).with.priorityHigh();
        }];
        
        [self.expandButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@32);
            make.left.and.right.and.bottom.equalTo(self.contentView);
        }];
        
        
        
    }
    return self;
}

- (UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor darkGrayColor];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width-20;
    }
    return _contentLabel;
}

- (UIButton *)expandButton{
    if(!_expandButton){
        _expandButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_expandButton setTitle:@"展开" forState:UIControlStateNormal];
        [_expandButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [_expandButton addTarget:self
                          action:@selector(expandCellAction:)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _expandButton;
}

- (void)setModel:(YLExpandModel *)model{
    
    _model = model;
    self.contentLabel.text = model.content;
    
    if(_model.isExpand){
        [_widthConstraint uninstall];
    }
    else{
        [_widthConstraint install];
    }
}

- (void)expandCellAction:(UIButton *)button{
    
    _model.isExpand = !_model.isExpand;
    NSString *title  = _model.isExpand ? @"收缩":@"展开";
    [self.expandButton setTitle:title forState:UIControlStateNormal];
    
    _model.height = 0;
    
    if(_expandBlock){
        _expandBlock();
    }
}

@end
