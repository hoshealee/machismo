//
//  PlayingCard.m
//  Machismo
//
//  Created by qingyun on 15/11/11.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "PlayingCard.h"


@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if ([otherCards count] == 1) {
        id card = [otherCards firstObject];
        if([card isKindOfClass:[PlayingCard class]]){
            PlayingCard *otherCard = (PlayingCard *)card;
            if ([self.suit isEqualToString:otherCard.suit]) {
                score = 1;
            }else if(self.rank == otherCard.rank){
                score = self.rank < 10 ? 4:(int)self.rank ;
            }
        }
    }
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    return @[@"♥︎",@"♠︎",@"♣︎",@"♦︎"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit:@"?";
}
+ (NSArray *)rankStrings{
   return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSInteger)maxRank{
    return [[self rankStrings] count]-1;
}

- (void)setRank:(NSInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


@end
