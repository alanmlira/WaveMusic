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
 
 */

#import "RearViewController.h"

#import "SWRevealViewController.h"
#import "FrontViewController.h"
#import "AMLConnectionServlet.h"
//#import "AMLPlayerRecomendacao.h"
#import "ALPlayerViewController.h"
#import "ALConfiguracaoViewController.h"


@interface RearViewController()

@end

@implementation RearViewController

@synthesize rearTableView = _rearTableView, nomeUsuario;


- (void)viewDidLoad
{
	[super viewDidLoad];
    self.rearTableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.rearTableView.opaque = NO;
    self.rearTableView.backgroundColor = [UIColor clearColor];
    
    //self.rearTableView.tableHeaderView = view;
    NSLog(@"Nome: %@", nomeUsuario);
    
	
    // We determine whether we have a grand parent SWRevealViewController, this means we are at least one level behind the hierarchy
    SWRevealViewController *parentRevealController = (SWRevealViewController *) self.revealViewController;
    SWRevealViewController *grandParentRevealController = (SWRevealViewController *)parentRevealController.revealViewController;
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStyleDone target:grandParentRevealController action:@selector(revealToggle:)];
    
    
    // if we have a reveal controller as a grand parent, this means we are are being added as a
    // child of a detail (child) reveal controller, so we add a gesture recognizer provided by our grand parent to our
    // navigation bar as well as a "reveal" button
    if ( grandParentRevealController )
    {
        // to present a title, we count the number of ancestor reveal controllers we have, this is of course
        // only a hack for demonstration purposes, on a real project you would have a model telling this.
        NSInteger level=0;
        UIViewController *controller = grandParentRevealController;
        while( nil != (controller = [controller revealViewController]) )
            level++;
        
        //NSString *title = [NSString stringWithFormat:@"Detail Level %d", level];
        
        [self.navigationController.navigationBar addGestureRecognizer:grandParentRevealController.panGestureRecognizer];
        self.navigationItem.leftBarButtonItem = revealButtonItem;
        //self.navigationItem.title = title;
    }
    self.nomeUsuario = [(FrontViewController *)[(UINavigationController *) [self.revealViewController frontViewController] visibleViewController] nomeUsuario];
    NSLog(@"NomeXXX: %@",nomeUsuario);
    self.rearTableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        view.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((320/2) - (100/2),
                                                                               (view.frame.size.height/2) - (150/2), 100, 100)];
        imageView.image = [UIImage imageNamed:@"user.png"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 320, 24)];
        
        label.text = self.nomeUsuario;
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
    
}

-(id)initWithNomeUsuario:(NSString *)nome
{
    self.nomeUsuario = nome;
    NSLog(@"nome: %@",nome);
    //[self viewDidLoad];
    return self;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)alterTitleTableView {
    self.rearTableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        view.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((320/2) - (100/2),
                                                                               (view.frame.size.height/2) - (150/2), 100, 100)];
        imageView.image = [UIImage imageNamed:@"user.png"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 320, 24)];
        
        label.text = nomeUsuario;
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
    {
        //return nil;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
        view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
        label.text = @"Opções";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        [view addSubview:label];
        return view;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    label.text = @"Lacib Music";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 34;
    
    return 34;
}


