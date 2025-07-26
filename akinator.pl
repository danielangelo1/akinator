% =====================================
% JOGO DE IDENTIFICAÇÃO DE PERSONAGENS
% =====================================
% AUTOR: Daniel Angelo Rosa Morais 21.1.8128

% Carrega a base de dados de personagens
:- include('personagens.pl').

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
    ;   Pergunta > MaxPerguntas ->
        write('Atingi o limite de perguntas! Você venceu!'), nl,
        (   NumCandidatos =:= 1 ->
            Candidatos = [UltimoPersonagem],
            format('Meu melhor palpite seria: ~w~n', [UltimoPersonagem]),
            write('Mas vou adicionar seu personagem mesmo assim.'), nl
        ;   write('Vamos adicionar seu personagem à minha base de dados.'), nl
        ),
        adicionarNovoPersonagem
    ;   NumCandidatos =:= 1 ->
        Candidatos = [Personagem],
        format('É o personagem ~w?~n', [Personagem]),
        lerResposta(Resposta),
        (   Resposta = sim ->
            write('Ótimo! Consegui adivinhar!'), nl
        ;   Resposta = nao ->
            write('Interessante... Deixe-me fazer mais algumas perguntas.'), nl,
            % Criar lista vazia para forçar o sistema a continuar explorando
            iniciarJogo([], Pergunta, MaxPerguntas)
        ;   % nao_sei - continue com o candidato
            ProximaPergunta is Pergunta + 1,
            iniciarJogo(Candidatos, ProximaPergunta, MaxPerguntas)
        )
    ;   melhorPergunta(Candidatos, MelhorAtributo),
        format('Pergunta ~w: Seu personagem ~w?~n', [Pergunta, MelhorAtributo]),
        lerResposta(Resposta),
        filtrarCandidatos(Candidatos, MelhorAtributo, Resposta, NovosCandidatos),
        ProximaPergunta is Pergunta + 1,
        iniciarJogo(NovosCandidatos, ProximaPergunta, MaxPerguntas)
    ).

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

jogarNovamente :-
    startGame.

instrucoes :-
    write('=== INSTRUÇÕES DO JOGO ==='), nl,
    write('1. Digite "startGame." para iniciar o jogo'), nl,
    write('2. Pense em um personagem'), nl,
    write('3. Responda as perguntas com "sim.", "nao." ou "nao_sei."'), nl,
    write('4. O jogo tentará adivinhar em até 10 perguntas'), nl,
    write('5. Se não conseguir, você pode adicionar seu personagem'), nl, nl,
    write('- instrucoes. (ver estas instruções)'), nl,
    write('- maisInstrucoes. (outros comandos auxiliares)'), nl,nl.

maisInstrucoes :- 
    write('Outros comandos úteis:'), nl,
    write('- listarPersonagens. (ver todos os personagens)'), nl,
    write('- buscarPorAtributo(atributo). (buscar por atributo)'), nl,
    write('- buscarPorTipo(real). ou buscarPorTipo(ficcional). (buscar por tipo)'), nl,
    write('- buscarPorLocal(\'Inglaterra\'). (buscar por local - use aspas)'), nl,
    write('- contarPersonagens(X). (contar personagens)'), nl.

% Mostrar instruções ao carregar
:- instrucoes.