//
//  ALQuestionarioViewController.m
//  WaveMusic
//
//  Created by Lab. Lacib 01 on 14/11/13.
//  Copyright (c) 2013 Alan Magalhães Lira. All rights reserved.
//

#import "ALQuestionarioViewController.h"
#import "ALQuestionarioViewCell.h"
#import "AMLConnectionServlet.h"
#import "UIImage+ImageEffects.h"

@interface ALQuestionarioViewController ()

@end

@implementation ALQuestionarioViewController
@synthesize listaAlbuns, albuns, countProc, aux, rock, jazz, latin, hardcore, pop, country, blues, folk, hiphop, reb, eletronic, collectionV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)zerarGeneros {
    rock = 0;
    jazz = 0;
    latin = 0;
    hardcore = 0;
    pop = 0;
    country = 0;
    blues = 0;
    folk = 0;
    hiphop = 0;
    reb = 0;
    eletronic = 0;
}

- (void)gerarPerfil:(NSString *)genero {
    if ([genero isEqualToString:@"Rock"]) {
        rock++;
    }else if ([genero isEqualToString:@"Jazz"]) {
        jazz++;
    }else if ([genero isEqualToString:@"Latin"]) {
        latin++;
    }else if ([genero isEqualToString:@"Hardcore"]) {
        hardcore++;
    }else if ([genero isEqualToString:@"Pop"]) {
        pop++;
    }else if ([genero isEqualToString:@"Country"]) {
        country++;
    }else if ([genero isEqualToString:@"Blues"]) {
        blues++;
    }else if ([genero isEqualToString:@"Folk"]) {
        folk++;
    }else if ([genero isEqualToString:@"Hip Hop"]) {
        hiphop++;
    }else if ([genero isEqualToString:@"R&B"]) {
        reb++;
    }else if ([genero isEqualToString:@"Eletronic"]) {
        eletronic++;
    }
}

- (void)viewDidLoad
{
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    [super viewDidLoad];
    [self zerarGeneros];
    AMLConnectionServlet *cServlet = [[AMLConnectionServlet alloc] init];
    listaAlbuns = cServlet.obterSelecaoParaQuestionario;
    //listaAlbuns = [principal albunSelecaoQuestionario];
    aux = 0;
    countProc = 1;
	// Do any additional setup after loading the view.
    
    
    self.view.viewForBaselineLayout.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.4];
    self.view.viewForBaselineLayout.layer.masksToBounds = YES;
    self.view.viewForBaselineLayout.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.view.viewForBaselineLayout.layer.shouldRasterize = YES;
    self.view.viewForBaselineLayout.clipsToBounds = YES;
    
    self.collectionV.viewForBaselineLayout.backgroundColor = [UIColor clearColor];
    self.collectionV.viewForBaselineLayout.layer.masksToBounds = YES;
    self.collectionV.viewForBaselineLayout.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.collectionV.viewForBaselineLayout.layer.shouldRasterize = YES;
    self.collectionV.viewForBaselineLayout.clipsToBounds = YES;
    
    /*_vAlert = [[DoAlertView alloc]init];
    _vAlert.nAnimationType = 4;
    _vAlert.dRound = 2.0;*/

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPrincipal:(ALViewController *)principalView{
    principal = principalView;
}

- (IBAction)callCadastroView:(id)sender {
    [principal changeToCadastro];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //usar o 33 somente
    countProc ++;
    lbProcesso.text = [NSString stringWithFormat:@"Processo %i de 11",(countProc)];
    if (aux<33) {
        albuns = [listaAlbuns objectAtIndex:(indexPath.item + aux)];
        [self gerarPerfil:[albuns objectForKey:@"GeneroAlbum"]];
        aux +=3;
        //_vAlert.bDestructive = NO;
        //[_vAlert doAlert:@"Sucesso" body:@"Carregando informações do usuário." done:^(DoAlertView *alertView){
        //}];
        //[self performSelectorInBackground:@selector(reloadDataTableAlbuns) withObject:nil];
        [collectionV reloadData];
        if (aux == 33) {
            aux = 0;
            NSLog(@"[%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i]",rock,jazz,latin,hardcore,pop,country,blues,folk,hiphop,reb,eletronic);
            [principal cadastrarPontuacao:[NSString stringWithFormat:@"%i%i%i%i%i%i%i%i%i%i%i",rock,jazz,latin,hardcore,pop,country,blues,folk,hiphop,reb,eletronic]];
            [principal inicializarPermissaoLogin];
        }
    }
}

-(void) reloadDataTableAlbuns {
    [collectionV reloadData];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    ALQuestionarioViewCell *cvc = [[ALQuestionarioViewCell alloc] init];
    cvc = (ALQuestionarioViewCell *)[collectionV dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    [[cvc viewForBaselineLayout] setBackgroundColor:[UIColor clearColor]];
    albuns = [listaAlbuns objectAtIndex:(indexPath.item + aux)];
    
    //NSError *error =nil;
    
    //Exemplo Encoding JSON Unicode to UTF8 or UTF16
    NSURL *url = [NSURL URLWithString:[[[albuns objectForKey:@"imgAlbum"] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    
    [cvc.imgAlbum setBackgroundColor:[UIColor blackColor]];
    
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        //if ( data == nil )
          //  return;
    //dispatch_async(dispatch_get_main_queue(), ^{
        
            // WARNING: is the cell still using the same data by this point??
            [cvc.imgAlbum setBackgroundColor:[UIColor clearColor]];
            cvc.imgAlbum.image = [UIImage imageWithData: data];
       // });
    //});
    
    [self performSelectorOnMainThread:@selector(onTimerOfViewController) withObject:nil waitUntilDone:NO];
    cvc.lbAlbum.text = [NSString stringWithFormat:@"%@",[albuns objectForKey:@"nomeAlbum"]];
    cvc.lbMusica.text = [NSString stringWithFormat:@"%@",[albuns objectForKey:@"nomeMusica"]];
    cvc.lbArtista.text = [NSString stringWithFormat:@"%@",[albuns objectForKey:@"ArtistaAlbum"]];
    return cvc;
}



- (void)onTimerOfViewController
{
    sleep(0.75);
    [_vAlert hideAlert];
    //_vAlert = nil;
}

@end
