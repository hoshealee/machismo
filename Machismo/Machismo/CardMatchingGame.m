//
//  CardMatchingGame.m
//  Machismo
//
//  Created by qingyun on 15/11/11.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "CardMatchingGame.h"

#import "Deck.h"

@interface CardMatchingGame()

@property(nonatomic,readwrite)NSInteger score;
@property (nonatomic, strong)NSMutableArray *cards;// of Card

@end


@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    if(self = [super init]){
        for (int i=0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
    }
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if(!card.isMAtched){
        if (card.chosen) {
            card.chosen = NO;
        }else{
            //match against another card
            for (Card *otherCard in self.cards)
                {
                    if (otherCard.isChosen && !otherCard.isMAtched) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore*MATCH_BONUS;
                            card.matched = YES;
                            otherCard.matched = YES;
                        }else{
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                        }
                        break;
                    }
                }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return index < self.cards.count?self.cards[index]:nil;
}

- (void)repalceCardAtIndex:(NSInteger)index withCard:(Card *)card
{
    [self.cards replaceObjectAtIndex:index withObject:card];
}


@end
