# vim: foldenable foldmethod=marker foldmarker=<<<,>>>

(import ../common)

(def -fold common/make-fold)
(def -summary common/make-summary)
(def -link common/make-link)
(def -small-note-p common/make-small-note-p)
(def -code-i common/make-code-inline)
(def -code-b common/make-code-block)

(def- head
  [
   ['title `Tutorial de C`]
   ])

(def- body
  [(-fold {:open true} (-summary 1 `Tutorial de C`)
    ['p `Olá! Aqui eu vou tentar ajudar com algumas coisas de C.`]
    ['p `Não é muita coisa. É mais um ponto de referência p/ algumas dúvidas q eu ja tirei.`]

    (-fold {} (-summary 2 `int main()`) # <<<
      ['p (-code-i `main()`) ` é o nome do "ponto de entrada" de um programa, geralmente. Então o que você quer que rode você coloca ali.`]
      ['p `Ela na verdade é o que chamamos de ` ['b `função`] ` (` (-link `#s-funcoes` `um pouco mais avançado - leia mais em baixo`) `), `
       `mas basicamente é um pedaço de código que você pode rodar várias vezes. Outras coisas que veremos mais na frente, como `
       (-code-i `printf()`) `, ` (-code-i `scanf()`) ` e ` (-code-i `sqrt()`) `, são funções também, mas elas meio que... "já são definidas pelo compilador".`]
      ['p `O ` (-code-i `main()`) `, porém, deve ser definido por nós, e é nele onde deve ficar o nosso código.`]
      ['p `A partir daqui, a maioria dos códigos vai omitir o ` (-code-i `int main()`) `, mas você precisa colocar o código dentro dele.`]
      ['p `Então isso:`]
      (-code-b
        ```
        int main() {
            int a = 10 + 20;
        }
        ```)
      ['p `É a forma correta de escrever, enquanto isso:`]
      (-code-b
        ```
        int a = 10 + 20;
        ```)
      ['p `É o que vai aparecer.`]
      ) # >>>

    # TODO: criando variáveis
    # TODO: tipos de dados

    (-fold {} (-summary 2 `mostrando coisas na tela (com printf())`) # <<<
      ['p `O ` (-code-i `printf`) ` é uma função usada para mostrar coisas na tela.`]
      ['p `Para usar, você precisa colocar ` (-code-i `#include <stdio.h>`) ` no início do código, antes do ` (-code-i `int main()`) `.`]
      ['p `Um exemplo de uso do printf seria:`]
      (-code-b ```
               Olá, mundo!
               ```)

      # TODO: definir o que é uma string lá em cima kk
      ['p `Basicamente, você passa um texto (entre aspas) com uma mensagem para mostrar na tela.`]

      ['hr]

      ['p `Mas como mostrar, por exemplo, um número que foi calculado no programa?`]
      ['p `Para isso, você precisa usar os %. Vejamos outro exemplo:`]
      (-code-b ```
               int x = 0;
               printf("O sucessor de x é %d", x+1);
               ```)
      ['p `Quando você usa o ` (-code-i `%d`) ` no texto do printf, a próxima coisa que você passar depois do texto vai ser colocada no lugar dele. Nesse caso, o programa mostraria ` (-code-i `O sucessor de x é 1`) `.`]
      ['p `E você pode usar isso várias vezes:`]
      (-code-b ```
               int a = 1;
               int b = 3;
               printf("a=%d, b=%d, a+b=%d", a, b, a+b);
               ```)
      ['p `(Isso mostra ` (-code-i `a=1, b=3, a+b=4`) `)`]

      ['hr]

      ['p `Agora cuidado: o ` (-code-i `%d`) ` é usado somente para ` (-code-i `int`) `. Se você quiser passar outros tipos de valores, vai ter que usar outros códigos:`]
      ['ul
       ['li `%d ou %i: int (normal)`]
       ['li `%x: int (em hexadecimal - base 16)`]
       ['li `%o: int (em octal - base 8)`]
       ['li `%u: unsigned int (normal)`]
       ['li `%c: char (em forma de caractere)`]
       ['li `%f: float`]
       ['li `%lf: double (o código lf pq é abreviação "long float", que é equivalente)`]
       ]

      # TODO: %10d, %010d, %s
      ) # >>>

    (-fold {} (-summary 2 `recebendo dados digitados (com scanf())`) # <<<
      ['p `Além de saber como mostrar coisas na tela, é também muito útil saber sim ler coisas que o usuário digitar.`]
      ['p `Para isso temos o ` (-code-i `scanf`) `. Ele funciona de uma maneira parecida com o printf, mas o texto é um formato do que o usuário vai digitar, e o que você passa depois são as variáveis pra onde essas coisas digitadas vão.`]

      ['p `Confuso? Enfim, um exemplo provavelmente ajuda mais:`]

      (-code-b
        ```
        int x;
        scanf("%d", &x);
        ```)

      ['p `Aqui nós criamos uma variável ` (-code-i `x`) ` e usamos o scanf. Ao fazer isso, o programa vai parar até que o usuário digite algo e aperte enter. Ele então vai tentar pegar o texto que o usuário digitou, e, se for um número, colocar em ` (-code-i `x`) `.`]

      ['p `Esse programa aqui então é uma mini calculadora:`]

      (-code-b ```
               int x;
               printf("Digite x: ");
               scanf("%d", &x);
               printf("x*5=%d", x*5);
               ```)

      ['p `Se eu digitar ` (-code-i `20`) `, o resultado vai ser ` (-code-i `x*5=100`) `.`]

      ['hr]

      ['p `Lembre-se de, ao colocar a variável, colocar o ` (-code-i `&`) ` logo antes. Isso siginifica que, ao invés de você passar o que tá dentro da variável x, você está passando o ` ['b `endereço`] ` dela. Talvez eu explique isso algum dia direito, mas uma maneira simples de entender é: toda variável, quando o programa tá rodando, tá em algum lugar específico da memória. Passar o endereço seria indicar ao scanf onde na memória tá essa variável, para ele poder ir lá e colocar o valor que o usuário digitou ali.`]

       ['hr]

       ['p `Os tipos de % usados aqui são basicamente os mesmos que você usaria no printf, então pode olhar a tabela de códigos de lá mesmo.`]
       )

     (-fold {} (-summary 2 `comentários (// e /* */)`)
       ['p `Às vezes é bom poder anotar algo no código. Para isso, usamos os comentários.`]
       ['p `Um comentário é um texto que não vira código - ele é essencialmente ignorado pelo compilador.`]

       ['p `Em C, a maneira "clássica" de comentar é com o ` (-code-i `/* */`) `. Você começa o comentário com ` (-code-i `/*`) ` e termina ele com ` (-code-i `*/`) `.`]
       (-code-b ```
                int x; /* olá! isso aqui é um comentário. */
                scanf("%d", &x); /* um comentário
                de múltiplas linhas
                */
                ```)

       ['p `O compilador ignora os comentários, então isso é equivalente a:`]
       (-code-b ```
                int x;
                scanf("%d", &x);
                ```)

       ['p `Desde 1990(?) você pode também usar os comentários de uma-linha. Ao colocar o ` (-code-i `//`) `, tudo até o fim daquela linha é ignorado.`]

       (-code-b
         ```
         int x; // olá! isso aqui é um comentário.
         scanf("%d", &x);
         // como eu quero colocar
         // várias linhas, eu tenho
         // que usar o // no início de cada linha.
         ```)

       ['p `Mais uma vez, o compilador ignora os comentários, e resulta em:`]

       (-code-b ```
                int x;
                scanf("%d", &x);
                ```)

       ['hr]

       ['p `Além de anotar coisas, comentários são úteis para ignorar um código por um tempo, sendo que você quer usar ele depois.`]

       ['p `Alguns editores até tem telas específicas para comentar o texto selecionado, o que deixa isso bem prático (no VSCode é Ctrl+K, eu acho?)`]
       ) # >>>

    (-fold {:id "s-funcoes"} (-summary 2 `funções: introdução`) # <<<
      ['p ['i `Os exemplos desse capítulo são completos! As coisas aqui ficam fora do ` (-code-i `main()`) `.`]]

      ['p `Funções são "blocos de código" que podem ser rodados quando você quiser.`]

      ['p `Vamos começar com um exemplo:`]

      (-code-b
        ```
        float triplo(float x) {
            return 3.0 * x;
        }
        ```)

      ['p `Aqui, temos uma função, de nome ` (-code-i `triplo`) `, que recebe um número `
       (-code-i `x`) `, multiplica ele por ` (-code-i `3.0`) ` e retorna o resultado, que também é ` (-code-i `float`) `.`]

      ['p `Quando você quer usar ela, você pode fazer ` (-code-i `triplo(num)`) `, e o resultado vai ser o triplo de num. Um exemplo:`]

      (-code-b
        ```
        #include <stdio.h>

        float triplo(float x) {
            return 3.0 * x;
        }

        int main() {
            int x = 10;
            printf("O triplo de 10 é %d\n", triplo(x));
        }
        ```)

      ['p `Esse programa vai mostrar ` (-code-i `O triplo de 10 é 30`) `.`]

      ['hr]

      ['p `Uma forma mais genérica de definir uma função seria:`]

      (-code-b
        ```
        tipo_retorno nome_funcao(tipo_parametro parametro...) {
            codigo...
        }
        ```)

      ['ul
       ['li (-code-i `tipo_retorno`) ` é o tipo que a função retorna;`]
       ['li (-code-i `nome_funcao`) ` é o nome da função;`]
       ['li (-code-i `parametro`) ` é um parâmetro da função (algo que você passa pra ela, entre os parênteses - o ` (-code-i `x`) ` em ` (-code-i `f(x)`) `);`]
       ['li (-code-i `tipo_parametro`) ` é o tipo do parametro ` (-code-i `parametro`) `;`]
       ]

      # TODO: exemplo: vários argumentos
      # TODO: return, e quando usar o printf vs. o return
      # TODO: comportamento de funções (call stack, mas sem precisar explicar um stack)
      # TODO: exemplo: funções com void
      # TODO: protótipos
     ) # >>>

    (-fold {} (-summary 2 `funções: por que usar? (modularização)`) # <<<
      ['p ['i `Os exemplos desse capítulo são completos porque a gente vai mexer com coisas "fora" do ` (-code-i `main()`) `.`]]
      ['p `Como mencionado anteriormente, uma função é um pedaço de código que pode ser rodado várias vezes.`]
      ['p `Vamos explicar a importância delas com um exemplo - um programa que mostra um quadrado vazado, 5x5:`]
      (-code-b
        ```
        #include <stdio.h>

        int main() {
            int i, j;

            // mostrar o topo do quadrado (1 linha)
            for (i = 0; i < 5; i++)
                printf("*");
            printf("\n");

            // mostrar o meio do quadrado (3 linhas)
            for (i = 0; i < 3; i++) {
                printf("*");
                for (j = 0; j < 3; j++)
                    printf(" ");
                printf("*\n");
            }

            // mostrar o topo do quadrado (1 linha)
            for (i = 0; i < 5; i++)
                printf("*");
            printf("\n");
        }
        ```)

      ['p `Ao rodar esse programa, a saída é:`]

      (-code-b
        ```
        *****
        *   *
        *   *
        *   *
        *****
        ```)

      ['p `Esse código tem cara de meio confuso, né? É difícil ler de cara o que ele faz. A gente pode adicionar comentários e tal, mas se
      começarmos a criar funções, conseguimos chegar a um nível ainda maior de "código compreensível", e conseguimos também diminuir a
      repetição de código.`]

      ['p `Vamos criar uma função para mostrar uma linha de asteriscos, chamada ` (-code-i `mostrarLinha`) `:`]

      (-code-b
        ```
        void mostrarLinha(int tamanho) {
            int i;
            for (i = 0; i < tamanho; i++) {
                printf("*");
            }
            printf("\n");
        }
        ```)

      ['p `Para usar ela, basta escrever, por exemplo, ` (-code-i `mostrarLinha(5)`) `, e ele vai mostrar uma linha com `
       (-code-i `tamanho=5`) `.`]

      ['p `Ao fazer isso, o código fica muito mais simples:`]

      (-code-b
        ```
        #include <stdio.h>

        void mostrarLinha(int tamanho) {
            int i;
            for (i = 0; i < tamanho; i++) {
                printf("*");
            }
            printf("\n");
        }

        int main() {
            int i, j;

            mostrarLinha(5);

            // mostrar o meio do quadrado (3 linhas)
            for (i = 0; i < 3; i++) {
                printf("*");
                for (j = 0; j < 3; j++)
                    printf(" ");
                printf("*\n");
            }

            mostrarLinha(5);
        }
        ```)

      ['p `E dá pra melhorar! Se a gente criar uma para mostrar as linhas vazadas também:`]

      (-code-b
        ```
        #include <stdio.h>

        void mostrarLinha(int tamanho) {
            int i;
            for (i = 0; i < tamanho; i++) {
                printf("*");
            }
            printf("\n");
        }

        void mostrarLinhaVazada(int tamanho) {
            int i;
            printf("*");
            for (i = 0; i < tamanho - 2; i++) {
                printf(" ");
            }
            printf("*");
            printf("\n");
        }

        int main() {
            int i;

            mostrarLinha(5);
            for (i = 0; i < 3; i++) mostrarLinhaVazada(5);
            mostrarLinha(5);
        }
        ```)

      ['p `Eu diria que um dos melhores benefícios de criar funções é que você ` ['b `modulariza`] ` o programa. Você consegue separar o `
       `programa em pedaços pequenos que você consegue utilizar quando quiser, quantas vezes quiser, na ordem que quiser. E ainda você `
       ` acaba não misturando as variáveis, porque o ` (-code-i `i`) ` em ` (-code-i `mostrarLinha`) ` não é o mesmo ` (-code-i `i`) ` de `
       (-code-i `mostrarLinhaVazada`) `.`]

      ['p `Inclusive, talvez a explicação de argumentos não tenha sido muito boa até agora. As coisas que você passa entre os parênteses, `
       `ao usar a função, vai para as variáveis na função, entre os parênteses também. Então, quando você faz `
       (-code-i `mostrarLinha(5)`) `, ele roda o código dentro de ` (-code-i `mostrarLinha`) `, com ` (-code-i `tamanho`) ` sendo igual a `
       (-code-i `5`) `.`]
     ) # >>>

    (-fold {} (-summary 2 `estudo de caso: expressões mais complexas`) # <<<
      ['p `Tenhamos um pequeno exemplo - vamos tentar analisar ele para ver o que está acontecendo:`]
      (-code-b
        ```
        #include <stdio.h>

        int dobro(int x) {
            return x * 2;
        }

        int metade(int x) {
            return x / 2;
        }

        int main() {
            int x = 4;
            printf("%d\n", dobro(5) + metade(x + 2));
        }
        ```)
      ['p `Se você rodar esse código, o resultado é 13.`]
      ['p `O printf está sendo chamado com os argumentos: ` (-code-i `"%d\n"`) `, ` (-code-i `dobro(5) + metade(x + 2)`)]
      ['p `O argumento ` (-code-i `dobro(5) + metade(x + 2)`) ` precisa ser calculado - então (o computador) vai calcular ` (-code-i `dobro(5)`) ` e ` (-code-i `metade(x + 2)`) `, e depois somar:`]
      ['p (-code-i `dobro(5)`) ` tem como resultado 10;`]
      ['p (-code-i `metade(x+2)`) ` primeiro tem o x+2 calculado, que dá 6, e depois é calculado: ` (-code-i `metade(6)`) ` = 3;`]
      ['p `No fim das contas, temos 10 + 3, que dá 13.`]
      ['p `O printf então foi chamado com os argumentos: ` (-code-i `"%d\n"`) `, ` (-code-i `13`)]
      ['p `E então ele mostra um 13 na tela.`]
      ['p `Uma maneira de analisar expressões complexas assim é começar pelo que está mais dentro de parênteses (nesse caso o ` (-code-i `x + 2`) `) e ir seguindo a partir daí até chegar nos valores mais de fora.`]
    ) # >>>

    # TODO: bibliotecas, headers e include

    (-fold {} (-summary 2 `constantes`) # <<<
      ['p `Muitas vezes, ao escrever código, temos valores que não queremos que sejam alterados. Geralmente, podemos fazer que isso seja uma realidade usando as ` ['b `constantes`] `.`]

      ['p `Como exemplo, vejamos o código:`]
      (-code-b
        ```
        int quant_elementos = 5;
        int elementos[quant_elementos];

        // vamos preencher o array `elementos` com números
        for (int i = 0; i < quant_elementos; i++) {
            elementos[i] = i;
        }

        // whoops!
        quant_elementos = 20;

        // vamos agora mostrar os elementos
        for (int i = 0; i < quant_elementos; i++) {
            printf("%d ", elementos[i]);
        }
        printf("\n");
        ```)
      ['p ['small `Eu devo admitir que esse exemplo não é muito prático, já que não teve motivo para mudar o quant_elementos (eu mudei só pra mostrar o problema mesmo), mas ainda assim...`]]
      ['p `O resultado vai ser algo como isso aqui:`]
      (-code-b
        ```
        0 1 2 3 4 32676 0 0 0 0 0 5 12 20 4 0 736875264 32766 -761248256 -543001068
        ```)
      ['p `Isso aconteceu porque criamos um array de 5 elementos, mas depois mudamos o tamanho para 20 elementos. Isso é um problema que devemos perceber, mas uma maneira de fazer o compilador ajudar a gente a não cometer erros como esse é utilizando constantes.`]
      ['p `Temos dois métodos para constantes em C: utilizando a palavra-chave ` ['code `const`] ` ou a diretiva ` ['code `#define`] `.`]

      ['hr]

      ['p `Com o ` ['code `const`] ` nós fazemos uma variável não poder ser alterada, tendo o mesmo valor desde o início.`]
      (-code-b
        ```
        const int x = 5;
        x = 8; // isso aqui dá erro!
        ```)
      ['p `Aplicando isso ao código original:`]
      (-code-b
        ```
        const int quant_elementos = 5;
        int elementos[quant_elementos];

        // vamos preencher o array `elementos` com números
        for (int i = 0; i < quant_elementos; i++) {
            elementos[i] = i;
        }

        // isso aqui vai dar erro, forçando a gente a não fazer isso
        quant_elementos = 20;

        // vamos agora mostrar os elementos
        for (int i = 0; i < quant_elementos; i++) {
            printf("%d ", elementos[i]);
        }
        printf("\n");
        ```)

      ['hr]

      ['p `Com o ` ['code `#define`] ` nós não estamos nem criando uma variável - o que é criado é na verdade um macro, que é um nome especial que é substituído pelo seu valor em qualquer lugar que você usar. Faríamos, então:`]
      (-code-b
        ```
        #define X 5

        int main() {
            X = 8; // isso aqui dá erro! mas o erro é mais críptico
            return 0;
        }
        ```)
      ['p `No original, ficaria:`]
      (-code-b
        ```
        #define QUANT_ELEMENTOS 5

        int elementos[QUANT_ELEMENTOS];

        // vamos preencher o array `elementos` com números
        for (int i = 0; i < quant_elementos; i++) {
            elementos[i] = i;
        }

        // isso aqui vai dar um erro críptico que previne que o código compile
        QUANT_ELEMENTOS = 20;

        // vamos agora mostrar os elementos
        for (int i = 0; i < quant_elementos; i++) {
            printf("%d ", elementos[i]);
        }
        printf("\n");
        ```)
      ['p `Lembre-se que macros sempre podem ser usados em qualquer função, e que eles não são variáveis propriamente ditas e por isso podem causar alguns erros de sintaxe confusos.`]

      ['hr]

      ['p `Qual se deve usar então?`]
      ['p `Eu não tenho uma opinião muito definida sobre isso, mas em geral eu recomendaria usar const, e só usar o define caso for necessário - e costumam haver várias situações onde o define pode ser necessário ou pelo menos mais útil, mas se você quer só um valor que não possa ser alterado eu acho que vale mais a pena usar o const.`]
      # FIXME: mds explicação confusa.
      ) # >>>

    # TODO: nested function calls (srand(time(0)) é o mesmo que a=0, b=time(a), srand(b))
    # TODO: if ternário

    (-fold {:id "s-time"} (-summary 2 `obtendo o tempo atual (com time())`) # <<<
      ['p `Por agora essa explicação de tempo aqui é só algo simples p/ poder usar com números aleatórios.`]
      ['p `Uma das maneiras mais básicas de obter informação sobre o tempo em C é usar a função ` (-code-i `time()`) `, disponível no header ` (-code-i `time.h`) `.`]
      ['p `Eu peguei um protótipo dessa função (encontrei em ` (-code-i `/usr/include/time.h`) ` no meu computador) e simplifiquei:`]

      (-code-b ```
               /* Retorna o tempo atual (em segundos) e coloca em *x se x não for NULL. */
               time_t time(time_t *x);
               ```)

      ['p `Basicamente, ela é uma função que, quando chamada, retorna um ` (-code-i `time_t`) ` indicando o tempo, em forma de número (a quantidade de segundos passada desde ... 1 de janeiro de 1970, se eu não me engano).`]

      ['p `Esse ` (-code-i `time_t`) ` é um ` ['i `alias`] `("apelido") de um número inteiro, então se tiver tendo dificuldade pra entender basta trocar ` (-code-i `time_t`) ` por ` (-code-i `int`) ` na cabeça.`]

      ['p `Um programa simples que mostraria a quantidade de segundos atual é:`]

      # TODO: confirmar isso aqui
      (-code-b
        ```
        time_t s;
        s = time(NULL);
        printf("Segundos: %d\n", s);
        ```)

      ['p `Se você parar pra ver, aqui eu estou passando um ` (-code-i `NULL`) `. Ele basicamente indica que não é para o ` (-code-i `time()`) ` fazer nada de "colocar em *x" (como tem no texto lá em cima) e é só para retornar o valor. Mas, se você fizer:`]

      (-code-b
        ```
        time_t s;
        time(&s);
        printf("Segundos: %d\n", s);
        ```)

      ['p `Aqui você vai estar passando o ` (-code-i `&`) ` (endereço) da variável ` (-code-i `s`) ` e isso vai fazer com que o ` (-code-i `time()`) ` coloque o valor nela, mesmo sem você ter usado o ` (-code-i `=`) `. É tipo o ` (-code-i `scanf()`) `.`]

      ['p `Curiosidade: você poder usar tanto ` (-code-i `x = time(NULL)`) ` quanto ` (-code-i `time(&x)`) ` é na verdade um legado de versões muito, muito velhas de C. Não vou explicar aqui mas consulte <a href="https://stackoverflow.com/questions/61432103/why-does-stdtime-have-an-unnecessary-parameter">essa pergunta no StackOverflow</a> se tiver com curiosidade.`]
      ) # >>>

    (-fold {} (-summary 2 `geração de números aleatórios (com rand())`) # <<<
      ['p `Alguns tipos de programa precisam fazer coisas aleatórias acontecerem (como sortear cartas em um baralho, ou rolar um dado). Em computadores, podemos fazer algo parecido através da geração de números aleatórios.`]

      ['p `Para gerar números aleatórios podemos utilizar a função ` (-code-i `rand()`) `, disponível em ` (-code-i `stdlib.h`)]

      ['p `Essa função gera um número entre 0 e ` (-code-i `RAND_MAX`) `, que é uma constante que também fica em ` (-code-i `stdlib.h`) `. O valor dela é geralmente... 36727? alguma coisa assim.`]

      ['p `Enfim. Vejamos esse código:`]

      (-code-b
        ```
        printf("%d\n", rand());
        printf("%d\n", rand());
        printf("%d\n", rand());
        ```)

      ['p `Esse código mostra três números aleatórios. Legal? Mas tem um problema.`]

      ['p `Ao rodar esse código de novo... os números são os mesmos. Isso é porque o ` (-code-i `rand()`) `, como quase tudo em um computador, é um pedaço de código que sempre roda a mesma coisa.`]

      ['p `Eu não sei dizer a maneira específica como o ` (-code-i `rand()`) ` calcula os números (talvez não seja igual em todos os computadores), mas ele usa como base uma ` ['b `seed`] `. Uma maneira que eu gosto de usar pra explicar isso é com Minecraft. Quando você cria um mundo, você pode especificar uma seed e, se você criar vários mundos com a mesma seed, todos eles vão ser iguais (a início, pelo menos).`]

      ['p `Então: dois programas com a mesma ` ['b `seed`] ` geram a mesma sequência de números aleatórios.`]

      ['p `Para setar a seed de um programa, você pode usar o ` (-code-i `srand()`) `, também disponível no ` (-code-i `stdlib.h`) `.`]

      ['p `O problema é... o que você coloca na seed? Porque se você colocar uma seed fixa, vai ser a mesma sequência ainda.`]

      ['p `Pra isso, podemos usar o <a href="#s-time">` (-code-i `time()`) `</a>. Como expliquei anteriormente, ele retorna a quantidade de segundos, que é um valor que sempre tá aumentando, e por isso podemos usar isso como seed - toda vez que o programa rodar, a seed vai ser diferente, e então a sequência de números aleatórios vai ser diferente.`]

      (-code-b
        ```
        srand(time(0));
        printf("%d\n", rand());
        printf("%d\n", rand());
        printf("%d\n", rand());
        ```)

      ['p `Agora funciona.`]
      ) #>>>

    # TODO: pointers

    (-fold {} (-summary 2 `o stack e seus limites`) # <<<
      ['p `Quando um programa está rodando, ele tem uma região na memória chamada de "stack", o que traduz para português como "pilha".`]
      ['p `E esse nome é uma boa analogia mesmo - o jeito que isso é usado é que nele ficam salvos as variáveis atuais e, quando alguma função é chamada, é colocado no stack o lugar para onde o processador deve voltar depois de executar a função, e também é colocada as variáveis da nova função que vai ser criada.`]
      # FIXME: uma explicação melhor e mais concisa (talvez gráfica?)

      ['p `O problema do stack é que ele não é muito flexível - como ele está sendo modificado constantemente, e sendo usado do jeito que ele é usado, ter valores muito grandes ou que mudam de tamanho não é muito eficiente, e portanto é comum a memória do stack ser bem pequena.`]
      (-small-note-p `Por "pequena" eu quero dizer "pequena comparada à memória total", porque na minha máquina (12GB RAM) cada programa parece ter em média 8MB de memória reservada para o stack.`)

      ['p `Por causa disso, quando um programa precisa de muita memória, ou até mesmo só de uma memória que mude de tamanho, o heap é uma região muito mais útil.`]
      ) # >>>

    (-fold {} (-summary 2 `o heap e alocação de memória`) # <<<
      ['p `O heap é o nome dado à região de um programa que é controlada por alocadores.`]
      (-small-note-p `Dando uma pesquisada eu também descobri que o heap é o nome de uma estrutura de dados! Não vou falar sobre ela porque eu honestamente não sei como ela funciona...`)

      ['p `Um alocador, por sua vez, é o responsável por "achar" partes livres da memória que podem ser usadas para o programa fazer algo. Por causa disso, o heap é muito mais dinâmico que o stack, e tem uma flexibilidade que permite um programa usar muito mais memória que outro, e que isso mude ao decorrer desses programas.`]

      ['p `Em C, isso é primariamente feito pelas funções malloc(), realloc() e free(), que estão disponíveis no <stdlib.h>.`]

      ['p `Um exemplo:`]
      (-code-b
        ```
        #include <stdio.h>
        #include <stdlib.h>

        int main(void) {
            // criando o array usando malloc()
            const int tamanho = 64;
            int *arr = malloc(tamanho * sizeof(int));

            // colocando vários elementos no array (e mostrando eles)
            for (int i = 0; i < tamanho; i++) {
                arr[i] = i*2;
                printf("Elemento %d: %d\n", i, arr[i]);
            }

            // liberando o array com free()
            free(arr);
        }
        ```)

      ['p `Aqui estamos criando um array de tamanho (64) elementos, utilizando o malloc.`]
      ['p `A função malloc() recebe um único argumento, que é a quantidade de bytes a serem alocados.`]
      ['p `O sizeof(int) retorna o tamanho do tipo int, que é 4 bytes (na minha máquina, pelo menos).`]
      ['p `Como estamos multiplicando o tamanho por sizeof(int), estamos alocando 4 bytes para cada elemento.`]
      ['p `O resultado é retornado em forma de um ponteiro, que colocamos na variável arr.`]

      ['p `Logo depois, estamos passando pelo array e preenchendo seus elementos (o dobro do valor do índice), e mostrando na tela.`]

      ['p `Por último, nós usamos o free() para sinalizar que a memória para onde arr aponta não vai ser mais usada por nós (e que outro programa pode usar).`]

      # TODO: ênfase no conceito de memory leaks e como um programa pode acabar acumulando memória usada por esse fenômeno e atrapalhar o funcionamento do sistema
      # TODO: falar sobre realloc()
      ) # >>>

    (-fold {} (-summary 2 `structs`) # <<<
      ['p `Structs são uma maneira de criar tipos de dados mais ` ['i `estruturados`] ` em C. Um exemplo pode ajudar:`]
      (-code-b
        ```
        struct Pessoa {
            int codigo;
            char *nome;
        };
        ```)
      ['p `Acima criamos um struct ` (-code-i `Pessoa`) `, que podemos usar como tipo de variável. Esse struct possui campos - neste caso "codigo" e "nome", que são "sub-variáveis" de toda variável do tipo ` (-code-i `Pessoa`) `.`]
      ['p `Segue um exemplo de uso desse struct:`]
      (-code-b
        ```
        #include <stdio.h>

        struct Pessoa {
            int codigo;
            char *nome;
        };

        int main() {
            // inicializando a variável
            struct Pessoa p;
            p.codigo = 23;
            p.nome = "Ana Hita";

            // mostrando as informações na tela
            printf("Nome = %s, Código = %d\n", p.nome, p.codigo);
        }
        ```)
      ['p ['b `DETALHE: `] `para acessar um campo de uma variável-struct, usa-se o ` (-code-i `.`) `, como em ` (-code-i `p.codigo = 23`) `, que deu o valor 23 ao campo "codigo" de p.`]

      ) # >>>

    # TODO: typedefs
    # TODO: aplicação de números aleatórios: dados (sorteio)
    # TODO: aplicação de números aleatórios: números dentro de um intervalo
    # TODO: arrays ("vetores") (o que são, para que servem, como inicializar, exemploes, pointers, out of bounds, subscript, cálculo alternativo sem [])
    # TODO: documentação - a importância de comentar e fazer headers
    # TODO: documentação - pesquisando (online, man pages etc.)
    # TODO: expressões separada por vírgula (é desde C89? parece tão alien...)
    # TODO: funções recursivas
    # TODO: o que é o compilador
    # TODO: instalando o gcc (linux) ou outro
    # TODO: atualizar exemplos p/ C99 porque não tem fucking necessidade de C89
    )])

(def root
  (common/make-page
    :head head
    :body body))
