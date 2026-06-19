# AGENTS.md - Gozaru-dono

Projeto Godot 4.6 desenvolvido com apoio de agentes de IA.

## Objetivo

Criar um jogo 2D com profundidade 2.5D, mantendo cenas, sprites, scripts e recursos bem separados para facilitar edicao direta pela Godot.

## Fonte de verdade narrativa

- A historia oficial fica em `historia/`.
- Nao mudar pilares narrativos sem pedido do dev.
- `docs/design/GAME_DESIGN.md` formaliza a direcao jogavel.
- `docs/design/JORNADAS_IMPLEMENTACAO.md` mapeia roteiro para fases.

## Regras para agentes

- Preservar a arquitetura existente.
- Fazer diffs pequenos e localizados.
- Nao rodar Godot, build, lint ou testes sem pedido explicito.
- Nao adicionar dependencias sem confirmacao.
- Manter cenas editaveis pelo Inspector.
- Preferir cenas reutilizaveis em vez de nodes soltos no mapa.
- Manter sprites em `assets/sprites/**`.
- Manter cenas em `scenes/**`.
- Manter scripts em `scripts/**`.

## Padrao de cena

- Toda entidade reutilizavel deve ter uma cena propria.
- A raiz da cena deve ter nome claro: `Player`, `Crate`, `Pillar`, etc.
- Para objetos 2.5D, a origem deve ficar no pe/base.
- O sprite deve ser filho deslocado para cima.
- A colisao deve ficar proxima da base do objeto.
- Props do mundo devem ser instanciados em `World2_5D/DepthLayer`.
- Personagens de historia devem ter cenas proprias em `scenes/characters/**`.
- A progressao deve consultar ou manter coerencia com `StoryState`.

## Organizacao atual

- Entrada: `scenes/main/Main.tscn`
- Mundo: `scenes/world/World2_5D.tscn`
- Jogador: `scenes/characters/player/Player.tscn`
- Antagonista: `scenes/characters/antagonista/`
- Estado narrativo: `scripts/story/story_state.gd`
- Props: `scenes/props/`
- Ambiente: `scenes/environment/`
- HUD: `scenes/ui/HUD.tscn`

## Estilo de scripts

- Usar GDScript tipado quando simples.
- Usar `@export` para valores que designers/devs possam ajustar no Inspector.
- Evitar logica escondida se um ajuste visual pode ser resolvido na cena.
- Comentarios so quando ajudam a explicar uma decisao de estrutura.
