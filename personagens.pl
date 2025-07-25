% =====================================
% BASE DE DADOS DE PERSONAGENS
% =====================================
% Autor: Daniel Angelo Rosa Morais 21.1.8128

% Formato: personagem(Nome, TipoRealidade, LocalOrigem, [ListaAtributos])

% PERSONAGENS FICCIONAIS
personagem('Harry Potter', ficcional, 'Inglaterra', [mago, jovem, cicatriz, oculos, corajoso, estudante, masculino]).
personagem('Hermione Granger', ficcional, 'Inglaterra', [bruxa, inteligente, estudante, leal, jovem, feminino]).
personagem('Gandalf', ficcional, 'Terra Media', [mago, sabio, barba_branca, cajado, imortal, masculino]).
personagem('Sherlock Holmes', ficcional, 'Inglaterra', [detetive, inteligente, observador, fumante, adulto, masculino]).
personagem('Wonder Woman', ficcional, 'Themyscira', [super_heroi, mulher, forte, imortal, guerreira, laco_da_verdade]).
personagem('Batman', ficcional, 'Gotham City', [super_heroi, rico, vigilante, sem_poderes, adulto, masculino]).
personagem('Spider-Man', ficcional, 'Nova York', [super_heroi, jovem, poderes_aranha, fotografo, masculino, responsavel]).
personagem('Katniss Everdeen', ficcional, 'Panem', [arqueira, corajosa, revolucionaria, jovem, feminino, sobrevivente]).
personagem('Elsa', ficcional, 'Arendelle', [rainha, poderes_gelo, irma, jovem, feminino, magica]).
personagem('Darth Vader', ficcional, 'Galaxia Star Wars', [sith, pai, respirador, espada_laser, vilao, masculino]).
personagem('Yoda', ficcional, 'Galaxia Star Wars', [jedi, mestre, pequeno, verde, sabio, masculino]).
personagem('Iron Man', ficcional, 'Estados Unidos', [super_heroi, rico, inventor, armadura, genio, masculino]).

% PERSONAGENS HISTÓRICOS/REAIS
personagem('Albert Einstein', real, 'Alemanha', [cientista, genio, fisico, bigode, adulto, masculino]).
personagem('Leonardo da Vinci', real, 'Italia', [artista, inventor, genio, renascentista, adulto, masculino]).
personagem('Napoleon Bonaparte', real, 'Franca', [imperador, militar, baixo, ambicioso, historico, masculino]).
personagem('Marie Curie', real, 'Polonia', [cientista, fisica, quimica, nobel, determinada, feminino]).
personagem('Cleopatra', real, 'Egito', [rainha, poderosa, bela, inteligente, historica, feminino]).
personagem('Isaac Newton', real, 'Inglaterra', [cientista, fisico, matematico, gravidade, genio, masculino]).
personagem('William Shakespeare', real, 'Inglaterra', [escritor, dramaturgo, poeta, genio_literario, adulto, masculino]).
personagem('Mahatma Gandhi', real, 'India', [lider, pacifico, independencia, magro, careca, masculino]).
personagem('Frida Kahlo', real, 'Mexico', [artista, pintora, autoretrato, sobrancelhas, ferida, feminino]).
personagem('Joana d Arc', real, 'Franca', [guerreira, santa, visionaria, jovem, corajosa, feminino]).

% Predicados auxiliares para consultar a base de dados
listarPersonagens :-
    write('=== PERSONAGENS NA BASE DE DADOS ==='), nl,
    personagem(Nome, Tipo, Local, Atributos),
    format('Nome: ~w~n', [Nome]),
    format('Tipo: ~w~n', [Tipo]),
    format('Local: ~w~n', [Local]),
    format('Atributos: ~w~n~n', [Atributos]),
    fail.
listarPersonagens.

buscarPorAtributo(Atributo) :-
    write('=== PERSONAGENS COM O ATRIBUTO: '), write(Atributo), write(' ==='), nl,
    personagem(Nome, Tipo, Local, Atributos),
    member(Atributo, Atributos),
    format('~w (~w, ~w)~n', [Nome, Tipo, Local]),
    fail.
buscarPorAtributo(_).

contarPersonagens(Total) :-
    findall(P, personagem(P, _, _, _), Personagens),
    length(Personagens, Total).

buscarPorTipo(Tipo) :-
    format('=== PERSONAGENS ~w ===~n', [Tipo]),
    personagem(Nome, Tipo, Local, _),
    format('~w (~w)~n', [Nome, Local]),
    fail.
buscarPorTipo(_).

buscarPorLocal(Local) :-
    format('=== PERSONAGENS DE ~w ===~n', [Local]),
    personagem(Nome, Tipo, Local, _),
    format('~w (~w)~n', [Nome, Tipo]),
    fail.
buscarPorLocal(_).