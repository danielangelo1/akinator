# 🎭 Akinator em Prolog

Um jogo inteligente de adivinhação de personagens desenvolvido em Prolog que consegue "ler sua mente" fazendo perguntas estratégicas!

<div align="center">

![Prolog](https://img.shields.io/badge/Prolog-Logic_Programming-red?style=for-the-badge&logo=prolog)
![Status](https://img.shields.io/badge/Status-Concluído-success?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

</div>

## 🎯 Sobre o Projeto

Este é um jogo de adivinhação inspirado no famoso **Akinator**, onde o computador tenta adivinhar qual personagem você está pensando através de perguntas inteligentes. O sistema utiliza algoritmos de busca em Prolog para fazer perguntas estratégicas e conseguir identificar o personagem em **no máximo 10 tentativas**.

### ✨ Funcionalidades

- 🧠 **IA Inteligente**: Algoritmo que escolhe as melhores perguntas para dividir os candidatos
- 📚 **Base Rica**: 22+ personagens históricos e ficcionais pré-cadastrados
- 🎓 **Aprendizado**: Sistema adiciona novos personagens quando não consegue adivinhar
- 🎯 **Limite de Perguntas**: Máximo de 10 perguntas por partida
- 🔍 **Consultas**: Ferramentas para explorar a base de dados
- 💬 **Interface Amigável**: Respostas simples (sim/não/não sei)

## 🎮 Como Jogar

### 1. Pré-requisitos

- **SWI-Prolog** instalado no sistema
- Terminal ou ambiente Prolog

### 2. Execução

```prolog
?- [akinator].        % Carrega o arquivo
?- startGame.         % Inicia o jogo
```

### 3. Gameplay

1. 🤔 Pense em um personagem (real ou fictício)
2. 📝 Responda as perguntas com:
   - `sim.` - Se a característica se aplica
   - `nao.` - Se a característica não se aplica
   - `nao_sei.` - Se você não tem certeza
3. 🎯 O jogo tentará adivinhar em até 10 perguntas
4. 🏆 Se não conseguir, você pode adicionar seu personagem!

### 4. Exemplo de Partida

```prolog
?- startGame.
=== JOGO DE ADIVINHAÇÃO DE PERSONAGENS ===
Pense em um personagem e eu tentarei adivinhar!

Pergunta 1: Seu personagem é mago?
|: sim.

Pergunta 2: Seu personagem é jovem?
|: sim.

Pergunta 3: Seu personagem tem cicatriz?
|: sim.

É o personagem Harry Potter?
|: sim.

Ótimo! Consegui adivinhar! ✨
```

## 🗃️ Base de Dados

O jogo possui **22 personagens** diversos, incluindo:

### 📚 Personagens Históricos

- Albert Einstein, Marie Curie, Leonardo da Vinci
- Napoleon Bonaparte, Cleópatra, Joana d'Arc
- Isaac Newton, William Shakespeare, Mahatma Gandhi

### 🎭 Personagens Ficcionais

- Harry Potter, Hermione Granger, Gandalf
- Batman, Spider-Man, Wonder Woman, Iron Man
- Sherlock Holmes, Darth Vader, Yoda, Elsa

### 🏷️ Estrutura dos Dados

```prolog
personagem(Nome, TipoRealidade, LocalOrigem, [ListaAtributos]).
```

**Exemplo:**

```prolog
personagem('Harry Potter', ficcional, 'Inglaterra',
    [mago, jovem, cicatriz, oculos, corajoso, estudante]).
```

## 🛠️ Comandos Úteis

| Comando                    | Descrição                      |
| -------------------------- | ------------------------------ |
| `startGame.`               | Inicia uma nova partida        |
| `listarPersonagens.`       | Mostra todos os personagens    |
| `buscarPorAtributo(mago).` | Busca personagens por atributo |
| `contarPersonagens(X).`    | Conta total de personagens     |
| `instrucoes.`              | Exibe instruções detalhadas    |
| `halt.`                    | Sai do Prolog                  |

## 🧠 Como Funciona a IA

O algoritmo utiliza uma estratégia de **divisão ótima**:

1. **Análise**: Examina todos os atributos dos personagens candidatos
2. **Pontuação**: Calcula qual pergunta melhor divide o conjunto
3. **Seleção**: Escolhe o atributo que cria a divisão mais equilibrada
4. **Filtragem**: Remove personagens baseado na resposta
5. **Recursão**: Repete até encontrar o personagem ou atingir o limite

```prolog
% Exemplo de cálculo de score
calcularScore(Candidatos, Atributo, Score) :-
    % Conta quantos têm e quantos não têm o atributo
    % Score = min(NumCom, NumSem) para divisão equilibrada
```

## 📁 Estrutura do Projeto

```
linguaguens/
├── akinator.pl          # Código principal do jogo
└── README.md           # Este arquivo
```

## 🚀 Possíveis Melhorias

- [ ] Interface gráfica com SWI-Prolog + HTML
- [ ] Persistência de dados em arquivo
- [ ] Sistema de dificuldade (fácil/médio/difícil)
- [ ] Estatísticas de acertos
- [ ] Mais personagens da cultura pop
- [ ] Suporte a múltiplos idiomas

## 🎓 Contexto Acadêmico

Este projeto foi desenvolvido como trabalho da disciplina de **Linguagens de Programação** da **UFOP** (Universidade Federal de Ouro Preto), focando em:

- Programação em lógica com Prolog
- Algoritmos de busca e inferência
- Manipulação de bases de conhecimento
- Interação com usuário em sistemas especialistas

## 👨‍💻 Autor

**Daniel Angelo**

- GitHub: [@danielangelo](https://github.com/danielangelo)
- Universidade: UFOP - Universidade Federal de Ouro Preto

---

<div align="center">

**⭐ Se gostou do projeto, deixe uma estrela! ⭐**

_Desenvolvido com 💜 em Prolog_

</div>
