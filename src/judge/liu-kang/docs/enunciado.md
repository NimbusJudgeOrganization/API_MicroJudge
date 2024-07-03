% Liu Kang

O plano terreno está novamente em perigo. Desta vez o problema não
parece ser de um *KHAN*... a poderosa *KRONICA* está manipulando o tempo
para que seu filho, _Shinnok_, retorne e o equilíbrio entre o bem e o mal
seja restabelecido. Para esse feito, *KRONICA*, deverá recriar o início dos
tempos utilizando a _areia_ temporal.

O poder de *KRONICA* é muito grande e os defensores do plano terreno não
possuem força suficiente para derrotá-la, assim *Lorde RAYDEN* precisou
fazer um sacrifício e fundiu sua existência com a de _Liu Kang_, gerando uma
nova existência de _Liu Kang_, que passa a ser conhecido como *Lorde Liu
Kang Deus do Fogo*. Esta fusão ainda fez com que a existência de _Liu Kang
Corrompido_ fosse eliminada, tendo seu conhecimento sido absorvido pela nova
forma de existência de nosso herói.

Esta nova transformação de _Lorde Liu Kang_ é a única chance para a derrota
de *KRONICA*. Mas nem tudo será simples! O tempo não é mais linear e
diversas linhas do tempos estão se fundindo em único plano. É difícil
perseguir *KRONICA* e evitar que ela consiga finalizar o recomeço dos
tempos.

Infelizmente _Lorde Liu Kang, Deus do Fogo_ não possui a maior inteligência
dentre os seres do plano terreno, e para isso ele convocou _sua_ existência
para descobrir o caminho que *KRONICA* utiliza para conseguir encontrá-la
para a batalha final.

Percebemos que *KRONICA* está manipulando o tempo utilizando o próprio tempo
para se esconder. Você precisa identificar o tempo que ela estará para a
batalha. Com toda _sua_ esperteza você descobriu que *KRONICA* pula o tempo
de uma forma consistente aproveitando informações do tempo vindas dos grãos
de areia.

Percebemos algumas coisas:

- Estamos sempre em uma linha temporal representada por um número, $T$, que é um
   quadrado perfeito, i.e, $T = n^2$ e $T = \sum_{k=1}^n(2k-1)$;
- Quando $T$ é _par_, *KRONICA* vai para a linha temporal representada
   pelo o quadrado do termo $n/2$;
- Quando $T$ é _ímpar_, *KRONICA* pula para a linha temporal representada
   pelo quadrado do termo $n$.

Como o tempo não é mais linear, percebemos que sempre estamos presentes em
uma linha do tempo representada por um número quadrado perfeito, e sabemos
que *KRONICA* estará no quadrado do $n$-zimo termo da linha temporal que
forma a atual linha do tempo em que estamos.

E sempre que *KRONICA* sofre um dano de _Lorde Liu Kang_, ela foge para a
linha indicada na regra acima. Estamos em um ponto que ela precisa sofrer
pouco dano (alguns golpes) para finalmente ser derrotada. Você deve ajudar
_Lorde Liu Kang_ e prever todas linhas temporais em que ela estará a cada
golpe.  *KRONICA* acabou de levar um golpe e se escondeu.

CORRA! O tempo é "curto"!

## Entrada

A entrada é composta por um único caso de teste. O caso de teste possui uma
única linha contendo dois números inteiros $T_a$ ( $5 \leq T_a \leq 2^{33}$)
e $G_m$ ( $1 \leq G_m \leq 100$ ) representando, respectivamente, o tempo
atual em que estamos e a quantidade de golpes que *KRONICA* precisa sofrer
para ser derrotada.

## Saída

A saída é compostas por $G_m$ linhas, cada linha representa a linha temporal
em que *KRONICA* estará após um golpe.


## Exemplos

### Exemplo de entrada

```
25 2
```

#### Saída para o exemplo de entrada

```
81
289
```

### Exemplo de entrada

```
100 5
```

#### Saída para o exemplo de entrada

```
81
289
1089
4225
16641
```
