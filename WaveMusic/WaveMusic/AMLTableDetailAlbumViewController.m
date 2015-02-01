//
//  AMLTableDetailAlbumViewController.m
//  BrainMusic
//
//  Created by Alan Magalhães Lira on 22/08/13.
//  Copyright (c) 2013 Alan M. Lira. All rights reserved.
//

#import "AMLTableDetailAlbumViewController.h"
#import "ALPlayerViewController.h"
#import "AMLConnectionServlet.h"
#import "ALControllerCS.h"

@interface AMLTableDetailAlbumViewController ()

@end

@implementation AMLTableDetailAlbumViewController

@synthesize tableMusicas, titulo, playerMusic, idAlb, musicas;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPlayerMusic:(ALPlayerViewController *)player andTitle:(NSString *)title andAlbumId:(NSString *)idAlbum {
    self.idAlb = idAlbum;
    self.titulo = title;
    self.playerMusic = player;
    return self;
}

- (void)viewDidLoad
{
    
    self.tableMusicas.clipsToBounds = YES;
    tableMusicas.dataSource = self;
    tableMusicas.delegate = self;
    
    self.imgAlbum.backgroundColor = [UIColor clearColor];
    self.imgAlbum.layer.masksToBounds = YES;
    self.imgAlbum.layer.cornerRadius = 50.0;
    self.imgAlbum.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.imgAlbum.layer.shouldRasterize = YES;
    self.imgAlbum.clipsToBounds = YES;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //[self.playerMusic getDataAlbum:&(idAlb)];objectForKey:@"imgAlbum"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"]stringByReplacingOccurrencesOfString:@"?" withString:@"%3f"]];
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long)NULL), ^(void) {
    self.musicas = [self.playerMusic.lMusicasAlbum objectAtIndex:0];
    NSString *texto = [self.musicas objectForKey:@"dataAlbum"];
    NSString *ano = [NSString stringWithFormat:@""], *mes = [NSString stringWithFormat:@""], *dia = [NSString stringWithFormat:@""], *date = [NSString stringWithFormat:@""];
    int controlador = 0;
    for (int i=0; i<[texto length]; i++) {
        if ([texto characterAtIndex:i]=='-') {
            NSLog(@"con i");
            controlador ++;
        } else if (controlador==0) {
            NSLog(@"1 i %c",[texto characterAtIndex:i]);
            ano = [NSString stringWithFormat:@"%@%c",ano,[texto characterAtIndex:i]];
        } else if (controlador==1){
            NSLog(@"2 i %c",[texto characterAtIndex:i]);
            mes = [NSString stringWithFormat:@"%@%c",mes,[texto characterAtIndex:i]];
        } else {
            NSLog(@"3 i %c",[texto characterAtIndex:i]);
            dia = [NSString stringWithFormat:@"%@%c",dia,[texto characterAtIndex:i]];
        }
    }
    date = [NSString stringWithFormat:@"%@/%@/%@",dia,mes,ano];
        //self.lbDataAlbum.text = [self.musicas objectForKey:@"dataAlbum"];
        self.lbNomeAlbum.text = [self.musicas objectForKey:@"nomeAlbum"];
        self.lbNomeArtista.text = [self.musicas objectForKey:@"nomeArtista"];
        self.lbNomeGravadora.text = [NSString stringWithFormat:@"%@ - %@",[self.musicas objectForKey:@"nomeGravadora"], date];
        self.lbGeneroMusical.text = [self.musicas objectForKey:@"generoMusical"];
        NSURL *url = [NSURL URLWithString:[[[self.musicas objectForKey:@"imgAlbum"]  stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
            NSLog(@"URL :%@",url);
            NSData *data = [NSData dataWithContentsOfURL:url];
            //ONLINE
        //cell.imageView.image = [[UIImage alloc] initWithContentsOfFile:[self.playerMusic.musicas objectForKey:@"imgAlbum"]];
            self.imgAlbum.image = [[UIImage alloc] initWithData:data];
        self.imgAlbum.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        self.imgAlbum.layer.masksToBounds = YES;
        self.imgAlbum.layer.cornerRadius = 50.0;
        self.imgAlbum.layer.borderColor = [UIColor blackColor].CGColor;
        self.imgAlbum.layer.borderWidth = 0.3f;
        self.imgAlbum.layer.rasterizationScale = [UIScreen mainScreen].scale;
        self.imgAlbum.layer.shouldRasterize = YES;
        self.imgAlbum.clipsToBounds = YES;
        //});
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

//Cell Original
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //if ([titulo isEqualToString:@"Tocando"]) {
      //  return [self.playerMusic.lMusicasRecomendadas count];
    //}else{
        return [self.playerMusic.lMusicasAlbum count];
    //}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

        self.musicas = [self.playerMusic.lMusicasAlbum objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",[self.musicas objectForKey:@"faixaMusica"],[self.musicas objectForKey:@"nomeMusica"]];
    cell.detailTextLabel.text = [self.musicas objectForKey:@"nomeArtista"];
    
    return cell;
}

/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        //if ([titulo isEqualToString:@"Tocando"]) {
            [self.playerMusic.lMusicasAlbum removeObjectAtIndex:indexPath.row];
            //
        //}else{
          //  [self.playerMusic.lMusicas removeObjectAtIndex:indexPath.row];
          //  NSMutableArray *lMusicaTemp = self.playerMusic.lMusicas;
          //  [lMusicaTemp removeObjectAtIndex:indexPath.row];
          //  self.playerMusic.lMusicas = lMusicaTemp;
        //}
        //[tableView reloadData];
        [tableMusicas deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}*/

@end