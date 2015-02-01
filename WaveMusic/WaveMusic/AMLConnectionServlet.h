//
//  AMLConnectionServlet.h
//  BrainMusic
//
//  Created by Alan Magalhães Lira on 21/08/13.
//  Copyright (c) 2013 Alan M. Lira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMLConnectionServlet : NSObject

- (NSString *)obterPermissaoLogin:(NSString*)login andSenha:(NSString *)senha;
- (NSString *)criarUsuario:(NSString*)login andSenha:(NSString *)senha;
- (NSString *)alterarConfiguracaoKnn:(NSString*)knnk andNumGer:(NSString *)numGer andTamPop:(NSString *)tamPop andProbMut:(NSString *)probMut;
- (NSMutableArray *)obterConfiguracaoPorUsuario:(NSString *)usuario;
- (NSMutableArray *)obterTodasMusicas;
- (NSMutableArray *)obterTodosAlbuns;
- (NSMutableArray *)obterTodasMusicasDoAlbum:(NSString *)albumID;
- (NSMutableArray *)obterSelecaoParaQuestionario;
- (NSMutableArray *)criarPontuacaoPorUsuario:(NSString *)usuario andPontuacao:(NSString *)pontuacao;
- (NSMutableArray *)obterRecomendacaoPorUsuario:(NSString *)usuario;
- (NSString *)obterPontuacao:(NSString*)login;

@end
