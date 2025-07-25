% =====================================
% JOGO DE IDENTIFICAÇÃO DE PERSONAGENS
% =====================================

AUTOR: Daniel Angelo Rosa Morais 21.1.8128

% Base de dados de personagens
% Formato: personagem(Nome, TipoRealidade, LocalOrigem, [ListaAtributos])

personagem('Harry Potter', ficcional, 'Inglaterra', [mago, jovem, cicatriz, oculos, corajoso, estudante, masculino]).
personagem('Sherlock Holmes', ficcional, 'Inglaterra', [detetive, inteligente, observador, fumante, adulto, masculino]).
personagem('Albert Einstein', real, 'Alemanha', [cientista, genio, fisico, bigode, adulto, masculino]).
personagem('Wonder Woman', ficcional, 'Themyscira', [super_heroi, mulher, forte, imortal, guerreira, laco_da_verdade]).
personagem('Leonardo da Vinci', real, 'Italia', [artista, inventor, genio, renascentista, adulto, masculino]).
personagem('Hermione Granger', ficcional, 'Inglaterra', [bruxa, inteligente, estudante, leal, jovem, feminino]).
personagem('Napoleon Bonaparte', real, 'Franca', [imperador, militar, baixo, ambicioso, historico, masculino]).
personagem('Batman', ficcional, 'Gotham City', [super_heroi, rico, vigilante, sem_poderes, adulto, masculino]).
personagem('Marie Curie', real, 'Polonia', [cientista, fisica, quimica, nobel, determinada, feminino]).
personagem('Gandalf', ficcional, 'Terra Media', [mago, sabio, barba_branca, cajado, imortal, masculino]).
personagem('Cleopatra', real, 'Egito', [rainha, poderosa, bela, inteligente, historica, feminino]).
personagem('Spider-Man', ficcional, 'Nova York', [super_heroi, jovem, poderes_aranha, fotografo, masculino, responsavel]).
personagem('Isaac Newton', real, 'Inglaterra', [cientista, fisico, matematico, gravidade, genio, masculino]).
personagem('Katniss Everdeen', ficcional, 'Panem', [arqueira, corajosa, revolucionaria, jovem, feminino, sobrevivente]).
personagem('William Shakespeare', real, 'Inglaterra', [escritor, dramaturgo, poeta, genio_literario, adulto, masculino]).
personagem('Elsa', ficcional, 'Arendelle', [rainha, poderes_gelo, irmã, jovem, feminino, magica]).
personagem('Mahatma Gandhi', real, 'India', [lider, pacifico, independencia, magro, careca, masculino]).
personagem('Darth Vader', ficcional, 'Galaxia Star Wars', [sith, pai, respirador, espada_laser, vilao, masculino]).
personagem('Frida Kahlo', real, 'Mexico', [artista, pintora, autoretrato, sobrancelhas, ferida, feminino]).
personagem('Yoda', ficcional, 'Galaxia Star Wars', [jedi, mestre, pequeno, verde, sabio, masculino]).
personagem('Joana d Arc', real, 'Franca', [guerreira, santa, visionaria, jovem, corajosa, feminino]).
personagem('Iron Man', ficcional, 'Estados Unidos', [super_heroi, rico, inventor, armadura, genio, masculino]).

% Predicado principal para iniciar o jogo
startGame :-
    write('=== JOGO DE ADIVINHAÇÃO DE PERSONAGENS ==='), nl,
    write('Pense em um personagem e eu tentarei adivinhar!'), nl,
    write('Responda com "sim", "nao" ou "nao_sei".'), nl, nl,
    findall(P, personagem(P, _, _, _), TodosPersonagens),
    length(TodosPersonagens, Total),
    format('Tenho ~w personagens na minha base de dados.~n~n', [Total]),
    iniciarJogo(TodosPersonagens, 1, 10).

% Iniciar o jogo com lista de personagens candidatos
iniciarJogo(Candidatos, Pergunta, MaxPerguntas) :-
    length(Candidatos, NumCandidatos),
    (   NumCandidatos =< 0 ->
        write('Não consegui encontrar nenhum personagem! Vamos adicionar o seu.'), nl,
        adicionarNovoPersonagem
    ;   NumCandidatos =:= 1 ->
        Candidatos = [Personagem],
        format('É o personagem ~w?~n', [Personagem]),
        lerResposta(Resposta),
        (   Resposta = sim ->
            write('Ótimo! Consegui adivinhar!'), nl
        ;   write('Que estranho... Vamos adicionar seu personagem então.'), nl,
            adicionarNovoPersonagem
        )
    ;   Pergunta > MaxPerguntas ->
        write('Atingi o limite de perguntas! Você venceu!'), nl,
        write('Vamos adicionar seu personagem à minha base de dados.'), nl,
        adicionarNovoPersonagem
    ;   melhorPergunta(Candidatos, MelhorAtributo),
        format('Pergunta ~w: Seu personagem é ~w?~n', [Pergunta, MelhorAtributo]),
        lerResposta(Resposta),
        filtrarCandidatos(Candidatos, MelhorAtributo, Resposta, NovosCandidatos),
        ProximaPergunta is Pergunta + 1,
        iniciarJogo(NovosCandidatos, ProximaPergunta, MaxPerguntas)
    ).

