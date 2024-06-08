% Primos Arrojados

Kanela é um garoto fascinado por números primos (números que contêm
exatamente $2$ divisores positivos distintos). Desde que aprendeu na
escola, sempre tentou encontrar primos em todos os números que via. Um
de seus hobbies favoritos era escrever números primos em seu
caderno. Um belo dia, Kanela resolveu apagar um número primo em seu
caderno com uma borracha da direita para esquerda. Ao apagar o último
dígito, Kanela notou que o número restante continuava sendo um
primo. Ao apagar o último dígito deste, Kanela viu que o número
restante também era primo. E assim por diante, conforme os dígitos
eram apagados da direita para a esquerda, o número remanescente era
primo até que fosse apagado completamente. Kanela achou isso o máximo
e começou a chamar esses números de *primos arrojados*!

Por exemplo, o número $2393$ é um primo arrojado, pois:

* $2393$ é um número primo;
* retirando-se o último algarismo, $239$ continua sendo um número primo;
* retirando-se o último algarismo, $23$ também é um número primo; e
* removendo-se o último algarismo, tem-se $2$ que é primo.

Ajude Kanela a dizer se um número é um *primo arrojado* ou não.

## Entrada

A primeira linha contém o inteiro $T$ ($1 \leq T \leq 100$), que
representa a quantidade de casos de teste.

Cada uma das próximas $T$ linhas contém um número $n$ ($1 \leq n \leq
10^7$).

## Saída

Para cada caso de teste, imprima uma linha com **S**, caso o número
$n$ seja um *primo arrojado*, ou **N**, caso contrário.

## Exemplos

### Exemplo de entrada
```
11
1
2
7
10
11
22
23
123
173
233
2393
```

#### Exemplo de saída
```
N
S
S
N
N
N
S
N
N
S
S
```
