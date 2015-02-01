//
//  ALPayerViewController.h
//  WaveMusic
//
//  Created by Alan Magalhães Lira on 03/12/13.
//  Copyright (c) 2013 Alan Magalhães Lira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioPlayer.h"
#import "AMLTableNowViewController.h"

@class SWRevealViewController;
@class AudioPlayerView;

@protocol AudioPlayerViewDelegate<NSObject>
-(void) audioPlayerViewPlayFromHTTPSelected:(AudioPlayerView*)audioPlayerView;
-(void) audioPlayerViewPlayFromLocalFileSelected:(AudioPlayerView*)audioPlayerView;
@end

@interface ALPlayerViewController : UIViewController <AudioPlayerDelegate>
{
    IBOutlet UIButton *playPauseButton; //Botão de Play/Pause
    IBOutlet UISlider *volumeControl; //Volume do audio player
    IBOutlet UILabel *statusMusicLabel; //Label que mostra o status da música do momento
    IBOutlet UILabel *soundLabel; //Label que mostra os minutos da música
    __weak IBOutlet UIImageView *imageBackground;
    IBOutlet UIImageView *albumImage; //Imagem da capa do Album
    IBOutlet UIButton *btDetailAlbum;
    NSMutableArray *returnConnectionList;
    UIImage *tumbImage; //Imagem do ponteiro do Slider
    UIImage *playImage; //Imagem do botão Play
    UIImage *pauseImage; //Imagem do botão Pause
    AMLTableNowViewController *tableTocando;
    NSMutableArray *lMusicas; //Lista de Músicas Recomendadas
    NSMutableArray *lMusicasRecomendadas; //Lista de Músicas do player
    NSMutableArray *lMusicasAlbum; //Lista de Músicas do Albúm
    NSString *tocandoAgora;
    __weak IBOutlet UIButton *btListaQueue;
    int controladorMusical;

@private
    IBOutlet UISlider *positionSlider; //Posição da música
    NSTimer *currentUpdateTimer; //Controle dos segundos (tempo)
}

@property (readwrite, retain) AudioPlayer* player;
@property (readwrite, unsafe_unretained) id<AudioPlayerViewDelegate> delegate;

@property (nonatomic, strong) id timeObserver;
@property (nonatomic, retain) NSMutableArray *lMusicasRecomendadas; //Lista de Músicas Recomendadas
@property (weak, nonatomic) IBOutlet UIImageView *imageBackground;
@property (nonatomic, retain) NSMutableArray *lMusicas; //Lista de Músicas Recomendadas
@property (nonatomic, retain) NSMutableArray *lMusicasAlbum; //Lista de Músicas Recomendadas
@property (nonatomic, retain) NSString *tocandoAgora;
@property (nonatomic) int controladorMusical;
@property (strong, nonatomic) AMLTableNowViewController *tableTocando;
@property (strong, nonatomic) SWRevealViewController *mainRevealController;
@property (strong, nonatomic) IBOutlet UILabel *labelAlbum;
@property (strong, nonatomic) IBOutlet UILabel *labelEstiloMusical;
@property (strong, nonatomic) IBOutlet UILabel *labelArtista;
@property (strong, nonatomic) IBOutlet UILabel *labelMusica;
@property (strong, nonatomic) IBOutlet UILabel *labelGravadora;
@property (nonatomic, retain) IBOutlet UIButton *playPauseButton;
@property (nonatomic, retain) IBOutlet UISlider *volumeControl;
@property (nonatomic, retain) IBOutlet UILabel *statusMusicLabel;
@property (nonatomic, retain) IBOutlet UIImageView *albumImage;
@property (nonatomic, retain) UISlider *timeSlider;
@property (nonatomic, retain) NSDictionary *musicas;


- (void)setListaRecomendacaoPorUsuario:(NSString *)nomeUsuario;
- (void)setListaDataAlbum:(NSString *)albumId;


- (IBAction)playingNow:(id)sender;
- (IBAction)volumeDidChange:(id)slider; //Controle do movimento do Slider de volume
- (IBAction)togglePlayingState:(id)button; //Clique do botão Play/Pause
- (IBAction)toggleNextMusic:(id)button;
- (IBAction)togglePrevMusic:(id)button;
- (IBAction)changePosition:(id)sender; //Controle do movimento do Slider da posição da música
- (void)updateSlider; //Atualiza a posição do slider com o decorrer do audio tocado
- (void)playButtonPressed;
- (NSString *)updateLabel; //Atualiza por segundo o status da Label de minutos da música
- (IBAction)detailAlbum:(id)sender;



@end
