//
//  ALPayerViewController.m
//  WaveMusic
//
//  Created by Alan Magalhães Lira on 03/12/13.
//  Copyright (c) 2013 Alan Magalhães Lira. All rights reserved.
//

#import "ALPlayerViewController.h"
#import "ALControllerCS.h"
#import "SWRevealViewController.h"
#import "UIImage+ImageEffects.h"
#import "AudioPlayer.h"
#import "AMLTableDetailAlbumViewController.h"
#import "AMLTableNowViewController.h"

@interface ALPlayerViewController ()

-(void) setupTimer;
-(void) updateControls;

@end

@implementation ALPlayerViewController

@synthesize timeObserver, albumImage, volumeControl, labelAlbum, labelArtista, labelEstiloMusical, labelGravadora, labelMusica, timeSlider, title, imageBackground, playPauseButton, statusMusicLabel, controladorMusical, tocandoAgora, player, tableTocando;
@synthesize lMusicas, lMusicasAlbum, lMusicasRecomendadas, musicas;
@synthesize mainRevealController;

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
    
    //AudioPlayer
    currentUpdateTimer = nil;
    
    tumbImage= [UIImage imageNamed:@"screw-2x.png"];
    playImage = [UIImage imageNamed:@"player_play@2x.png"];
    pauseImage = [UIImage imageNamed:@"player_pause@2x.png"];
    [btListaQueue setImage:[UIImage imageNamed:@"player_queue_button"] forState:UIControlStateNormal];
    [btListaQueue setImage:[UIImage imageNamed:@"player_queue_button"] forState:UIControlStateHighlighted];
    [playPauseButton setImage:playImage forState:UIControlStateNormal];
    [playPauseButton setImage:playImage forState:UIControlStateHighlighted];
    [btListaQueue setHidden:YES];
    [btDetailAlbum setHidden:YES];
    self.controladorMusical = 0;
    
    positionSlider.continuous = YES;
    player = [[AudioPlayer alloc] init];
    player.delegate = self;
    [self setupTimer];
    [self updateControls];
}

