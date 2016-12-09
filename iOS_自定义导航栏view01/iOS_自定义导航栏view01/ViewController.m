//
//  ViewController.m
//  iOS_自定义导航栏view01
//
//  Created by 高宇 on 16/12/9.
//  Copyright © 2016年 高宇. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"
#import "NavView.h"


#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (weak, nonatomic) NavView *navView;

@end

@implementation ViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, 30)];
    tipLabel.text = @"版权归我所有";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor grayColor];
    [self.view addSubview:tipLabel];
    
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    self.tableView.tableHeaderView = headerView;
    
    NavView *navView = [[NavView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64) title:@"首页"];
    self.navView = navView;
    [self.view addSubview:navView];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *rid = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rid];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld个cell",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *VC = [[UIViewController alloc] init];
    VC.title = @"二级页面";
    VC.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 100 && offsetY > 0) {
        
        self.navView.backgroundColor = [UIColor colorWithRed:73/255.0 green:210/255.0 blue:254/255.0 alpha:offsetY / 100.0];
    }else if(offsetY > 100){
        self.navView.backgroundColor = [UIColor colorWithRed:73/255.0 green:210/255.0 blue:254/255.0 alpha:1.0];
    }else{
        self.navView.backgroundColor = [UIColor clearColor];
    }
    NSLog(@"%f",scrollView.contentOffset.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
