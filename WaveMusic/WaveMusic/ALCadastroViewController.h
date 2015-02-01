//
//  ALCadastroViewController.h
//  WaveMusic
//
//  Created by Alan Magalhães Lira on 27/10/13.
//  Copyright (c) 2013 Alan Magalhães Lira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALViewController.h"
#import "DoAlertView.h"

@class ALViewController;
@interface ALCadastroViewController : UIViewController
{
 ALViewController *principal;
}
@property (weak, nonatomic) IBOutlet UIImageView *imfundo;
@property (weak, nonatomic) IBOutlet UITextField *lbLogin;
@property (weak, nonatomic) IBOutlet UITextField *lbSenha;
@property (weak, nonatomic) IBOutlet UITextField *lbConfSenha;
@property (strong, nonatomic) DoAlertView *vAlert;

- (void)setPrincipal:(ALViewController *)principalView;
- (IBAction)callBackToLogin:(id)sender;
- (IBAction)realizarCadastro:(id)sender;

@end
