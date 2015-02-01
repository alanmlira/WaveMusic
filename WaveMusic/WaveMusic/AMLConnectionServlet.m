//
//  AMLConnectionServlet.m
//  BrainMusic
//
//  Created by Alan Magalhães Lira on 21/08/13.
//  Copyright (c) 2013 Alan M. Lira. All rights reserved.
//

#import "AMLConnectionServlet.h"

@implementation AMLConnectionServlet
{
    NSString *caminho;
}

- (id)init {
    //caminho = @"http://localhost:8080";
    caminho = @"http://lacibufra.net";
    return self;
}

-(NSString *)obterPermissaoLogin:(NSString*)login andSenha:(NSString *)senha
{
    //NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"http://localhost:8080/LacibMusic/LacibMusicServlet?controlador=login&user=%@&pass=%@",login,senha];
    NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"%@/LacibMusic/LacibMusicServlet?controlador=login&user=%@&pass=%@",caminho,login,senha];
    
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    //NSError *error = nil;
    
    //NSMutableArray *x = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSStringEncodingConversionAllowLossy];
    return result;
}

-(NSString *)obterPontuacao:(NSString*)login
{
    NSLog(@"obterPontuacao");
    //NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"http://localhost:8080/LacibMusic/LacibMusicServlet?controlador=login&user=%@",login];
    NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"%@/LacibMusic/LacibMusicServlet?controlador=obterPontuacaoPerfil&user=%@",caminho,login];
    
    NSLog(@"str: %@",strURL);
    
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    //NSError *error = nil;
    
    //NSMutableArray *x = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSStringEncodingConversionAllowLossy];
    NSLog(@"result: %@",result);
    return result;
}

-(NSString *)criarUsuario:(NSString*)login andSenha:(NSString *)senha
{
    //NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"http://localhost:8080/LacibMusic/LacibMusicServlet?controlador=createLogin&user=%@&pass=%@",login,senha];
    NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"%@/LacibMusic/LacibMusicServlet?controlador=createLogin&user=%@&pass=%@",caminho,login,senha];
    
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    //NSError *error = nil;
    
    //NSMutableArray *x = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSStringEncodingConversionAllowLossy];
    return result;
}

- (NSString *)alterarConfiguracaoKnn:(NSString*)knnk andNumGer:(NSString *)numGer andTamPop:(NSString *)tamPop andProbMut:(NSString *)probMut
{
    //NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"http://localhost:8080/LacibMusic/LacibMusicServlet?controlador=createLogin&user=%@&pass=%@",login,senha];
    NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"%@/LacibMusic/LacibMusicServlet?controlador=createLogin&knnk=%@&tamPop=%@&numGer=%@&probMut=%@",caminho,knnk,tamPop,numGer,probMut];
    
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    //NSError *error = nil;
    
    //NSMutableArray *x = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSStringEncodingConversionAllowLossy];
    return result;
}


-(NSMutableArray *)obterTodasMusicas
{
    //NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"http://localhost:8080/LacibMusic/LacibMusicServlet?controlador=listaMusicas"];
    NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"%@/LacibMusic/LacibMusicServlet?controlador=listaMusicas",caminho];
    
    NSError *error = nil;
    
    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:strURL] encoding:NSISOLatin1StringEncoding error:&error];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    id res = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSLog(@"Lista: \n%@",res);
    
    NSMutableArray *resultado = res;
    
    return resultado;
}

-(NSMutableArray *)obterRecomendacaoPorUsuario:(NSString *)usuario
{
    //NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"http://localhost:8080/LacibMusic/LacibMusicServlet?controlador=recomendacaoUsuario&user=%@&knnK=%@&agTamPop=%@&agNumGer=%@&agProbMuta=%@",usuario, knnK, agTamPop, agNumGer, agProbMuta];
    NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"%@/LacibMusic/LacibMusicServlet?controlador=recomendacaoUsuario&user=%@",caminho,usuario];
    
    NSError *error = nil;
    
    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:strURL] encoding:NSISOLatin1StringEncoding error:&error];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    id res = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSLog(@"Lista: \n%@",res);
    
    NSMutableArray *resultado = res;
    
    return resultado;
}

-(NSMutableArray *)obterTodasMusicasDoAlbum:(NSString *)albumID
{
    //NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"http://localhost:8080/LacibMusic/LacibMusicServlet?controlador=musicasDoAlbum&albumID=%@",albumID];
    NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"%@/LacibMusic/LacibMusicServlet?controlador=musicasDoAlbum&albumID=%@",caminho,albumID];
    
    NSError *error = nil;
    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:strURL] encoding:NSISOLatin1StringEncoding error:&error];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    id res = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSMutableArray *resultado = res;    return resultado;
}

-(NSMutableArray *)obterTodosAlbuns
{
    //NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"http://localhost:8080/LacibMusic/LacibMusicServlet?controlador=imagemAlbum"];
    NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"%@/LacibMusic/LacibMusicServlet?controlador=imagemAlbum",caminho];
    NSError *error = nil;
    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:strURL] encoding:NSUTF8StringEncoding error:&error];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"data: %@",data);
    id res = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSMutableArray *resultado = res;
    NSLog(@"res: %@",res);
    
    return resultado;
}

-(NSMutableArray *)obterConfiguracaoPorUsuario:(NSString *)usuario
{
    //NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"http://localhost:8080/LacibMusic/LacibMusicServlet?controlador=imagemAlbum"];
    NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"%@/LacibMusic/LacibMusicServlet?controlador=obterConfiguracao&user=%@",caminho,usuario];
    NSError *error = nil;
    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:strURL] encoding:NSUTF8StringEncoding error:&error];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"data: %@",data);
    id res = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSMutableArray *resultado = res;
    NSLog(@"res: %@",res);
    
    return resultado;
}

-(NSMutableArray *)obterSelecaoParaQuestionario
{
    //NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"http://localhost:8080/LacibMusic/LacibMusicServlet?controlador=questionarioGeneros"];
    NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"%@/LacibMusic/LacibMusicServlet?controlador=questionarioGeneros",caminho];
    NSError *error = nil;
    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:strURL] encoding:NSASCIIStringEncoding error:&error];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    id res = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSMutableArray *resultado = res;
    
    return resultado;
}

-(NSMutableArray *)criarPontuacaoPorUsuario:(NSString *)usuario andPontuacao:(NSString *)pontuacao
{
    //NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"http://localhost:8080/LacibMusic/LacibMusicServlet?controlador=createPontuacao&user=%@&pont=%@",usuario,pontuacao];
    NSMutableString *strURL = [[NSMutableString alloc] initWithFormat:@"%@/LacibMusic/LacibMusicServlet?controlador=createPontuacao&user=%@&pont=%@",caminho,usuario,pontuacao];
    NSError *error = nil;
    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:strURL] encoding:NSISOLatin1StringEncoding error:&error];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"data: %@",data);
    id res = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSMutableArray *resultado = res;
    //NSLog(@"res: %@",res);
    
    return resultado;
}

@end
