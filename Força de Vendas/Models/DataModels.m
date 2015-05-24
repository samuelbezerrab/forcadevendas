//
//  DataModels.m
//  Força de Vendas
//
//  Created by Samuel Bispo on 21/05/15.
//
//

#import "DataModels.h"

@implementation Cliente
+ (NSDictionary *)defaultPropertyValues {
    return @{@"dataCadastro" : [NSDate date]};
}
@end

@implementation Telefone
@end

@implementation Endereco
@end

@implementation ProcessoDeVenda
@end

@implementation ObservacaoDeProcessoDeVenda
@end

@implementation EstagioDeProcessoDeVenda
@end



