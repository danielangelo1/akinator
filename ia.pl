% =====================================
% MÓDULO DE INTELIGÊNCIA ARTIFICIAL
% =====================================
% Autor: Daniel Angelo Rosa Morais 21.1.8128

% Encontrar a melhor pergunta (atributo que melhor divide os candidatos)
melhorPergunta(Candidatos, MelhorAtributo) :-
    obterTodosAtributos(Candidatos, AtributosUnicos),
    calcularScores(Candidatos, AtributosUnicos, Scores),
    selecionarMelhorScore(Scores, MelhorAtributo).

obterTodosAtributos(Candidatos, AtributosUnicos) :-
    findall(Atributo, (
        member(Personagem, Candidatos),
        personagem(Personagem, _, _, Atributos),
        member(Atributo, Atributos)
    ), TodosAtributos),
    list_to_set(TodosAtributos, AtributosUnicos).

calcularScores(Candidatos, AtributosUnicos, Scores) :-
    findall(Score-Atributo, (
        member(Atributo, AtributosUnicos),
        calcularScore(Candidatos, Atributo, Score)
    ), Scores).

selecionarMelhorScore(Scores, MelhorAtributo) :-
    sort(Scores, ScoresOrdenados),
    reverse(ScoresOrdenados, [_-MelhorAtributo|_]).

% Calcular score de um atributo (quão bem ele divide os candidatos)
calcularScore(Candidatos, Atributo, Score) :-
    length(Candidatos, Total),
    contarPersonagensComAtributo(Candidatos, Atributo, NumCom),
    NumSem is Total - NumCom,
    calcularScoreDivisao(NumCom, NumSem, Score).

contarPersonagensComAtributo(Candidatos, Atributo, NumCom) :-
    findall(P, (
        member(P, Candidatos),
        personagem(P, _, _, Atributos),
        member(Atributo, Atributos)
    ), ComAtributo),
    length(ComAtributo, NumCom).

% Calcular score baseado na divisão (quanto mais equilibrada, melhor)
calcularScoreDivisao(NumCom, NumSem, Score) :-
    (   NumCom =:= 0 ; NumSem =:= 0 ->
        Score = 0
    ;   Score is min(NumCom, NumSem)
    ).

% Filtrar candidatos baseado na resposta do usuário
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

% Verificar se deve tentar adivinhar (1 candidato restante)
deveTentarAdivinhar(Candidatos) :-
    length(Candidatos, 1).

% Verificar se atingiu limite de perguntas
atingiuLimite(Pergunta, MaxPerguntas) :-
    Pergunta > MaxPerguntas.

% Verificar se não há mais candidatos
semCandidatos(Candidatos) :-
    length(Candidatos, 0).