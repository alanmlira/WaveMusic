//
//  ALQuestionarioViewCell.h
//  WaveMusic
//
//  Created by Alan Magalhães Lira on 16/11/13.
//  Copyright (c) 2013 Alan Magalhães Lira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALQuestionarioViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgAlbum;
@property (weak, nonatomic) IBOutlet UILabel *lbAlbum;
@property (weak, nonatomic) IBOutlet UILabel *lbMusica;
@property (weak, nonatomic) IBOutlet UILabel *lbArtista;

@end
