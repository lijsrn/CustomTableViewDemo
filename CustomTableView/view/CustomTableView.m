//
//  CustomTableView.m
//  CustomTableView
//
//  Created by JH on 2019/2/19.
//  Copyright © 2019 JH. All rights reserved.
//

#import "CustomTableView.h"
#import "CellFrameModel.h"

@implementation CustomTableView
{
    NSMutableArray *_cellFrameModelArray;
    NSMutableArray *_reusableArray;  //重用池
    NSMutableDictionary *_visibleDic ;//可见池
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _cellFrameModelArray = [NSMutableArray array];
        _reusableArray = [NSMutableArray array];
        _visibleDic = [NSMutableDictionary dictionary];

    }
    return self;
}

-(void)reloadData{
    //1.数据处理(1.1计算每个cell的frame，并存储，1.2 tableView的ContentSize)
    [self calculateFrame];
    //2.ui处理
    [self setNeedsLayout];
}

//默认只有1个section
-(void)calculateFrame{
    
    //1.1获取cell的数量
    NSInteger cellCount = [self.delegate tableView:self numberOfRowsInSection:0];
    CGFloat startY = 0;
    //1.2计算每个cell的frame值，并保存在一个数组中
    for (int i = 0; i < cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CGFloat cellHeight = [self.delegate tableView:self heightForRowAtIndexPath:indexPath];
        
        //用一个cell保存每个cell的y和高度
        CellFrameModel *model = [CellFrameModel new];
        model.y = startY;
        model.height = cellHeight;
     
        startY += cellHeight;//下一个cell的y坐标
        
        [_cellFrameModelArray addObject:model];
    }
    
    //1.3 设置contentSize大小
    [self setContentSize:CGSizeMake(self.frame.size.width, startY)];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat startY = self.contentOffset.y;
    CGFloat endY = self.contentOffset.y + self.frame.size.height;
    
    if (startY <0) {
        startY = 0;
    }
    
    if (endY > self.contentSize.height) {
        endY = self.contentSize.height;
    }
    //普通寻找方法
    //Model.y <startY < Model.y + Model.height
    //Model.y <endY < Model.y + Model.height
    //找到屏幕显示区域的cell 索引  二分法找的快  Model.y <startY < Model.y + Model.height
    NSInteger startIndex = [self binarySerchOC:_cellFrameModelArray target:startY];
    NSInteger endIndex = [self binarySerchOC:_cellFrameModelArray target:endY];
    
    //显示cell
    for (NSInteger i = startIndex; i <= endIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell * cell = [self.delegate tableView:self cellForRowAtIndexPath:indexPath];
        CellFrameModel *model = _cellFrameModelArray[i];
        cell.frame = CGRectMake(0, model.y, self.frame.size.width, model.height);
        if (![cell superview]) {
            [self addSubview:cell];
        }
    }
    
    // 4 数据清理
    // 4.1 从现有池里面移走不在界面上的cell， 并移到重用池里（把不在可视区域的cell移动到重用池）
    NSArray *visibleCellKey = _visibleDic.allKeys;
    for (int i = 0; i < visibleCellKey.count; i++) {
        
        NSInteger index = [visibleCellKey[i] integerValue];
        if (index < startIndex || index > endIndex) { // 不在索引范围之间（startIndex -endIndex），就不在可视区域
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            UITableViewCell * cell = [self.delegate tableView:self cellForRowAtIndexPath:indexPath];

            [cell removeFromSuperview];
            
            [_reusableArray addObject:_visibleDic[visibleCellKey[i]]];
            [_visibleDic removeObjectForKey:visibleCellKey[i]];
        }
    }
    
}

-(UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = _visibleDic[@(indexPath.row)];
    if (!cell) {
        if (_reusableArray.count >0) {
            cell = _reusableArray.firstObject;
        }else{
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        //
        [_reusableArray removeObject:cell];// 移出重用池
        [_visibleDic setObject:cell forKey:@(indexPath.row)];// 存入现有池
        
    }
    
    return cell;
}

- (NSInteger)binarySerchOC:(NSArray*)dataAry target:(CGFloat)targetY{
    
    NSInteger min = 0;
    NSInteger max = dataAry.count - 1;
    NSInteger mid;
    while (min < max) {
        mid = min + (max - min)/2;
        // 条件判断
        CellFrameModel *midModel = dataAry[mid];
        if (midModel.y < targetY && midModel.y + midModel.height > targetY) {
            return mid;
        }else if(targetY < midModel.y){
            max = mid;// 在左边
            if (max - min == 1) {
                return min;
            }
        }else {
            min = mid;// 在右边
            if (max - min == 1) {
                return max;
            }
        }
    }
    return -1;
}

@end
