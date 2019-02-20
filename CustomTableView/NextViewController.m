//
//  NextViewController.m
//  CustomTableView
//
//  Created by JH on 2019/2/19.
//  Copyright © 2019 JH. All rights reserved.
//

#import "NextViewController.h"
#import "CustomTableView.h"

@interface NextViewController ()<CustomTableViewDelegate>
{
        NSMutableArray *_cellArr;
}
@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"自定义tableView";
    CustomTableView *tableView = [[CustomTableView alloc]  initWithFrame:self.view.bounds];
    tableView.delegate = self;
    [tableView reloadData];
    [self.view addSubview:tableView];
    _cellArr = [NSMutableArray array];
}




#pragma mark - tableView delegate
-(NSInteger)tableView:(CustomTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (UITableViewCell *)tableView:(CustomTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [@(indexPath.row) description];
    
    if (indexPath.row%2) {
        cell.backgroundColor = [UIColor yellowColor];
    }else{
        cell.backgroundColor = [UIColor greenColor];
    }

    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
