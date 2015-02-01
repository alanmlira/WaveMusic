//
//  AMLTableNowViewController.m
//  BrainMusic
//
//  Created by Alan Magalhães Lira on 18/08/13.
//  Copyright (c) 2013 Alan M. Lira. All rights reserved.
//

#import "AMLTableNowViewController.h"
#import "ALPlayerViewController.h"

@interface AMLTableNowViewController ()

@end

@implementation AMLTableNowViewController

@synthesize tableMusicas, titulo, playerMusic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPlayerMusic:(ALPlayerViewController *)player andTitle:(NSString *)title
{
    self.titulo = title;
    self.playerMusic = player;
    return self;
}

- (void)viewDidLoad
{
    
    self.tableMusicas.clipsToBounds = YES;
    tableMusicas.dataSource = self;
    tableMusicas.delegate = self;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
//Section
/*
- (UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"Header"];
    self.playerMusic.musicas = [self.playerMusic.lMusicasRecomendadas objectAtIndex:(2+section)];
    header.textLabel.text = [self.playerMusic.musicas objectForKey:@"nomeAlbum"];
    header.detailTextLabel.text = [self.playerMusic.musicas objectForKey:@"nomeArtista"];
    return header;
}*/

/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0){
        CGRect headerViewRect = CGRectMake(0.0,0.0,320,40);
        UIView* headerView = [[UIView alloc] initWithFrame:headerViewRect];
        headerView.backgroundColor = [UIColor clearColor];
        self.playerMusic.musicas = [self.playerMusic.lMusicasRecomendadas objectAtIndex:(2+section)];
        NSURL *url = [NSURL URLWithString:[[self.playerMusic.musicas objectForKey:@"imgAlbum"]stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImageView *titleImage = [[UIImageView alloc] initWithImage:
                                    [UIImage imageWithData:data]];
        CGRect imageViewRect = CGRectMake(0.0,  0.0, 40 , 40);
        titleImage.frame = imageViewRect;
        titleImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [headerView addSubview:titleImage];
        
        //Then you can add a UILabel to your headerView
        return headerView;
    }
    return nil;
}*/


//Cell Original
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([titulo isEqualToString:@"Tocando"]) {
        return [self.playerMusic.lMusicasRecomendadas count];
    }else{
        return [self.playerMusic.lMusicas count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if ([titulo isEqualToString:@"Tocando"]) {
        self.playerMusic.musicas = [self.playerMusic.lMusicasRecomendadas objectAtIndex:indexPath.row];
    }else{
        self.playerMusic.musicas = [self.playerMusic.lMusicas objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = [self.playerMusic.musicas objectForKey:@"nomeMusica"];
    cell.detailTextLabel.text = [self.playerMusic.musicas objectForKey:@"nomeAlbum"];
    NSURL *url = [NSURL URLWithString:[[[self.playerMusic.musicas objectForKey:@"imgAlbum"]  stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long)NULL), ^(void) {
        NSData *data = [NSData dataWithContentsOfURL:url];
        //ONLINE
       cell.imageView.image = [[UIImage alloc] initWithContentsOfFile:[[[self.playerMusic.musicas objectForKey:@"imgAlbum"]stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];

        cell.imageView.image = [[UIImage alloc] initWithData:data];
        cell.imageView.layer.cornerRadius = 50.0f;
    });

    if ([titulo isEqualToString:@"Tocando"]) {
        self.playerMusic.musicas = [self.playerMusic.lMusicasRecomendadas objectAtIndex:0];
    }else{
        self.playerMusic.musicas = [self.playerMusic.lMusicas objectAtIndex:0];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [self.playerMusic.lMusicasRecomendadas removeObjectAtIndex:indexPath.row];
        //NSMutableArray *lMusicaTemp = self.playerMusic.lMusicasRecomendadas;
        //[lMusicaTemp removeObjectAtIndex:indexPath.row];
        //self.playerMusic.lMusicasRecomendadas = lMusicaTemp;
        //[tableView reloadData];
        [tableMusicas deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


@end