% Ler resposta do usuário
lerResposta(Resposta) :-
    read(Input),
    (   Input = sim -> Resposta = sim
    ;   Input = nao -> Resposta = nao
    ;   Input = nao_sei -> Resposta = nao_sei
    ;   write('Responda apenas "sim", "nao" ou "nao_sei". Tente novamente: '),
        lerResposta(Resposta)
    ).

% Encontrar a melhor pergunta (atributo que melhor divide os candidatos)
melhorPergunta(Candidatos, MelhorAtributo) :-
    findall(Atributo, (
        member(Personagem, Candidatos),
        personagem(Personagem, _, _, Atributos),
        member(Atributo, Atributos)
    ), TodosAtributos),
    list_to_set(TodosAtributos, AtributosUnicos),
    findall(Score-Atributo, (
        member(Atributo, AtributosUnicos),
        calcularScore(Candidatos, Atributo, Score)
    ), Scores),
    sort(Scores, ScoresOrdenados),
    reverse(ScoresOrdenados, [_-MelhorAtributo|_]).

% Calcular score de um atributo (quão bem ele divide os candidatos)
calcularScore(Candidatos, Atributo, Score) :-
    length(Candidatos, Total),
    findall(P, (
        member(P, Candidatos),
        personagem(P, _, _, Atributos),
        member(Atributo, Atributos)
    ), ComAtributo),
    length(ComAtributo, NumCom),
    NumSem is Total - NumCom,
    (   NumCom =:= 0 ; NumSem =:= 0 ->
        Score = 0
    ;   Score is min(NumCom, NumSem)
    ).

% Filtrar candidatos baseado na resposta
filtrarCandidatos(Candidatos, Atributo, sim, NovosCandidatos) :-
    findall(P, (
        member(P, Candidatos),
        personagem(P, _, _, Atributos),
        member(Atributo, Atributos)
    ), NovosCandidatos).

filtrarCandidatos(Candidatos, Atributo, nao, NovosCandidatos) :-
    findall(P, (
        member(P, Candidatos),
        personagem(P, _, _, Atributos),
        \+ member(Atributo, Atributos)
    ), NovosCandidatos).

filtrarCandidatos(Candidatos, _, nao_sei, Candidatos).

% Adicionar novo personagem à base de dados
adicionarNovoPersonagem :-
    write('Qual é o nome do personagem? '),
    read(Nome),
    write('É um personagem real ou ficcional? (real/ficcional) '),
    read(Tipo),
    write('Qual é o local de origem? '),
    read(Local),
    write('Digite os atributos separados por vírgula (ex: [jovem, corajoso, mago]): '),
    read(Atributos),
    NovoPersonagem =.. [personagem, Nome, Tipo, Local, Atributos],
    assertz(NovoPersonagem),
    format('Personagem ~w adicionado com sucesso!~n', [Nome]),
    write('Obrigado por me ensinar algo novo!'), nl.

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

% Buscar personagem por atributo
buscarPorAtributo(Atributo) :-
    write('=== PERSONAGENS COM O ATRIBUTO: '), write(Atributo), write(' ==='), nl,
    personagem(Nome, Tipo, Local, Atributos),
    member(Atributo, Atributos),
    format('~w (~w, ~w)~n', [Nome, Tipo, Local]),
    fail.
buscarPorAtributo(_).

% Contar personagens
contarPersonagens(Total) :-
    findall(P, personagem(P, _, _, _), Personagens),
    length(Personagens, Total).

% Reiniciar jogo
jogarNovamente :-
    startGame.

% Instruções de uso
instrucoes :-
    write('=== INSTRUÇÕES DO JOGO ==='), nl,
    write('1. Digite "startGame." para iniciar o jogo'), nl,
    write('2. Pense em um personagem'), nl,
    write('3. Responda as perguntas com "sim.", "nao." ou "nao_sei."'), nl,
    write('4. O jogo tentará adivinhar em até 10 perguntas'), nl,
    write('5. Se não conseguir, você pode adicionar seu personagem'), nl, nl,
    % write('Outros comandos úteis:'), nl,
    % write('- listarPersonagens. (ver todos os personagens)'), nl,
    % write('- buscarPorAtributo(atributo). (buscar por atributo)'), nl,
    % write('- contarPersonagens(X). (contar personagens)'), nl,
    % write('- instrucoes. (ver estas instruções)'), nl.

% Mostrar instruções ao carregar
:- instrucoes.