//
//  ALConfiguracaoViewController.m
//  WaveMusic
//
//  Created by Alan Magalhães Lira on 20/01/14.
//  Copyright (c) 2014 Alan Magalhães Lira. All rights reserved.
//

#import "ALConfiguracaoViewController.h"
#import "ALControllerCS.h"

@interface ALConfiguracaoViewController ()

@end

@implementation ALConfiguracaoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWithNomeUsuario:_usuario];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNomeUsuario: (NSString *)usuario{
    NSLog(@"initWithUSuario");
    _usuario = usuario;
    NSMutableArray *configuracao = [[[ALControllerCS alloc] init] getObterConfiguracaoPorUsuario:usuario];
    //NSLog(@"knk: %@",[[configuracao objectAtIndex:0] objectForKey:@"knn"]);
    [self.lbKnn setText:[[configuracao objectAtIndex:0] objectForKey:@"knn"]];
    [self.lbTamPop setText:[[configuracao objectAtIndex:0] objectForKey:@"tamPop"]];
    [self.lbNumGer setText:[[configuracao objectAtIndex:0] objectForKey:@"numGera"]];
    [self.lbProbMut setText:[[configuracao objectAtIndex:0] objectForKey:@"probMuta"]];
    [self.sliderKnn setValue:(int) [[configuracao objectAtIndex:0] objectForKey:@"knn"]];
    [self.sliderTamPop setValue:(int) [[configuracao objectAtIndex:0] objectForKey:@"tamPop"]];
    [self.sliderProbMut setValue:(int) [[configuracao objectAtIndex:0] objectForKey:@"probMuta"]];
    [self.sliderNumGera setValue:(int) [[configuracao objectAtIndex:0] objectForKey:@"numGera"]];
    return self;
}

- (IBAction)salvarConfiguracao:(id)sender {
    /*NSString *resultado = [[[ALControllerCS alloc] init] getAlterarConfiguracaoKnn:[NSString stringWithFormat:@"%f",self.sliderKnn.value andNumGer: andTamPop:self.tamPopulacao.text andProbMut:self.txProbMutacao.text];
    if ([resultado isEqualToString:@"n"]) {
        _vAlert = [[DoAlertView alloc] init];
        _vAlert.nAnimationType = 4;
        _vAlert.dRound = 2.0;
        _vAlert.bDestructive = YES;
        [_vAlert doYes:@"Atenção"
                  body:@"Erro ao salvar configurações, verifique se as informações acima são válidas ou não existe nenhum campo em branco. OBS: Só o campo Probabilidade de Mutação que pode ser número tipo real."
                   yes:^(DoAlertView *alertView) {
                       
                       
                   }];
    } else {
        _vAlert = [[DoAlertView alloc] init];
        _vAlert.nAnimationType = 4;
        _vAlert.dRound = 2.0;
        _vAlert.bDestructive = NO;
        [_vAlert doYes:@"Sucesso"
                  body:@"As configuração foram alteradas com sucesso."
                   yes:^(DoAlertView *alertView) {
                       
                       
                   }];
    }*/
}
@end
