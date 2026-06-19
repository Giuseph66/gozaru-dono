# Pipeline de sprites

## Padrao atual

- Player parado: `assets/sprites/characters/player/parado.png`
- Player andando: `assets/sprites/characters/player/caminhando/*.png`
- Valdomiro pobre: `assets/sprites/characters/antagonista/pobre/parado.png`
- Valdomiro rico: `assets/sprites/characters/antagonista/rico/parado.png`
- Caminho de grama: `assets/sprites/props/chao/caminho_grama/`
- Tiles do caminho de grama: `assets/sprites/props/chao/caminho_grama/tiles/*.png`
- Chao jogavel do caminho usa tiles pequenos `ceramic_*` gerados das texturas `_0001` a `_0004`.
- Chao da fabrica: `assets/sprites/props/chao/fabrica/`
- Tiles da fabrica: `assets/sprites/props/chao/fabrica/tiles/*.png`
- Grama importada: `assets/sprites/props/grama/*.png`
- Grama local: `assets/sprites/environment/grass/*.svg`

## Como importar novos sprites

1. Colocar PNG em `assets/sprites/characters/<personagem>/<estado>/`.
2. Criar ou atualizar a cena em `scenes/characters/<personagem>/`.
3. Ajustar escala, posicao e colisao pelo Inspector.
4. Manter `BaseMarker` no pe/base do personagem.
5. Se tiver animacao, usar `AnimatedSprite2D` com nomes simples: `idle`, `walk`, `attack`, `hurt`.

## Regra 2.5D

Origem do personagem no chao. Sprite sobe. Colisao fica perto da base. Isso mantem o `y_sort_enabled` coerente.

## Assets externos

Se um sprite vier de loja/site externo, salvar a licenca junto em `docs/production/licenses/` antes de substituir assets locais.
