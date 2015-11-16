//
//  PlayingCard.h
//  Machismo
//
//  Created by qingyun on 15/11/11.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
{
    NSString *_suit;
}

@property(nonatomic, strong)NSString *suit;
@property(nonatomic)NSInteger rank;

+ (NSArray *)validSuits;
+ (NSInteger)maxRank;





@end
