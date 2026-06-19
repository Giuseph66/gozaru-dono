# Game Design - Gozaru-dono

Documento formal de direcao. A pasta `historia/` continua sendo a fonte da verdade do roteiro.

## Identidade

- Genero: plataforma/action 2D com leitura 2.5D.
- Tom: comedia adulta, absurda, vulgar e escatologica.
- Estrutura narrativa: começo, meio, fim e multiplos finais.
- Conflito central: liberdade/ego do Gozaru-dono contra posse/obsessao do Valdomiro.

## Fonte de verdade

- `historia/00_VISAO_GERAL.md`: resumo mestre.
- `historia/01_ORIGEM.md`: origem e tres desejos.
- `historia/02_PERSONAGENS.md`: personagens principais.
- `historia/03_PODERES_E_MECANICAS.md`: poderes e mecanicas.
- `historia/04_JORNADAS.md`: estrutura por atos.
- `historia/05_FINAIS.md`: finais.
- `historia/06_TOM_E_REGRAS.md`: tom.
- `historia/07_DECISOES_E_PENDENCIAS.md`: pendencias.

## Pilares jogaveis

1. Movimento 2.5D com profundidade por eixo Y.
2. Personagens editaveis em cenas proprias.
3. Poderes desbloqueados por jornada.
4. Humor fisico e resposta visual/sonora forte.
5. Valdomiro cresce de figura patetica para ameaca final.

## Personagens implementados

- Gozaru-dono: `scenes/characters/player/Player.tscn`.
- Valdomiro pobre: `scenes/characters/antagonista/ValdomiroPobre.tscn`.
- Valdomiro rico: `scenes/characters/antagonista/ValdomiroRico.tscn`.

## Estado narrativo

`scenes/main/Main.tscn` possui o node `StoryState`, com script:

`res://scripts/story/story_state.gd`

Ele centraliza:

- jornada atual;
- poderes liberados;
- flags principais para a progressao.

Por enquanto ele nao troca fases automaticamente. Ele existe para manter o projeto pronto para menus, saves, fases e eventos.

## Aviso de conteudo

O jogo deve ser apresentado como comedia adulta escatologica. O aviso deve aparecer em paginas externas, menu inicial ou tela de abertura quando essa camada for criada.
