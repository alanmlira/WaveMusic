//
//  ALQuestionarioViewController.h
//  WaveMusic
//
//  Created by Lab. Lacib 01 on 14/11/13.
//  Copyright (c) 2013 Alan Magalhães Lira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALViewController.h"
#import "DoAlertView.h"

@class UICollectionViewController;
@interface ALQuestionarioViewController : UIViewController <UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    ALViewController *principal;
    NSMutableArray *listaAlbuns;
    NSDictionary *albuns;
    IBOutlet UICollectionView *collectionV;
    __weak IBOutlet UILabel *lbProcesso;
}


@property (nonatomic) UICollectionView *collectionV;
@property (nonatomic) NSMutableArray *listaAlbuns;
@property (nonatomic) NSDictionary *albuns;
@property (nonatomic) int aux;
@property (nonatomic) int countProc;
@property (nonatomic) int jazz;
@property (nonatomic) int latin;
@property (nonatomic) int hardcore;
@property (nonatomic) int pop;
@property (nonatomic) int country;
@property (nonatomic) int blues;
@property (nonatomic) int folk;
@property (nonatomic) int hiphop;
@property (nonatomic) int reb;
@property (nonatomic) int rock;
@property (nonatomic) int eletronic;
@property (strong, nonatomic) DoAlertView *vAlert;

- (void)setPrincipal:(ALViewController *)principalView;

@end
