/*
 
 Copyright (c) 2013 Joan Lluch <joan.lluch@sweetwilliamsl.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 Original code:
 Copyright (c) 2011, Philip Kluz (Philip.Kluz@zuui.org)
 */

#import <UIKit/UIKit.h>
#import "PNLineChart.h"
#import "PNChart.h"


@interface FrontViewController : UIViewController <PNChartDelegate>
{
    IBOutlet UIView *viewPlayer;
    IBOutlet UIActivityIndicatorView *aivController;
    __weak IBOutlet UITextField *knnK;
    __weak IBOutlet UITextField *agNumGera;
    __weak IBOutlet UITextField *agTamPop;
    __weak IBOutlet UITextField *agProbMuta;
    
}

@property (strong, nonatomic) IBOutlet UIView *viewPlayer;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *aivController;
@property (weak, nonatomic) IBOutlet UITextView *uiTxtView;
@property (weak, nonatomic) IBOutlet UIButton *btComecar;
@property (weak, nonatomic) IBOutlet UIImageView *imfundo;
@property (nonatomic) NSString *nomeUsuario;
@property (weak, nonatomic) IBOutlet PNLineChart *lineChart;


- (void)aivControllerIniciado;
- (void)aivControllerFinalizar;
- (IBAction)IniciaRecomendacao:(id)sender;

@end