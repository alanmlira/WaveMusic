//
//  ALControllerCS.h
//  WaveMusic
//
//  Created by Alan Magalhães Lira on 03/12/13.
//  Copyright (c) 2013 Alan Magalhães Lira. All rights reserved.
//

#import "AMLConnectionServlet.h"

@interface ALControllerCS : AMLConnectionServlet {
    
}

//andK:(NSString *)knnK andTamPop:(NSString * )agTamPop andNumGera:(NSString *)agNumGer andProbMuta:(NSString *)agProbMuta

- (NSMutableArray *)getData;
- (NSMutableArray *)getRecomendacaoPorUsuario:(NSString *)nomeUsu;
- (NSMutableArray *)getDataIntermediaria;
- (NSMutableArray *)getDataAlbum:(NSString *)albumId;
- (NSString *)getAlterarConfiguracaoKnn:(NSString*)knnk andNumGer:(NSString *)numGer andTamPop:(NSString *)tamPop andProbMut:(NSString *)probMut;
- (NSMutableArray *)getObterConfiguracaoPorUsuario:(NSString *)usuario;
- (NSMutableArray *)albunSelecaoQuestionario;

@end
