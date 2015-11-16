//
//  ViewController.m
//  Machismo
//
//  Created by qingyun on 15/11/10.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "ViewController.h"
//#import "Deck.h"
#import "PlayingCardDeck.h"
//#import "Card.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (nonatomic,strong) Deck *deck;
@property (nonatomic,strong) CardMatchingGame * game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) IBOutlet UILabel *Score;

@end


@implementation ViewController

- (CardMatchingGame *)game
{
    if(!_game)
        _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                                        usingDeck:[self createDeck]];
        return _game;
}




- (Deck *)createDeck
{
    //return nil;
    return [[PlayingCardDeck alloc] init];
}

static const int Using_DealCard = 2;

- (IBAction)dealCard:(UIButton *)sender {
    for (UIButton *cardButton in self.cardButtons) {
        NSInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        
        if (card.isMAtched) {
            card = [[self createDeck] drawRandomCard];
            [self.game repalceCardAtIndex:cardIndex withCard:card];
            [cardButton setTitle:@"" forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[UIImage imageNamed: @"cardBack.png"] forState:UIControlStateNormal];
            cardButton.enabled = YES;
            card.chosen = NO;
            card.matched = NO;
            self.Score.text = [NSString stringWithFormat:@"Score:%d",((int)self.game.score - Using_DealCard)];
        }
    }
}

- (IBAction)touchCard:(UIButton *)sender {
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    NSLog(@"%@",self.game);
}

- (void)updateUI
{
    for (UIButton *cardbutton in self.cardButtons) {
        NSInteger cardIndex = [self.cardButtons indexOfObject:cardbutton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardbutton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardbutton setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal];
        cardbutton.enabled = !card.isMAtched;
    }
    self.Score.text = [NSString stringWithFormat:@"Score:%d",(int)self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)imageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen?@"cardFront":@"cardBack"];
}
@end
