//
//  ViewController.m
//  CustomTableView
//
//  Created by JH on 2019/2/19.
//  Copyright © 2019 JH. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.label.text = @"简单的自定义tableView,点击屏幕任意处开始";

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController pushViewController:[NextViewController new] animated:YES];
}

@end
