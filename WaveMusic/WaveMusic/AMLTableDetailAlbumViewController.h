//
//  AMLTableDetailAlbumViewController.h
//  BrainMusic
//
//  Created by Alan Magalhães Lira on 22/08/13.
//  Copyright (c) 2013 Alan M. Lira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class ALPlayerViewController;

@interface AMLTableDetailAlbumViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tableMusicas; //Tabela
    NSString *titulo;
    NSString *idAlb;
    
}
@property (weak, nonatomic) IBOutlet UILabel *lbNomeAlbum;
@property (weak, nonatomic) IBOutlet UILabel *lbNomeArtista;
@property (weak, nonatomic) IBOutlet UILabel *lbNomeGravadora;
@property (weak, nonatomic) IBOutlet UILabel *lbDataAlbum;
@property (weak, nonatomic) IBOutlet UILabel *lbGeneroMusical;
@property (weak, nonatomic) IBOutlet UIImageView *imgAlbum;
@property (strong, nonatomic) ALPlayerViewController *playerMusic;
@property (strong, nonatomic) IBOutlet UITableView *tableMusicas;
@property (strong, nonatomic) NSString *titulo;
@property (strong, nonatomic) NSString *idAlb;
@property (nonatomic, retain) NSDictionary *musicas;

- (id)initWithPlayerMusic:(ALPlayerViewController *)player andTitle:(NSString *)title andAlbumId:(NSString*)idAlbum;

@end