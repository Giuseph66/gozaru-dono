# Gozaru-dono

Projeto Godot 4.6 para um jogo 2D com leitura de profundidade 2.5D.

O projeto agora segue a historia documentada em `historia/`. A ideia base e usar origem no pe/base dos objetos e organizar tudo dentro de uma camada com `y_sort_enabled`, para o editor da Godot permitir mexer em posicao, escala, rotacao, textura e colisao diretamente pelo Inspector.

## Como abrir

1. Abra a pasta do projeto na Godot.
2. Rode a cena principal: `res://scenes/main/Main.tscn`.
3. Edite as cenas individuais quando quiser trocar sprites ou ajustar colisao:
   - `res://scenes/characters/player/Player.tscn`
   - `res://scenes/characters/antagonista/ValdomiroPobre.tscn`
   - `res://scenes/characters/antagonista/ValdomiroRico.tscn`
   - `res://scenes/props/Crate.tscn`
   - `res://scenes/environment/Pillar.tscn`
   - `res://scenes/world/World2_5D.tscn`

## Documentos principais

- `historia/00_VISAO_GERAL.md`: fonte mestre do roteiro.
- `docs/design/GAME_DESIGN.md`: direcao formal do jogo.
- `docs/design/JORNADAS_IMPLEMENTACAO.md`: roteiro convertido em plano de fases.
- `docs/production/SPRITE_PIPELINE.md`: padrao para novos sprites.

## Estrutura

```text
assets/
  sprites/
    characters/player/   sprites do jogador
    environment/         chao, pilares, objetos de cenario
    props/               caixas e objetos interativos
    effects/             sombras e efeitos visuais simples
    ui/                  sprites de interface
  audio/
    music/               musicas futuras
    sfx/                 efeitos sonoros futuros
  source/                arquivos fonte editaveis externos

scenes/
  main/                  entrada do jogo
  world/                 mapa e organizacao 2.5D
  characters/player/     cena do jogador
  characters/antagonista/ cenas do Valdomiro
  levels/                jornadas/fases futuras
  environment/           cenas de cenario
  props/                 props reutilizaveis
  ui/                    HUD e telas

scripts/
  core/                  scripts globais
  world/                 camera, profundidade e mundo
  characters/player/     movimento do jogador
  ui/                    scripts de interface

resources/
  config/                configs futuras em .tres/.res
  materials/             materiais futuros

docs/                    notas de arquitetura e producao
```

## Padrao 2.5D usado

- Objetos que precisam ordenar por profundidade ficam em `World2_5D/DepthLayer`.
- A origem do objeto representa o ponto de contato com o chao.
- O sprite visual fica deslocado para cima, mantendo o pe/base na origem.
- Colisoes ficam perto da base, para parecer que o objeto ocupa volume no chao.
- `DepthLayer` usa `y_sort_enabled`, entao objetos mais abaixo na tela aparecem na frente.

## Controles placeholder

O jogador usa as acoes padrao da Godot:

- `ui_left`
- `ui_right`
- `ui_up`
- `ui_down`

Essas acoes podem ser trocadas no Inspector da cena `Player.tscn`, no script `PlayerController2D`.

## Proximos passos

- Criar cena de mapa real.
- Criar a cena jogavel da Jornada 1.
- Implementar ataques base.
- Criar Valdomiro rico/obsessivo como progressao visual.
- Adicionar interacoes e sistema de estado do jogo.
