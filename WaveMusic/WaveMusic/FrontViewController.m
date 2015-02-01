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

#import "FrontViewController.h"
#import "SWRevealViewController.h"
#import "ALPlayerViewController.h"
#import "UIImage+ImageEffects.h"
#import "RearViewController.h"
#import "PNChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"
#import "AMLConnectionServlet.h"

@interface FrontViewController()

// Private Methods:
- (IBAction)pushExample:(id)sender;

@end

@implementation FrontViewController

@synthesize viewPlayer, aivController, uiTxtView, btComecar, imfundo, nomeUsuario, lineChart;

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    NSLog(@"Front");
    imfundo.image = [[UIImage imageNamed:@"EstudoFundoIpad.png"] applyLightEffect];
    
    NSLog(@"Nome: %@",nomeUsuario);
    NSString *valor = [NSString stringWithFormat:@"%@",[[[AMLConnectionServlet alloc] init] obterPontuacao:nomeUsuario]];
    NSLog(@"Valor: %@",valor);
    
    
    //lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, 500, 500.0)];
    lineChart.delegate = self;
    [lineChart setXLabels:@[@"Rock",@"Jazz",@"Latin",@"Hardcore",@"Pop",@"Country",@"Blues",@"Folk",@"HipHop",@"R&B",@"Eletronic"]];
    
    // Line Chart No.1
    NSMutableArray * data01Array = [[NSMutableArray alloc] init];// = @[@60.1, @160.1, @126.4, @262.2, @186.2, @127.2, @176.2];
    //NSArray * data01Array = @[@1, @0, @3, @2, @0, @0, @1, @1, @0, @2, @1];
    for (int i=0; i<[valor length]; i++) {
        if ([valor characterAtIndex:i]!=',') {
            NSLog(@"v: %c  - %i",[valor characterAtIndex:i],(0+[valor characterAtIndex:i]));            [data01Array addObject:[NSNumber numberWithInteger:([[NSString stringWithFormat:@"%c",[valor characterAtIndex:i]] integerValue])]];
        }
    }
    NSLog(@"Array: %@",data01Array);
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [[data01Array objectAtIndex:index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01];
    [lineChart strokeChart];
    
    
	self.title = NSLocalizedString(@"Principal", nil);
    
    [self.view addSubview:aivController];
    aivController.hidden = YES;
    
    ALPlayerViewController *playerController = [[ALPlayerViewController alloc] init];
    
    SWRevealViewController *revealController = (SWRevealViewController *) [self revealViewController];
    
    [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"] style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    revealController.downViewController.view.hidden = YES;
    
    [self.navigationController setNeedsStatusBarAppearanceUpdate];
    
    
    self.viewPlayer = playerController.view;
    
    [self addChildViewController:playerController];
    
}

- (void)aivControllerIniciado
{
    [btComecar setHidden:YES];
    [uiTxtView setHidden:YES];
    [aivController startAnimating];
}

- (void)aivControllerFinalizar
{
    [aivController stopAnimating];
    [btComecar setHidden:NO];
    [uiTxtView setHidden:NO];
}

- (void)inicialiarPlayerRecomendacao
{
    ALPlayerViewController *playerVC = (ALPlayerViewController *) [self revealViewController].downViewController;
    
    [playerVC setListaRecomendacaoPorUsuario:nomeUsuario];
    [self revealViewController].downViewController.view.hidden = NO;
    [self aivControllerFinalizar];
    [playerVC playButtonPressed];
    
}

- (IBAction)IniciaRecomendacao:(id)sender {
    [self aivControllerIniciado];
    //NSLog(@"Nome Usuario: %@",nomeUsuario);
    [self performSelector:@selector(inicialiarPlayerRecomendacao) withObject:nil afterDelay:0.15];
}

#pragma mark - Example Code

- (IBAction)pushExample:(id)sender
{
	UIViewController *stubController = [[UIViewController alloc] init];
	stubController.view.backgroundColor = [UIColor whiteColor];
	[self.navigationController pushViewController:stubController animated:YES];
}


-(void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex andPointIndex:(NSInteger)pointIndex{
    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
}

-(void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}

/*

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/
@end