- (void)alteracaoMusica
{
    
    musicas = [lMusicasRecomendadas objectAtIndex:controladorMusical];
    NSURL *musicUrl = [NSURL URLWithString:[[[musicas objectForKey:@"Musica"] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    
    //Mudar QueueItemId para MusicaId
    [player setDataSource:[player dataSourceFromURL:musicUrl] withQueueItemId:musicUrl];
    
    labelMusica.text = [NSString stringWithFormat:@"%@",[musicas objectForKey:@"nomeMusica"]];
    labelGravadora.text = [NSString stringWithFormat:@"%@",[musicas objectForKey:@"nomeGravadora"]];
    labelArtista.text = [NSString stringWithFormat:@"%@",[musicas objectForKey:@"nomeArtista"]];
    
    NSURL *url = [NSURL URLWithString:[[[musicas objectForKey:@"imgAlbum"] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *imageCapa = [[UIImage alloc] initWithData:data];
    
    albumImage.image = imageCapa;
    albumImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    albumImage.layer.masksToBounds = YES;
    //albumImage.layer.cornerRadius = 50.0;
    albumImage.layer.borderColor = [UIColor blackColor].CGColor;
    albumImage.layer.borderWidth = 0.3f;
    albumImage.layer.rasterizationScale = [UIScreen mainScreen].scale;
    albumImage.layer.shouldRasterize = YES;
    albumImage.clipsToBounds = YES;
    
    imageBackground.image = [imageCapa applyLightEffect];
    
    //[player setNumberOfLoops:0];
    positionSlider.maximumValue = player.duration;
    positionSlider.minimumValue = 0;
    
    //player.progress = 0;

    //controladorMusical ++;
}

//andK:(NSString *)knnK andTamPop:(NSString * )agTamPop andNumGera:(NSString *)agNumGer andProbMuta:(NSString *)agProbMuta
-(void)setListaRecomendacaoPorUsuario:(NSString *)nomeUsuario
{
    controladorMusical = 0;
    lMusicasRecomendadas = [[[ALControllerCS alloc] init] getRecomendacaoPorUsuario:nomeUsuario];
    [self alteracaoMusica];
    //[self playButtonPressed];
}

-(void)setListaDataAlbum:(NSString *)albumId
{
    lMusicasAlbum = [[[ALControllerCS alloc] init] getDataAlbum:albumId];
}

- (IBAction)mostrarMusicasAlbum:(id)sender
{
    
}

- (IBAction)volumeDidChange:(UISlider *)slider
{
    //Handle the slider movement
    //[player setVolume:[slider value]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //Once the view has loaded then we can register to begin recieving controls and we can become the first responder
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //End recieving events
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

- (IBAction)togglePlayingState:(id)button
{
    NSLog(@"Apertei");
    //Handle the button pressing
    if (lMusicasRecomendadas.count==controladorMusical) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção !" message:@"É necessário iniciar a recomendação." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        //[self resetAudioPlayer];
    }else{
        [btListaQueue setHidden:NO];
        [btDetailAlbum setHidden:NO];
        [self playButtonPressed];
    }
}

- (IBAction)toggleNextMusic:(id)button
{
    NSLog(@"Next");
    //Handle the button pressing
    //player = nil;
    if (lMusicasRecomendadas.count==controladorMusical) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção !" message:@"É necessário iniciar a recomendação." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        //[self resetAudioPlayer];
    }else{
        [btListaQueue setHidden:NO];
        [btDetailAlbum setHidden:NO];
        if (controladorMusical<[lMusicasRecomendadas count]) {
        controladorMusical++;
        [self alteracaoMusica];
        [self playAudio];
        }
    }
}

- (IBAction)togglePrevMusic:(id)button
{
    NSLog(@"Prev");
    if (lMusicasRecomendadas.count==controladorMusical) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção !" message:@"É necessário iniciar a recomendação." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        //[self resetAudioPlayer];
    }else{
        [btListaQueue setHidden:NO];
        [btDetailAlbum setHidden:NO];
        if (controladorMusical>0) {
            controladorMusical--;
            [self alteracaoMusica];
            [self playAudio];
        }
    }
}

- (void)zerarLabels
{
    self.albumImage.image = nil;
    self.labelMusica.text = @"-----";
    self.labelArtista.text = @"-----";
    self.labelAlbum.text = @"-----";
    self.labelEstiloMusical.text = @"-----";
    self.labelGravadora.text = @"-----";
}

- (void)mudancaMusica
{
    if (player ==nil) {
        if ([lMusicasRecomendadas count] > controladorMusical) {
            [self zerarLabels];
            //NSError *error;
            [self alteracaoMusica];
            controladorMusical ++;
        }
    }
}

- (void)playAudio
{
    //Play the audio and set the button to represent the audio is paused
    if (!player)
	{
		return;
	} else {
        [playPauseButton setImage:pauseImage forState:UIControlStateNormal];
        [playPauseButton setImage:pauseImage forState:UIControlStateHighlighted];
        [player resume];
    }
}


- (void)pauseAudio
{
    //Pause the audio and set the button to represent the audio is paused
    if (!player)
	{
		return;
	} else {
        [playPauseButton setImage:playImage forState:UIControlStateNormal];
        [playPauseButton setImage:playImage forState:UIControlStateHighlighted];
        [player pause];
    
    }
}

- (void) resetAudioPlayer
{
    statusMusicLabel.text = @"iDiscover a definição de descoberta de músicas.";
    [self pauseAudio];
    [player stop];
    [self zerarLabels];
}

//Make sure we can recieve remote control events
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    //if it is a remote control event handle it correctly
    if (event.type == UIEventTypeRemoteControl) {
        if (event.subtype == UIEventSubtypeRemoteControlPlay) {
            [self playAudio];
        } else if (event.subtype == UIEventSubtypeRemoteControlPause) {
            [self pauseAudio];
        } else if (event.subtype == UIEventSubtypeRemoteControlTogglePlayPause) {
            [self playButtonPressed];
        }
    }
}

- (IBAction)changePosition:(id)sender
{
    [positionSlider addTarget:self action:@selector(sliderChanged) forControlEvents:UIControlEventValueChanged];
    soundLabel.text = [self updateLabel];
}

- (void)updateSlider
{
    if (player.progress<positionSlider.maximumValue) {
        [positionSlider setValue:player.progress];
        soundLabel.text = [self updateLabel];
    }
    
}

- (NSString *)conversorTempoMusica:(double)currentTime
{
    int minutes = floor(currentTime/60);
    int seconds = trunc(currentTime - minutes * 60);
    NSString *belowTen = [NSString stringWithFormat:@"%i:0%i" ,minutes,seconds];
    NSString *aboveTen = [NSString stringWithFormat:@"%i:%i" ,minutes,seconds];
    if (seconds < 10){
        return belowTen;
    }else{
        return aboveTen;
    }
}

- (NSString *)updateLabel
{
    double currentTime = player.progress;
    return [self conversorTempoMusica:currentTime];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma -AudioPlayer

-(void) sliderChanged
{
	if (!player)
	{
		return;
	}
	
	NSLog(@"Slider Changed: %f", positionSlider.value);
	
	[player seekToTime:positionSlider.value];
}

-(void) setupTimer
{
	currentUpdateTimer = [NSTimer timerWithTimeInterval:0.25 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    soundLabel.text = [self updateLabel];
	
	[[NSRunLoop currentRunLoop] addTimer:currentUpdateTimer forMode:NSRunLoopCommonModes];
}

-(void) tick
{
	if (!player || player.duration == 0)
	{
		positionSlider.value = 0;
		
		return;
	}
	
	positionSlider.minimumValue = 0;
	positionSlider.maximumValue = player.duration;
	
	positionSlider.value = player.progress;
    soundLabel.text = [self updateLabel];
    if ([[self conversorTempoMusica:player.progress] isEqualToString:[self conversorTempoMusica:player.duration]]) {
        NSLog(@"Próxima");
        [self toggleNextMusic:nil];
    }
}

-(void) playFromHTTPButtonTouched
{
	NSLog(@"Implementação direta.");
    //[self.delegate audioPlayerViewPlayFromHTTPSelected:self];
}

-(void) playFromLocalFileButtonTouched
{
    NSLog(@"Não implementado ainda.");
	//[self.delegate audioPlayerViewPlayFromLocalFileSelected:self];
}

-(void) playButtonPressed
{
	if (!player)
	{
		return;
	}
	
	if (player.state == AudioPlayerStatePaused)
	{
		[player resume];
	}
	else
	{
		[player pause];
	}
}

-(void) updateControls
{
	if (player == nil)
	{
		[self.playPauseButton setImage:playImage forState:UIControlStateNormal];
        [self.playPauseButton setImage:playImage forState:UIControlStateHighlighted];
        
	}
	else if (player.state == AudioPlayerStatePaused)
	{
		[self.playPauseButton setImage:playImage forState:UIControlStateNormal];
        [self.playPauseButton setImage:playImage forState:UIControlStateHighlighted];
         
	}
	else if (player.state == AudioPlayerStatePlaying)
	{
		[self.playPauseButton setImage:pauseImage forState:UIControlStateNormal];
        [self.playPauseButton setImage:pauseImage forState:UIControlStateHighlighted];
        
	}
	else
	{
		[self.playPauseButton setImage:playImage forState:UIControlStateNormal];
        [self.playPauseButton setImage:playImage forState:UIControlStateHighlighted];
        
	}
}

-(void) setAudioPlayer:(AudioPlayer*)value
{
	if (player)
	{
		player.delegate = nil;
	}
    
	player = value;
	player.delegate = self;
	
	[self updateControls];
}

-(AudioPlayer*) audioPlayer
{
	return player;
}

-(void) audioPlayer:(AudioPlayer*)audioPlayer stateChanged:(AudioPlayerState)state
{
	[self updateControls];
}

-(void) audioPlayer:(AudioPlayer*)audioPlayer didEncounterError:(AudioPlayerErrorCode)errorCode
{
	[self updateControls];
}

-(void) audioPlayer:(AudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId
{
	[self updateControls];
}

-(void) audioPlayer:(AudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId
{
	[self updateControls];
}

-(void) audioPlayer:(AudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(AudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration
{
	[self updateControls];
}



//Player
- (IBAction)playingNow:(id)sender {
    NSLog(@"PlayingNow");
    [self performSelector:@selector(playingNow) withObject:nil afterDelay:0.15];
}

- (void)playingNow
{
    NSLog(@"ChamadaTableViewPlayingNow");
    UINavigationController *navFront = (UINavigationController*) self.mainRevealController.frontViewController;
    /*AMLTableNowViewController */tableTocando = [[self.storyboard instantiateViewControllerWithIdentifier:@"playingNow"] initWithPlayerMusic:self andTitle:@"Tocando"];
    
    if (![navFront.topViewController.title  isEqual: @"Tocando Agora"]) {
        tableTocando.navigationItem.title = @"Tocando Agora";
        [navFront pushViewController: tableTocando animated:YES];
    } else {
        NSLog(@"Não faz nada.");
    }
}

- (IBAction)detailAlbum:(id)sender
{
    NSLog(@"DetailAlbum");
    UINavigationController *navFront = (UINavigationController*) self.mainRevealController.frontViewController;
    [self setListaDataAlbum:[musicas objectForKey:@"idAlbum"]];
    AMLTableDetailAlbumViewController *tableDetail = [[self.storyboard instantiateViewControllerWithIdentifier:@"listaMusicalAlbum"] initWithPlayerMusic:self andTitle:@"" andAlbumId:[musicas objectForKey:@"idAlbum"]];
    if (![navFront.topViewController.title  isEqual: @"Músicas"]) {
        tableDetail.navigationItem.title = @"Músicas";
        [navFront pushViewController: tableDetail animated:YES];
    } else {
        NSLog(@"Não faz nada.");
    }
    
}


@end
