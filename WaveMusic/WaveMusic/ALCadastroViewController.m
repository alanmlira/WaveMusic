//
//  ALCadastroViewController.m
//  WaveMusic
//
//  Created by Alan Magalhães Lira on 27/10/13.
//  Copyright (c) 2013 Alan Magalhães Lira. All rights reserved.
//

#import "ALCadastroViewController.h"
#import "UIImage+ImageEffects.h"

@interface ALCadastroViewController ()

@end

@implementation ALCadastroViewController

@synthesize imfundo,lbConfSenha,lbSenha,lbLogin;

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
    self.view.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.4];
    self.view.layer.masksToBounds = YES;
    //self.view.layer.cornerRadius = 50.0;
    //self.view.layer.borderColor = [UIColor whiteColor].CGColor;
    //self.view.layer.borderWidth = 3.0f;
    self.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.view.layer.shouldRasterize = YES;
    self.view.clipsToBounds = YES;
	// Do any additional setup after loading the view.
}

- (void)setPrincipal:(ALViewController *)principalView{
    principal = principalView;
}

- (IBAction)callBackToLogin:(id)sender {
    [principal changeToLogin];
}

- (IBAction)realizarCadastro:(id)sender {
    if (![lbSenha.text isEqualToString:lbConfSenha.text]) {
        _vAlert = [[DoAlertView alloc]init];
        _vAlert.nAnimationType = 4;
        _vAlert.dRound = 2.0;
        _vAlert.bDestructive = YES;
        [_vAlert doYes:@"As senhas não conferem." yes:^(DoAlertView *alertView){
            
        }];
    } else {
        [principal cadastrarUsuario:lbLogin.text andSenha:lbSenha.text];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
