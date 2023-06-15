camisa(amarela).
camisa(azul).
camisa(branca).
camisa(verde).
camisa(vermelha).

nome(celso).
nome(geraldo).
nome(marcelo).
nome(pedro).
nome(ricardo).

cargo(analista).
cargo(caixa).
cargo(estagiario).
cargo(gerente).
cargo(trainee).

ferias(janeiro).
ferias(fevereiro).
ferias(julho).
ferias(setembro).
ferias(dezembro).

lanche(banana).
lanche(bolacha).
lanche(maca).
lanche(salgadinho).
lanche(sanduiche).

suco(caju).
suco(laranja).
suco(limao).
suco(maracuja).
suco(uva).

% X está à ao lado de Y
aoLado(X,Y,Lista) :- nextto(X,Y,Lista);nextto(Y,X,Lista).
                       
% X está à esquerda de Y (em qualquer posição à esquerda)
aEsquerda(X,Y,Lista) :- nth0(IndexX,Lista,X), 
                        nth0(IndexY,Lista,Y), 
                        IndexX < IndexY.
                        
% X está à direita de Y (em qualquer posição à direita)
aDireita(X,Y,Lista) :- aEsquerda(Y,X,Lista). 

% X está no canto se ele é o primeiro ou o último da lista
noCanto(X,Lista) :- last(Lista,X).
noCanto(X,[X|_]).

todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)), todosDiferentes(T).

