//
//  CellFrameModel.h
//  CustomTableView
//
//  Created by JH on 2019/2/19.
//  Copyright © 2019 JH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

//用于记录cell的frame
@interface CellFrameModel : NSObject

@property (nonatomic, assign)CGFloat y;

@property (nonatomic, assign)CGFloat height;
@end

NS_ASSUME_NONNULL_END
