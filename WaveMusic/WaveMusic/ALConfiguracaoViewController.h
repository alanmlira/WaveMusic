//
//  ALConfiguracaoViewController.h
//  WaveMusic
//
//  Created by Alan Magalhães Lira on 20/01/14.
//  Copyright (c) 2014 Alan Magalhães Lira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoAlertView.h"

@interface ALConfiguracaoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *sliderKnn;
@property (weak, nonatomic) IBOutlet UISlider *sliderTamPop;
@property (weak, nonatomic) IBOutlet UISlider *sliderNumGera;
@property (weak, nonatomic) IBOutlet UISlider *sliderProbMut;
@property (weak, nonatomic) IBOutlet UILabel *lbKnn;
@property (weak, nonatomic) IBOutlet UILabel *lbTamPop;
@property (weak, nonatomic) IBOutlet UILabel *lbNumGer;
@property (weak, nonatomic) IBOutlet UILabel *lbProbMut;

@property (nonatomic) NSString *usuario;
@property (strong, nonatomic) DoAlertView *vAlert;


- (IBAction)salvarConfiguracao:(id)sender;
- (id)initWithNomeUsuario: (NSString *)usuario;
@end
