//
//  ALViewController.h
//  WaveMusic
//
//  Created by Alan Magalhães Lira on 27/10/13.
//  Copyright (c) 2013 Alan Magalhães Lira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALCadastroViewController.h"
#import "ALLoginViewController.h"
#import "ALQuestionarioViewController.h"
#import "SWRevealViewController.h"
#import <dispatch/dispatch.h>
#import "DoAlertView.h"

@class ALLoginViewController;
@class ALCadastroViewController;
@class ALQuestionarioViewController;

@interface ALViewController : UIViewController <UIViewControllerTransitioningDelegate>
{
    ALLoginViewController *telaLogin;
    ALCadastroViewController *telaCadastro;
    ALQuestionarioViewController *telaQuestionario;
    BOOL OKPressed;
}
@property (strong, nonatomic) SWRevealViewController *mainRevealController;
@property (weak, nonatomic) IBOutlet UIImageView *imfundo;
@property (nonatomic) NSString *nomeUsuario;
@property (strong, nonatomic) DoAlertView *vAlert;

- (void)changeToCadastro;
- (void)changeToLogin;
- (void)changeQuestToLogin;
- (void)inicializarPermissaoLogin;
- (void)changeLoginToQuestionario;
- (void)changeCadastroToQuestionario;
- (void)cadastrarUsuario:(NSString*)login andSenha:(NSString *)senha;
- (void)realizarLogin:(NSString*)login andSenha:(NSString *)senha;
- (void)cadastrarPontuacao:(NSString *)pontuacao;

#pragma -AMLConnectionServlet
- (NSMutableArray *)albunSelecaoQuestionario;

@end
