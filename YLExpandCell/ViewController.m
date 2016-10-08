//
//  ViewController.m
//  YLExpandCell
//
//  Created by YL on 16/9/30.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "ViewController.h"
#import "YLExpandCell.h"
#import "YLExpandModel.h"

#define MAX_NUM    3

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray         *dataSource;

@property (nonatomic, strong) UITableView            *tableView;

@end

@implementation ViewController

- (void)dealloc{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Expand cell";
    
    [self setupDataSource];
    
    [self.tableView registerClass:[YLExpandCell class] forCellReuseIdentifier:NSStringFromClass([YLExpandCell class])];
    
    [self.view addSubview:self.tableView];

}

- (void)setupDataSource{
    
    _dataSource = [[NSMutableArray alloc] initWithCapacity:1];
    for (int i =0; i < MAX_NUM; i++) {
        YLExpandModel *model = [[YLExpandModel alloc] init];
        model.isExpand = NO;
        model.height = 0;
        model.content = [NSString stringWithFormat:@"测试数据内容%d测试数据内容abcderf测试数据内容测试数据内容测试数据内容876544343测试数据内容测试数据内容09998测试数据内容测试数据内容测试数据内容测试数据内容测试数据内容测试数据内容测试数据内容测试数据内容%d",i ,i];
        [_dataSource addObject:model];
    }
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 100;
    }
    return _tableView;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YLExpandCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YLExpandCell class]) forIndexPath:indexPath];
    [cell setModel:_dataSource[indexPath.row]];
     __weak __typeof(self)weakSelf = self;
    [cell setExpandBlock:^{
        [weakSelf.tableView beginUpdates];
        [weakSelf.tableView endUpdates];
        [weakSelf.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }];
    return cell;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YLExpandModel *model = _dataSource[indexPath.row];
    
    YLExpandCell *cell  = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YLExpandCell class])];
    if(model.height ==  0){
        [cell setModel:model];
        model.height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height+.5;
    }
    return  model.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
