//
//  ALControllerCS.m
//  WaveMusic
//
//  Created by Alan Magalhães Lira on 03/12/13.
//  Copyright (c) 2013 Alan Magalhães Lira. All rights reserved.
//

#import "ALControllerCS.h"

@implementation ALControllerCS

-(NSMutableArray *)getData
{
    AMLConnectionServlet *connectionServlet = [[AMLConnectionServlet alloc] init];
    NSMutableArray *mArray = [connectionServlet obterTodasMusicas];
    return [[NSMutableArray alloc] initWithArray:mArray];
    
}

-(NSMutableArray *)getRecomendacaoPorUsuario:(NSString *)nomeUsu
{
    AMLConnectionServlet *connectionServlet = [[AMLConnectionServlet alloc] init];
    NSMutableArray *mArray = [connectionServlet obterRecomendacaoPorUsuario:nomeUsu];
    return [[NSMutableArray alloc] initWithArray:mArray];
    
}

-(NSMutableArray *)getDataIntermediaria
{
    AMLConnectionServlet *connectionServlet = [[AMLConnectionServlet alloc] init];
    NSMutableArray *mArray = [connectionServlet obterTodasMusicas];
    return [[NSMutableArray alloc] initWithArray:mArray];
    
}

-(NSMutableArray *)getDataAlbum:(NSString *)albumId
{
    NSLog(@"getDataAlbum");
    AMLConnectionServlet *connectionServlet = [[AMLConnectionServlet alloc] init];
    NSMutableArray *mArray = [connectionServlet obterTodasMusicasDoAlbum:albumId];
    return [[NSMutableArray alloc] initWithArray:mArray];
    
}


- (NSMutableArray *)albunSelecaoQuestionario {
    AMLConnectionServlet *cServlet = [[AMLConnectionServlet alloc] init];
    return cServlet.obterSelecaoParaQuestionario;
}


- (NSString *)getAlterarConfiguracaoKnn:(NSString*)knnk andNumGer:(NSString *)numGer andTamPop:(NSString *)tamPop andProbMut:(NSString *)probMut
{
    AMLConnectionServlet *connectionServlet = [[AMLConnectionServlet alloc] init];
    return [connectionServlet alterarConfiguracaoKnn:knnk andNumGer:numGer andTamPop:tamPop andProbMut:probMut];
}
- (NSMutableArray *)getObterConfiguracaoPorUsuario:(NSString *)usuario
{
    AMLConnectionServlet *connectionServlet = [[AMLConnectionServlet alloc] init];
    NSMutableArray *mArray = [connectionServlet obterConfiguracaoPorUsuario:usuario];
    return [[NSMutableArray alloc] initWithArray:mArray];
}

@end
