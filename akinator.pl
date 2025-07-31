% =====================================
% JOGO DE IDENTIFICAÇÃO DE PERSONAGENS
% =====================================
% AUTOR: Daniel Angelo Rosa Morais 21.1.8128

% Carrega todos os módulos
:- include('personagens.pl').
:- include('ia.pl').
:- include('io.pl').

% Predicado principal para iniciar o jogo
startGame :-
    exibirCabecalho,
    findall(P, personagem(P, _, _, _), TodosPersonagens),
    length(TodosPersonagens, Total),
    exibirEstatisticas(Total),
    iniciarJogo(TodosPersonagens, 1, 10).

% Coordenar o fluxo principal do jogo
iniciarJogo(Candidatos, Pergunta, MaxPerguntas) :-
    (   semCandidatos(Candidatos) ->
        tratarSemCandidatos
    ;   atingiuLimite(Pergunta, MaxPerguntas) ->
        tratarLimiteAtingido(Candidatos)
    ;   deveTentarAdivinhar(Candidatos) ->
        tratarTentativaAdivinhacao(Candidatos, Pergunta, MaxPerguntas)
    ;   continuarPerguntando(Candidatos, Pergunta, MaxPerguntas)
    ).

tratarSemCandidatos :-
    mensagemNenhumPersonagem,
    adicionarNovoPersonagem.

tratarLimiteAtingido(Candidatos) :-
    mensagemDerrota,
    (   deveTentarAdivinhar(Candidatos) ->
        Candidatos = [UltimoPersonagem],
        mensagemPalpiteFinal(UltimoPersonagem)
    ;   mensagemAdicionarPersonagem
    ),
    adicionarNovoPersonagem.

tratarTentativaAdivinhacao(Candidatos, Pergunta, MaxPerguntas) :-
    Candidatos = [Personagem],
    exibirTentativaAdivinhacao(Personagem),
    lerResposta(Resposta),
    processarRespostaAdivinhacao(Resposta, Pergunta, MaxPerguntas).

processarRespostaAdivinhacao(sim, _, _) :-
    mensagemVitoria.

processarRespostaAdivinhacao(nao, Pergunta, MaxPerguntas) :-
    mensagemContinuarExplorando,
    iniciarJogo([], Pergunta, MaxPerguntas).

processarRespostaAdivinhacao(nao_sei, Pergunta, MaxPerguntas) :-
    ProximaPergunta is Pergunta + 1,
    iniciarJogo([], ProximaPergunta, MaxPerguntas).

continuarPerguntando(Candidatos, Pergunta, MaxPerguntas) :-
    melhorPergunta(Candidatos, MelhorAtributo),
    exibirPergunta(Pergunta, MelhorAtributo),
    lerResposta(Resposta),
    filtrarCandidatos(Candidatos, MelhorAtributo, Resposta, NovosCandidatos),
    ProximaPergunta is Pergunta + 1,
    iniciarJogo(NovosCandidatos, ProximaPergunta, MaxPerguntas).

adicionarNovoPersonagem :-
    coletarDadosNovoPersonagem(Nome, Tipo, Local, Atributos),
    criarEAdicionarPersonagem(Nome, Tipo, Local, Atributos),
    mensagemPersonagemAdicionado(Nome).

criarEAdicionarPersonagem(Nome, Tipo, Local, Atributos) :-
    NovoPersonagem =.. [personagem, Nome, Tipo, Local, Atributos],
    assertz(NovoPersonagem),
    salvarPersonagemNoArquivo(Nome, Tipo, Local, Atributos).

salvarPersonagemNoArquivo(Nome, Tipo, Local, Atributos) :-
    open('personagens.pl', append, Stream),
    format(Stream, '~npersonagem(~q, ~q, ~q, ~q).~n', [Nome, Tipo, Local, Atributos]),
    close(Stream).

% Atalhos para comandos
jogarNovamente :- startGame.
instrucoes :- exibirInstrucoes.
maisInstrucoes :- exibirMaisInstrucoes.

% Mostrar instruções ao carregar
:- exibirInstrucoes.