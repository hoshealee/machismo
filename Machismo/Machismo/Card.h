//
//  Card.h
//  Machismo
//
//  Created by qingyun on 15/11/11.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic,strong)NSString *contents;

@property (nonatomic,getter=isChosen)BOOL chosen;
@property (nonatomic,getter=isMAtched)BOOL matched;

#pragma mark注释

- (int)match:(NSArray *)otherCards;

@end