#pragma marl - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	NSInteger row = indexPath.row;
    
	if (nil == cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
	}
	
	if (row == 0)
	{
		cell.textLabel.text = @"Lista Completa de Músicas";
	}
	else if (row == 1)
	{
		cell.textLabel.text = @"Álbuns";
	}
	else if (row == 2)
	{
		cell.textLabel.text = @"Configuracões";
	}
    else if (row == 3)
	{
		cell.textLabel.text = @"Sair";
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWRevealViewController *revealController = (SWRevealViewController *) [self revealViewController];
    UIViewController *frontViewController = revealController.frontViewController;
    UINavigationController *frontNavigationController =nil;
    
    if ( [frontViewController isKindOfClass:[UINavigationController class]] )
        frontNavigationController = (id)frontViewController;
    
    NSInteger row = indexPath.row;
    
	// Here you'd implement some of your own logic... I simply take for granted that the first row (=0) corresponds to the "FrontViewController".
	if (row == 0)
	{
		// Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
        UINavigationController *navFront = (UINavigationController *) revealController.frontViewController;
        
        if (![navFront.topViewController.title  isEqual: @"Lista Musical Completa"]) {
            @try {
                FrontViewController *frontVC = (FrontViewController *) navFront.topViewController;
                
                [frontVC aivControllerIniciado];
                [self performSelector:@selector(inicializarListaMusicasCompleto) withObject:nil afterDelay:0];
            }
            @catch (NSException *exception) {
                _vAlert = [[DoAlertView alloc] init];
                _vAlert.nAnimationType = 4;
                _vAlert.dRound = 2.0;
                _vAlert.bDestructive = YES;
                [_vAlert doYes:@"Atenção"
                          body:@"Erro ao iniciar lista musical do servidor, informe eventuais erros ao suporte."
                           yes:^(DoAlertView *alertView) {
                               
                               
                           }];
            }
        } else {
            NSLog(@"Não faz nada.");
        }
        [revealController revealToggleAnimated:YES];
	}
    
	// ... and the second row (=1) corresponds to the "MapViewController".
	else if (row == 1)
	{
		// Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
        
        UINavigationController *navFront = (UINavigationController *) revealController.frontViewController;
        
        if (![navFront.topViewController.title  isEqual: @"Álbuns"]) {
            @try {
                FrontViewController *frontVC = (FrontViewController *) navFront.topViewController;
                [frontVC aivControllerIniciado];
                [self performSelector:@selector(inicializarListaAlbuns) withObject:nil afterDelay:0];
                
            }
            @catch (NSException *exception) {
                _vAlert = [[DoAlertView alloc] init];
                _vAlert.nAnimationType = 4;
                _vAlert.dRound = 2.0;
                _vAlert.bDestructive = YES;
                [_vAlert doYes:@"Atenção"
                          body:@"Erro ao iniciar Álbuns do servidor, informe eventuais erros ao suporte."
                           yes:^(DoAlertView *alertView) {
                               
                           }];
            }
        } else {
            NSLog(@"Não faz nada.");
        }
        
        [revealController revealToggleAnimated:YES];
	}
	else if (row == 2)
	{
        UINavigationController *navFront = (UINavigationController *) revealController.frontViewController;
        
        if (![navFront.topViewController.title  isEqual: @"Configurações"]) {
            @try {
                FrontViewController *frontVC = (FrontViewController *) navFront.topViewController;
                [frontVC aivControllerIniciado];
                [self performSelector:@selector(inicializarConfiguracoes) withObject:nil afterDelay:0];
                
            }
            @catch (NSException *exception) {
                _vAlert = [[DoAlertView alloc] init];
                _vAlert.nAnimationType = 4;
                _vAlert.dRound = 2.0;
                _vAlert.bDestructive = YES;
                [_vAlert doYes:@"Atenção"
                            body:@"Erro ao sincronizar, informe eventuais erros ao suporte."
                             yes:^(DoAlertView *alertView) {
                                 
                                 
                             }];
            }
        } else {
            NSLog(@"Não faz nada.");
        }
        
        [revealController revealToggleAnimated:YES];
	}
	else if (row == 3)
	{
        _vAlert = [[DoAlertView alloc] init];
        _vAlert.nAnimationType = 4;
        _vAlert.dRound = 2.0;
        _vAlert.bDestructive = YES;
        [_vAlert doYesNo:@"Atenção"
                    body:@"Deseja realmente deslogar do aplicativo ?"
                     yes:^(DoAlertView *alertView) {
                         
                         [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"inicial"] animated:YES completion:nil];
                         
                         
                     } no:^(DoAlertView *alertView) {
                         
                         NSLog(@"Noooooooooooooo!!!!");
                         
                     }];
    }
}


-(void)inicializarRevealViewController
{
    SWRevealViewController *revealController = (SWRevealViewController *) [self revealViewController];
    
    FrontViewController *frontViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"front"];
    ALPlayerViewController *downViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"player"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    //UINavigationController *navigationController2 = [[UINavigationController alloc] initWithRootViewController:downViewController];
    [revealController setFrontViewController:navigationController andDownViewController:downViewController animated:YES];
}

-(void)inicializarListaMusicasCompleto
{
    SWRevealViewController *revealController = (SWRevealViewController *) [self revealViewController];
    UINavigationController *navFront = (UINavigationController *) revealController.frontViewController;
    FrontViewController *frontVC = (FrontViewController *) navFront.topViewController;
    
    //AMLTableNowViewController *tableNowView = (AMLTableNowViewController* )[[self.storyboard instantiateViewControllerWithIdentifier:@"listaMusicalCompleta"] initWithPlayerMusic:(AMLPlayerRecomendacao *)revealController.downViewController andTitle:@"ListaMusical"];
    //tableNowView.navigationItem.title = @"Lista Musical Completa";
    //ALPlayerVC *aux = (ALPlayerVC *) revealController.downViewController;
    //[aux getDataIntermediaria];
    //[tableNowView.tableMusicas reloadData];
    [frontVC aivControllerFinalizar];
    //[navFront pushViewController: tableNowView animated:YES];
    
    
}

-(void)inicializarConfiguracoes
{
    SWRevealViewController *revealController = (SWRevealViewController *) [self revealViewController];
    
    UINavigationController *navFront = (UINavigationController *) revealController.frontViewController;
    
    FrontViewController *frontVC = (FrontViewController *) navFront.topViewController;
    
    ALConfiguracaoViewController *configVC = [[self.storyboard instantiateViewControllerWithIdentifier:@"configuracao"] initWithNomeUsuario:self.nomeUsuario];
    [frontVC aivControllerFinalizar];
    [navFront pushViewController: configVC animated:YES];
}


-(void)inicializarListaAlbuns
{
    SWRevealViewController *revealController = (SWRevealViewController *) [self revealViewController];
    
    UINavigationController *navFront = (UINavigationController *) revealController.frontViewController;
    
    FrontViewController *frontVC = (FrontViewController *) navFront.topViewController;
    
    ALPlayerViewController *playerVC = (ALPlayerViewController *) revealController.downViewController;
    
    //AMLAlbunsCollectionViewController *albunsCollection = [[self.storyboard instantiateViewControllerWithIdentifier:@"albunsCollection"] initWithPlayerVC:playerVC];
    
    //albunsCollection = [[AMLAlbunsCollectionViewController alloc] initWithPlayerVC:playerVC];
    
    AMLConnectionServlet *connectionServlet = [[AMLConnectionServlet alloc] init];
    
    //albunsCollection.listaAlbuns = connectionServlet.obterTodosAlbuns;
    [frontVC aivControllerFinalizar];
    //[navFront pushViewController: albunsCollection animated:YES];
}

@end
