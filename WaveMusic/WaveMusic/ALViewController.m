//
//  ALViewController.m
//  WaveMusic
//
//  Created by Alan Magalhães Lira on 27/10/13.
//  Copyright (c) 2013 Alan Magalhães Lira. All rights reserved.
//

#import "ALViewController.h"
#import "ALLoginViewController.h"
#import "ALCadastroViewController.h"
#import "AMLConnectionServlet.h"
#import "ALControllerCS.h"
#import "SWRevealViewController.h"
#import "FrontViewController.h"
#import "RearViewController.h"
#import "ALPlayerViewController.h"
#import "ALQuestionarioViewController.h"
#import "UIImage+ImageEffects.h"

@interface ALViewController ()

@end

@implementation ALViewController
{
    dispatch_queue_t queue;
    NSThread *teste;
}

@synthesize mainRevealController,imfundo, nomeUsuario;

- (void)viewDidLoad
{
    [super viewDidLoad];
    telaLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    if ([self interfaceOrientation]==UIInterfaceOrientationLandscapeLeft || [self interfaceOrientation]==UIInterfaceOrientationLandscapeRight) {
        [telaLogin.view setFrame:CGRectMake(self.view.frame.size.height/2 - 250, self.view.frame.size.width/2 - 150, 500, 300)];
    } else {
        [telaLogin.view setFrame:CGRectMake(self.view.frame.size.width/2 - 500/2, self.view.frame.size.height/2 - 300/2, 500, 300)];
    }
    [telaLogin setPrincipal:self];
    imfundo.image = [self.imfundo.image applyLightEffect];
    [self.view addSubview:telaLogin.view];
    
    _vAlert = [[DoAlertView alloc]init];
    _vAlert.nAnimationType = 4;
    _vAlert.dRound = 2.0;
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if(fromInterfaceOrientation==UIInterfaceOrientationPortrait || fromInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
    {
        [UIView animateWithDuration:0.0f animations:^{[telaLogin.view setFrame:CGRectMake(self.view.frame.size.height/2 - 500/2, self.view.frame.size.width/2 - 150, 500, 300)];} completion:^(BOOL finished){}];
        [UIView animateWithDuration:0.0f animations:^{[telaCadastro.view setFrame:CGRectMake(self.view.frame.size.width/2 - 250/2, self.view.frame.size.height/2 - 350, 500, 500)];} completion:^(BOOL finished){}];
        [UIView animateWithDuration:0.0f animations:^{[telaQuestionario.view setFrame:CGRectMake(self.view.frame.size.height/2 - 600/2, self.view.frame.size.width/2 - 250, 600, 500)];} completion:^(BOOL finished){}];
    }
    
    else
    {
        [UIView animateWithDuration:0.0f animations:^{[telaLogin.view setFrame:CGRectMake(self.view.frame.size.width/2 - 500/2, self.view.frame.size.height/2 - 300/2, 500, 300)];} completion:^(BOOL finished){}];
        [UIView animateWithDuration:0.0f animations:^{[telaCadastro.view setFrame:CGRectMake(self.view.frame.size.width/2 - 500/2, self.view.frame.size.height/2 - 500/2, 500, 500)];} completion:^(BOOL finished){}];
        [UIView animateWithDuration:0.0f animations:^{[telaQuestionario.view setFrame:CGRectMake(self.view.frame.size.width/2 - 600/2, self.view.frame.size.height/2 - 500/2, 600, 500)];} completion:^(BOOL finished){}];
    }
}

- (void)changeToCadastro {
    
    telaCadastro = [self.storyboard instantiateViewControllerWithIdentifier:@"cadastro"];
    if ([self interfaceOrientation]==UIInterfaceOrientationLandscapeLeft || [self interfaceOrientation]==UIInterfaceOrientationLandscapeRight) {
        [UIView animateWithDuration:0.5f animations:^{[telaLogin.view setFrame:CGRectMake(-500 ,self.view.frame.size.width/2 - 150, 500, 300)];} completion:^(BOOL finished){ [telaLogin.view removeFromSuperview]; }];
        [telaCadastro.view setFrame:CGRectMake(self.view.frame.size.height, self.view.frame.size.width/2 - 500/2, 500, 500)];
        [telaCadastro setPrincipal:self];
        [self.view addSubview:telaCadastro.view];
        [UIView animateWithDuration:0.5f animations:^{[telaCadastro.view setFrame:CGRectMake(self.view.frame.size.height/2 - 500/2, self.view.frame.size.width/2 - 500/2, 500, 500)];} completion:^(BOOL finished){}];
    }else {
        
        [UIView animateWithDuration:0.5f animations:^{[telaLogin.view setFrame:CGRectMake(-500, self.view.frame.size.height/2 - 300/2, 500, 300)];} completion:^(BOOL finished){ [telaLogin.view removeFromSuperview]; }];
        [telaCadastro.view setFrame:CGRectMake(self.view.frame.size.width, self.view.frame.size.height/2 - 500/2, 500, 500)];
        [telaCadastro setPrincipal:self];
        [self.view addSubview:telaCadastro.view];
        [UIView animateWithDuration:0.5f
                         animations:^{[telaCadastro.view setFrame:CGRectMake(self.view.frame.size.width/2 - 500/2, self.view.frame.size.height/2 - 500/2, 500, 500)];}
                         completion:^(BOOL finished){}];
        
    }
    
}

- (void)changeLoginToQuestionario {
    
    telaQuestionario = [self.storyboard instantiateViewControllerWithIdentifier:@"questionario"];
    if ([self interfaceOrientation]==UIInterfaceOrientationLandscapeLeft || [self interfaceOrientation]==UIInterfaceOrientationLandscapeRight) {
        [UIView animateWithDuration:0.5f animations:^{[telaLogin.view setFrame:CGRectMake(-500 ,self.view.frame.size.width/2 - 150, 500, 300)];} completion:^(BOOL finished){ [telaLogin.view removeFromSuperview]; }];
        [telaQuestionario.view setFrame:CGRectMake(self.view.frame.size.height, self.view.frame.size.width/2 - 600/2, 600, 500)];
        [telaQuestionario setPrincipal:self];
        [self.view addSubview:telaQuestionario.view];
        [UIView animateWithDuration:0.5f animations:^{[telaQuestionario.view setFrame:CGRectMake(self.view.frame.size.height/2 - 600/2, self.view.frame.size.width/2 - 500/2, 600, 500)];} completion:^(BOOL finished){}];
        
    }else {
        
        [UIView animateWithDuration:0.5f animations:^{[telaLogin.view setFrame:CGRectMake(-500, self.view.frame.size.height/2 - 300/2, 500, 300)];} completion:^(BOOL finished){ [telaLogin.view removeFromSuperview]; }];
        [telaQuestionario.view setFrame:CGRectMake(self.view.frame.size.width, self.view.frame.size.height/2 - 500/2, 600, 500)];
        [telaQuestionario setPrincipal:self];
        [self.view addSubview:telaQuestionario.view];
        [UIView animateWithDuration:0.5f
                         animations:^{[telaQuestionario.view setFrame:CGRectMake(self.view.frame.size.width/2 - 600/2, self.view.frame.size.height/2 - 500/2, 600, 500)];}
                         completion:^(BOOL finished){}];
    }
    //[self performSelectorOnMainThread:@selector(onTimerOfViewController) withObject:nil waitUntilDone:NO];
}

- (void)changeCadastroToQuestionario {
    [UIView animateWithDuration:0.5f animations:^{[telaCadastro.view setFrame:CGRectMake(-500, self.view.frame.size.height/2 - 500/2, 500, 500)];} completion:^(BOOL finished){ [telaCadastro.view removeFromSuperview]; }];
    
    telaQuestionario = [self.storyboard instantiateViewControllerWithIdentifier:@"questionario"];
    if ([self interfaceOrientation]==UIInterfaceOrientationLandscapeLeft || [self interfaceOrientation]==UIInterfaceOrientationLandscapeRight) {
        [telaQuestionario.view setFrame:CGRectMake(self.view.frame.size.height, self.view.frame.size.width/2 - 600/2, 600, 500)];
        [telaQuestionario setPrincipal:self];
        [self.view addSubview:telaQuestionario.view];
        [UIView animateWithDuration:0.5f animations:^{[telaQuestionario.view setFrame:CGRectMake(self.view.frame.size.height/2 - 600/2, self.view.frame.size.width/2 - 500/2, 600, 500)];} completion:^(BOOL finished){}];
    }else {
        [telaQuestionario.view setFrame:CGRectMake(self.view.frame.size.width, self.view.frame.size.height/2 - 500/2, 600, 500)];
        [telaQuestionario setPrincipal:self];
        [self.view addSubview:telaQuestionario.view];
        [UIView animateWithDuration:0.5f
                         animations:^{[telaQuestionario.view setFrame:CGRectMake(self.view.frame.size.width/2 - 600/2, self.view.frame.size.height/2 - 500/2, 600, 500)];}
                         completion:^(BOOL finished){}];
        
    }
    
}

- (void)changeQuestToLogin {
    
    telaLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    if ([self interfaceOrientation]==UIInterfaceOrientationLandscapeLeft || [self interfaceOrientation]==UIInterfaceOrientationLandscapeRight) {
        [UIView animateWithDuration:0.5f animations:^{[telaQuestionario.view setFrame:CGRectMake(self.view.frame.size.width, self.view.frame.size.height/2 - 500/2, 600, 500)];} completion:^(BOOL finished){ [telaQuestionario.view removeFromSuperview]; }];
        
        [telaLogin.view setFrame:CGRectMake(-500 ,self.view.frame.size.width/2 - 150, 500, 300)];
        [telaLogin setPrincipal:self];
        [self.view addSubview:telaLogin.view];
        [UIView animateWithDuration:0.5f animations:^{[telaLogin.view setFrame:CGRectMake(self.view.frame.size.height/2 - 250, self.view.frame.size.width/2 - 150, 500, 300)];} completion:^(BOOL finished){}];
        
    }else {
        [UIView animateWithDuration:0.5f animations:^{[telaQuestionario.view setFrame:CGRectMake(self.view.frame.size.width, self.view.frame.size.height/2 - 500/2, 600, 500)];} completion:^(BOOL finished){ [telaQuestionario.view removeFromSuperview]; }];
        
        [telaLogin.view setFrame:CGRectMake(-500, self.view.frame.size.height/2 - 300/2, 500, 300)];
        [telaLogin setPrincipal:self];
        [self.view addSubview:telaLogin.view];
        [UIView animateWithDuration:0.5f
                         animations:^{[telaLogin.view setFrame:CGRectMake(self.view.frame.size.width/2 - 500/2, self.view.frame.size.height/2 - 300/2, 500, 300)];}
                         completion:^(BOOL finished){}];
        
    }
    
}

- (void)changeToLogin {
    
    telaLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    if ([self interfaceOrientation]==UIInterfaceOrientationLandscapeLeft || [self interfaceOrientation]==UIInterfaceOrientationLandscapeRight) {
        [UIView animateWithDuration:0.5f animations:^{[telaCadastro.view setFrame:CGRectMake(self.view.frame.size.height, self.view.frame.size.width/2 - 500/2, 500, 500)];} completion:^(BOOL finished){ [telaCadastro.view removeFromSuperview]; }];
        
        [telaLogin.view setFrame:CGRectMake(-300 ,self.view.frame.size.width/2 - 150, 500, 300)];
        [telaLogin setPrincipal:self];
        [self.view addSubview:telaLogin.view];
        [UIView animateWithDuration:0.5f animations:^{[telaLogin.view setFrame:CGRectMake(self.view.frame.size.height/2 - 250, self.view.frame.size.width/2 - 150, 500, 300)];} completion:^(BOOL finished){}];
    }else {
        [UIView animateWithDuration:0.5f animations:^{[telaCadastro.view setFrame:CGRectMake(self.view.frame.size.width, self.view.frame.size.height/2 - 500/2, 500, 500)];} completion:^(BOOL finished){ [telaCadastro.view removeFromSuperview]; }];
        
        [telaLogin.view setFrame:CGRectMake(-500, self.view.frame.size.height/2 - 300/2, 500, 300)];
        [telaLogin setPrincipal:self];
        [self.view addSubview:telaLogin.view];
        [UIView animateWithDuration:0.5f
                         animations:^{[telaLogin.view setFrame:CGRectMake(self.view.frame.size.width/2 - 500/2, self.view.frame.size.height/2 - 300/2, 500, 300)];}
                         completion:^(BOOL finished){}];
        
    }
    
}

- (void)cadastrarUsuario:(NSString*)login andSenha:(NSString *)senha {
    AMLConnectionServlet *cServlet = [[AMLConnectionServlet alloc] init];
    NSString *permissao = [cServlet criarUsuario:login andSenha:senha];
    if ([permissao isEqualToString:@"s"]) {
        nomeUsuario = login;
        _vAlert.bDestructive = NO;
        [_vAlert doYes:@"Usuário cadastrado com sucesso." yes:^(DoAlertView *alertView){
          [self changeCadastroToQuestionario];
        }];
        }else{
            _vAlert.bDestructive = YES;
            [_vAlert doYes:@"O usuário ou senha inseridos estão incorretos." yes:^(DoAlertView *alertView){
                
            }];
    }
}

- (void)cadastrarPontuacao:(NSString *)pontuacao {
    AMLConnectionServlet *cServlet = [[AMLConnectionServlet alloc] init];
    [cServlet criarPontuacaoPorUsuario:nomeUsuario andPontuacao:pontuacao];
}

- (void)realizarLogin:(NSString*)login andSenha:(NSString *)senha {
    AMLConnectionServlet *cServlet = [[AMLConnectionServlet alloc] init];
    NSLog(@"Antes");
    NSString *permissao = [cServlet obterPermissaoLogin:login andSenha:senha];
    NSLog(@"Depois: %@",permissao);
    if ([permissao isEqualToString:@"s1"] || [permissao isEqualToString:@"s"]) {
        nomeUsuario = login;
        
        _vAlert.bDestructive = NO;
        [_vAlert doAlert:@"Sucesso" body:@"Carregando informações do usuário." duration:1.5 done:^(DoAlertView *alertView){
            [self inicializarPermissaoLogin];
        }];
    } else if ([permissao isEqualToString:@"s0"] ){
        
        nomeUsuario = login;
        //_vAlert.bDestructive = NO;
        //[_vAlert doAlert:@"Aguarde..." body:@"Carregando informações da base de dados." done:^(DoAlertView *alertView){
        //}];
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        //teste =[[NSThread alloc] initWithTarget:self selector:@selector(changeLoginToQuestionario) object:nil];
        //[teste start];
        NSLog(@"Entrou s0");
        [self changeLoginToQuestionario];
        //});
        
    } else{
        _vAlert.bDestructive = YES;
        [_vAlert doYes:@"O usuário ou senha inseridos estão incorretos." yes:^(DoAlertView *alertView){
            
        }];
    }
}

- (void)inicializarPermissaoLogin {
    SWRevealViewController *revealController = [self mainRevealController];
    FrontViewController *frontViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"front"];
    frontViewController.nomeUsuario = nomeUsuario;
    ALPlayerViewController *downViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"player"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    
    downViewController.mainRevealController = revealController;
    [(RearViewController *)(UINavigationController *) mainRevealController.rearViewController.presentingViewController setNomeUsuario:nomeUsuario];
    [(RearViewController *)(UINavigationController *) revealController.rearViewController.presentingViewController setNomeUsuario:nomeUsuario];
    
    [revealController setFrontViewController:navigationController andDownViewController:downViewController animated:NO];
    [self.mainRevealController setFrontViewController:navigationController andDownViewController:downViewController animated:YES];
    [self presentViewController:self.mainRevealController animated:YES completion:nil];
}

#pragma -AMLConnectionServlet

- (NSMutableArray *)albunSelecaoQuestionario {
    return [[AMLConnectionServlet alloc] init].obterSelecaoParaQuestionario;
}

#pragma -UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        OKPressed = true;
        
    }
    else
    {
        OKPressed = false;
    }
    // If no text or wrong text show alert again otherwise normal actions
}


- (void)onTimerOfViewController
{
    sleep(0.75);
    [_vAlert hideAlert];
    //_vAlert = nil;
}

@end
