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

% Coletar dados do novo personagem
coletarDadosNovoPersonagem(Nome, Tipo, Local, Atributos) :-
    coletarNome(Nome),
    coletarTipo(Tipo),
    coletarLocal(Local),
    coletarAtributos(Atributos).

% Coletar nome do personagem
coletarNome(Nome) :-
    write('Qual é o nome do personagem? '),
    flush_output,
    get_char(_),  % Consome qualquer caractere pendente
    read_line_to_string(user_input, NomeStr),
    atom_string(Nome, NomeStr).

% Coletar tipo do personagem
coletarTipo(Tipo) :-
    nl,
    write('É um personagem real ou ficcional? (real/ficcional) '),
    flush_output,
    read_line_to_string(user_input, TipoStr),
    atom_string(Tipo, TipoStr).

% Coletar local de origem
coletarLocal(Local) :-
    nl,
    write('Qual é o local de origem? '),
    flush_output,
    read_line_to_string(user_input, LocalStr),
    atom_string(Local, LocalStr).

% Coletar atributos
coletarAtributos(Atributos) :-
    nl,
    write('Digite os atributos separados por vírgula (ex: jovem,corajoso,mago): '),
    flush_output,
    read_line_to_string(user_input, AtributosStr),
    processar_atributos(AtributosStr, Atributos).

% Processar string de atributos em lista
processar_atributos(AtributosStr, Atributos) :-
    split_string(AtributosStr, ',', ' ', AtributosStrList),
    maplist(string_to_atom, AtributosStrList, Atributos).

% Converter string para atom removendo espaços
string_to_atom(Str, Atom) :-
    string_concat(Str, '', StrClean),
    atom_string(Atom, StrClean).

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