//
//  CustomTableView.h
//  CustomTableView
//
//  Created by JH on 2019/2/19.
//  Copyright © 2019 JH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CustomTableView;
@protocol CustomTableViewDelegate <NSObject>

- (NSInteger)tableView:(CustomTableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (CGFloat)tableView:(CustomTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UITableViewCell *)tableView:(CustomTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface CustomTableView : UIScrollView

//刷新tableview
-(void)reloadData;

@property (nonatomic, weak)id<CustomTableViewDelegate>delegate;

//获取重用cell
- (__kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
