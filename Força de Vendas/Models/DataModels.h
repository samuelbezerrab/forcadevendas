//
//  DataModels.h
//  Força de Vendas
//
//  Created by Samuel Bispo on 21/05/15.
//
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@class Cliente;
@class Telefone;
@class Endereco;

@class ProcessoDeVenda;
@class EstagioDeProcessoDeVenda;
@class ObservacaoDeProcessoDeVenda;

// Cliente Model
@interface Cliente : RLMObject

@property NSString *nome;
@property NSString *nomePessoaDeContato;
@property NSString *apelidoPessoaDeContato;
@property NSString *email;
@property NSString *observacao;

@property Telefone *telefone;
@property Endereco *endereco;

@end
RLM_ARRAY_TYPE(Cliente)

// Telefone Model
@interface Telefone : RLMObject

@property Cliente *cliente;
@property NSString *ddd;
@property NSString *numero;

@end
RLM_ARRAY_TYPE(Telefone)

//Endereço Model
@interface Endereco : RLMObject

@property Cliente *cliente;
@property NSString *logradouro;
@property NSString *numero;
@property NSString *referencia;
@property NSString *bairro;
@property NSString *cidade;
@property NSString *estado;
@property NSString *pais;

@end
RLM_ARRAY_TYPE(Endereco)


// Parte de venda

// Processo de Venda Model
@interface ProcessoDeVenda : RLMObject

@property Cliente *cliente;
@property EstagioDeProcessoDeVenda *estagio;

@property NSDate *dataInicio;

@property float valorProposta;
@property float valorFechado;


@end

// Estagio de Processo de Venda Model
@interface EstagioDeProcessoDeVenda : RLMObject

@property int ordenacao;
@property NSString *nome;

@end

// Observacao de Processo de Venda Model
@interface ObservacaoDeProcessoDeVenda : RLMObject

@property NSString *texto;

@end
