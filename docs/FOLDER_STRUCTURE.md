# Estrutura do projeto

Este arquivo registra a estrutura inicial para manter o projeto organizado enquanto os assets finais ainda nao existem.

## Fluxo recomendado

1. Criar ou importar sprite em `assets/sprites/<dominio>/`.
2. Criar uma cena propria em `scenes/<dominio>/`.
3. Expor ajustes via `@export` quando o valor deve aparecer no Inspector.
4. Instanciar a cena no mundo, de preferencia em `World2_5D/DepthLayer` quando tiver profundidade.

## Profundidade

`DepthLayer` ordena filhos pelo eixo Y. Para isso funcionar bem:

- base/pe do objeto na origem;
- sprite deslocado para cima;
- colisao curta perto do chao;
- objetos instanciados como cenas independentes.