solucao(ListaFunc) :-

    ListaFunc = [
        funcionario(Camisa1, Nome1, Cargo1, Ferias1, Lanche1, Suco1),
        funcionario(Camisa2, Nome2, Cargo2, Ferias2, Lanche2, Suco2),
        funcionario(Camisa3, Nome3, Cargo3, Ferias3, Lanche3, Suco3),
        funcionario(Camisa4, Nome4, Cargo4, Ferias4, Lanche4, Suco4),
        funcionario(Camisa5, Nome5, Cargo5, Ferias5, Lanche5, Suco5)
    ],

    % Ricardo está na quinta posição.
    Nome5 = ricardo,

    % Na quarta posição está o Caixa.
    Cargo4 = caixa,

    % Na primeira posição está o homem que está comendo um Sanduíche.
    Lanche1 = sanduiche,

    % Em uma das pontas está o homem que está comendo um Salgadinho.
    noCanto(funcionario(_, _, _, _, salgadinho, _), ListaFunc),

    % O Estagiário está ao lado do Gerente.
    aoLado(funcionario(_, _, estagiario, _, _, _), funcionario(_, _, gerente, _, _, _), ListaFunc),

    % Marcelo está ao lado do homem de camisa Branca.
    aoLado(funcionario(_, marcelo, _, _, _, _), funcionario(branca, _, _, _, _, _), ListaFunc),

    % O funcionário de camisa Azul está comendo uma Maçã.
    member(funcionario(azul, _, _, _, maca, _), ListaFunc),

    % Pedro está ao lado do funcionário que está bebendo suco de Caju.
    aoLado(funcionario(_, pedro, _, _, _, _), funcionario(_, _, _, _, _, caju), ListaFunc),

    % Quem geralmente tira férias em Janeiro está ao lado de quem está bebendo suco de Limão.
    aoLado(funcionario(_, _, _, janeiro, _, _), funcionario(_, _, _, _, _, limao), ListaFunc),

    % O Gerente está em algum lugar à direita do funcionário de camisa Vermelha.
    aDireita(funcionario(_, _, gerente, _, _, _), funcionario(vermelha, _, _, _, _, _), ListaFunc),

    % O Caixa está ao lado do funcionário que geralmente tira férias em Julho.
    aoLado(funcionario(_, _, caixa, _, _, _), funcionario(_, _, _, julho, _, _), ListaFunc),

    % Geraldo está ao lado do funcionário que está bebendo suco de Caju.
    aoLado(funcionario(_, geraldo, _, _, _, _), funcionario(_, _, _, _, _, caju), ListaFunc),

    % O Analista está exatamente à esquerda do homem que está comendo uma Bolacha.
    aEsquerda(funcionario(_, _, analista, _, _, _), funcionario(_, _, _, _, bolacha, _), ListaFunc),
    aoLado(funcionario(_, _, analista, _, _, _), funcionario(_, _, _, _, bolacha, _), ListaFunc),

    % O homem que está comendo uma Bolacha está exatamente à esquerda do homem que está bebendo suco de Laranja.
    aEsquerda(funcionario(_, _, _, _, bolacha, _), funcionario(_, _, _, _, _, laranja), ListaFunc),
    aoLado(funcionario(_, _, _, _, bolacha, _), funcionario(_, _, _, _, _, laranja), ListaFunc),

    % O funcionário que geralmente tira férias em Dezembro está exatamente 
    % à direita do funcionário que está bebendo suco de Uva.
    aDireita(funcionario(_, _, _, dezembro, _, _), funcionario(_, _, _, _, _, uva), ListaFunc),
    aoLado(funcionario(_, _, _, dezembro, _, _), funcionario(_, _, _, _, _, uva), ListaFunc),

    % Quem está bebendo suco de Uva está em algum lugar entre quem está comendo um Sanduíche 
    % e quem está bebendo suco de Limão, nessa ordem.
    aDireita(funcionario(_, _, _, _, _, uva), funcionario(_, _, _, _, sanduiche, _), ListaFunc),
    aEsquerda(funcionario(_, _, _, _, _, uva), funcionario(_, _, _, _, _, limao),ListaFunc),

    % O homem que normalmente tira férias em Setembro está em algum lugar entre 
    % o Geraldo e o homem que está comendo uma Maçã, nessa ordem.
    aDireita(funcionario(_, _, _, setembro, _, _), funcionario(_, geraldo, _, _, _, _), ListaFunc),
    aEsquerda(funcionario(_, _, _, setembro, _, _), funcionario(_, _, _, _, maca, _), ListaFunc),

    % O Gerente está em algum lugar entre o homem de Amarelo e o homem que está comendo uma Banana, nessa ordem.
    aDireita(funcionario(_, _, gerente, _, _, _), funcionario(amarela, _, _, _, _, _), ListaFunc),
    aEsquerda(funcionario(_, _, gerente, _, _, _), funcionario(_, _, _, _, banana, _), ListaFunc),

    % O funcionário de Vermelho está em algum lugar entre o Geraldo e 
    % o funcionário que normalmente tira férias em Janeiro, nessa ordem.
    aDireita(funcionario(vermelha, _, _, _, _, _), funcionario(_, geraldo, _, _, _, _), ListaFunc),
    aEsquerda(funcionario(vermelha, _, _, _, _, _), funcionario(_, _, _, janeiro, _, _), ListaFunc),

    % Testa todas as possibilidades...
    camisa(Camisa1), camisa(Camisa2), camisa(Camisa3), camisa(Camisa4), camisa(Camisa5),
    todosDiferentes([Camisa1, Camisa2, Camisa3, Camisa4, Camisa5]),
    
    nome(Nome1), nome(Nome2), nome(Nome3), nome(Nome4), nome(Nome5),
    todosDiferentes([Nome1, Nome2, Nome3, Nome4, Nome5]),
    
    cargo(Cargo1), cargo(Cargo2), cargo(Cargo3), cargo(Cargo4), cargo(Cargo5),
    todosDiferentes([Cargo1, Cargo2, Cargo3, Cargo4, Cargo5]),
    
    ferias(Ferias1), ferias(Ferias2), ferias(Ferias3), ferias(Ferias4), ferias(Ferias5),
    todosDiferentes([Ferias1, Ferias2, Ferias3, Ferias4, Ferias5]),
    
    lanche(Lanche1), lanche(Lanche2), lanche(Lanche3), lanche(Lanche4), lanche(Lanche5),
    todosDiferentes([Lanche1, Lanche2, Lanche3, Lanche4,Lanche5]),

    suco(Suco1), suco(Suco2), suco(Suco3), suco(Suco4), suco(Suco5),
    todosDiferentes([Suco1, Suco2, Suco3, Suco4, Suco5]).

