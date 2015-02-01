//
//  ALLoginViewController.h
//  WaveMusic
//
//  Created by Alan Magalhães Lira on 27/10/13.
//  Copyright (c) 2013 Alan Magalhães Lira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALViewController.h"

@class ALViewController;
@interface ALLoginViewController : UIViewController
{
    ALViewController *principal;
}

@property (weak, nonatomic) IBOutlet UIImageView *imfundo;
@property (weak, nonatomic) IBOutlet UITextField *lblogin;
@property (weak, nonatomic) IBOutlet UITextField *lbsenha;
@property (weak, nonatomic) IBOutlet UIButton *btlogar;
@property (weak, nonatomic) IBOutlet UIButton *btgocadastro;

- (IBAction)callCadastroView:(id)sender;
- (void)setPrincipal:(ALViewController *)principalView;

@end
