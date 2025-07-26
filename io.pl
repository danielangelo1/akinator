% =====================================
% MÓDULO DE ENTRADA/SAÍDA
% =====================================
% Autor: Daniel Angelo Rosa Morais 21.1.8128

lerResposta(Resposta) :-
    read(Input),
    (   Input = sim -> Resposta = sim
    ;   Input = nao -> Resposta = nao
    ;   Input = nao_sei -> Resposta = nao_sei
    ;   write('Responda apenas "sim", "nao" ou "nao_sei". Tente novamente: '),
        lerResposta(Resposta)
    ).

exibirCabecalho :-
    write('=== JOGO DE ADIVINHAÇÃO DE PERSONAGENS ==='), nl,
    write('Pense em um personagem e eu tentarei adivinhar!'), nl,
    write('Responda com "sim", "nao" ou "nao_sei".'), nl, nl.

exibirEstatisticas(Total) :-
    format('Tenho ~w personagens na minha base de dados.~n~n', [Total]).

exibirPergunta(Numero, Atributo) :-
    format('Pergunta ~w: Seu personagem ~w?~n', [Numero, Atributo]).

exibirTentativaAdivinhacao(Personagem) :-
    format('É o personagem ~w?~n', [Personagem]).

mensagemVitoria :-
    write('Ótimo! Consegui adivinhar!'), nl.

mensagemDerrota :-
    write('Atingi o limite de perguntas! Você venceu!'), nl.

mensagemPalpiteFinal(Personagem) :-
    format('Meu melhor palpite seria: ~w~n', [Personagem]),
    write('Mas vou adicionar seu personagem mesmo assim.'), nl.

mensagemContinuarExplorando :-
    write('Interessante... Deixe-me fazer mais algumas perguntas.'), nl.

mensagemNenhumPersonagem :-
    write('Não consegui encontrar nenhum personagem! Vamos adicionar o seu.'), nl.

mensagemAdicionarPersonagem :-
    write('Vamos adicionar seu personagem à minha base de dados.'), nl.

coletarDadosNovoPersonagem(Nome, Tipo, Local, Atributos) :-
    write('Qual é o nome do personagem? '),
    read(Nome),
    write('É um personagem real ou ficcional? (real/ficcional) '),
    read(Tipo),
    write('Qual é o local de origem? '),
    read(Local),
    write('Digite os atributos separados por vírgula (ex: [jovem, corajoso, mago]): '),
    read(Atributos).

mensagemPersonagemAdicionado(Nome) :-
    format('Personagem ~w adicionado com sucesso!~n', [Nome]),
    write('Obrigado por me ensinar algo novo!'), nl.

% Instruções do jogo
exibirInstrucoes :-
    write('=== INSTRUÇÕES DO JOGO ==='), nl,
    write('1. Digite "startGame." para iniciar o jogo'), nl,
    write('2. Pense em um personagem'), nl,
    write('3. Responda as perguntas com "sim.", "nao." ou "nao_sei."'), nl,
    write('4. O jogo tentará adivinhar em até 10 perguntas'), nl,
    write('5. Se não conseguir, você pode adicionar seu personagem'), nl, nl,
    write('- instrucoes. (ver estas instruções)'), nl,
    write('- maisInstrucoes. (outros comandos auxiliares)'), nl, nl.

exibirMaisInstrucoes :- 
    write('Outros comandos úteis:'), nl,
    write('- listarPersonagens. (ver todos os personagens)'), nl,
    write('- buscarPorAtributo(atributo). (buscar por atributo)'), nl,
    write('- buscarPorTipo(real). ou buscarPorTipo(ficcional). (buscar por tipo)'), nl,
    write('- buscarPorLocal(\'Inglaterra\'). (buscar por local - use aspas)'), nl,
    write('- contarPersonagens(X). (contar personagens)'), nl.