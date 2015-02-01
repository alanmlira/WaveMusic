//
//  ALLoginViewController.m
//  WaveMusic
//
//  Created by Alan Magalhães Lira on 27/10/13.
//  Copyright (c) 2013 Alan Magalhães Lira. All rights reserved.
//

#import "ALLoginViewController.h"
#import "UIImage+ImageEffects.h"

@interface ALLoginViewController ()

@end

@implementation ALLoginViewController

@synthesize lblogin,lbsenha,btgocadastro,btlogar, imfundo;

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

- (IBAction)realizarLogin:(id)sender {
    [principal realizarLogin:lblogin.text andSenha:lbsenha.text];
}

@end
