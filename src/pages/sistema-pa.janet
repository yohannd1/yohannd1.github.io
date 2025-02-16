(import ../common)

(def -fold common/make-fold)
(def -table-simple common/make-table-simple)
(def -summary common/make-summary)
(def -link common/make-link)

(def- head
  [
   ['title `Sistema Axiomático Pa (Lógica)`]
   ])

(def- body
  [
   (-fold {:open true} (-summary 1 `Sistema Axiomático Pa (Lógica)`)
     ['p {:style "font-style: italic;"} `Uma tentativa de tentar entender como isso funciona.`]

     (-fold {:open true} (-summary 2 `Definições`)
       ['p `Antes de tudo é bom a gente ter algumas definições em mente.`]
       ['p `TODO: o que é Pa??`]

       (-fold {:open true}
         ['summary ['b `Axioma`] ` :: uma "afirmação" que é considerada verdadeira não porque pode ser provada, mas porque foi decidido que ela é verdadeira.`]
         ['p `Em um sistema, um axioma é usado como a base para todo o funcionamento do sistema.`]
         ['p `Exemplo: eu não acho que 1+1=2 é um axioma, exatamente, mas ele pelo menos funciona com base em algum, porque a soma entre números não é algo que existe exatamente na natureza... ela foi inventada para poder auxiliar nos cálculos.`]))

     ['p `O método "Pa" é um método ` ['b `puramente sintático`] `, em contraste a alguns outros.`]
     ['p `TODO: eu não sei exatamente o que isso implicaria. Mas dá a ideia de que, mesmo sabendo que uma coisa implica em outra, você não pode simplesmente pular para aquilo, e tem que usar somente as regras definidas para esse método.`]

     (-fold {:open true} ['summary `Antes de tudo, vamos definir ` ['b `implicação`] `:`]
       ['p `Tenhamos um conjunto de fórmulas C, e uma fórmula H.`]
       ['p `Ao dizer "C |- H", estamos afirmando que, sabendo que as fórmulas de C são verdadeiras, a fórmula H também será verdadeira.`]
       ['p `As fórmulas presentes em C são chamadas de ` ['b `hipóteses`] `.`]

       (-fold {:open true} ['summary `Exemplo: C = {A -> B, A} e H = B`]
         ['p `Ao dizer "C |- H", estamos afirmando que {A -> B, A} |- B`]
         ['p `Ou seja, se I[A -> B] = T e I[A] = T, então I[B] = T`])

       ['p `Mas, se dissermos "|- H", estaremos afirmando que H é verdadeira, sem precisar saber de outras coisas - ou seja, H é sempre verdade, uma tautologia.`]

       (-fold {:open true} ['summary `Exemplo: H = P v ¬P`]
         ['p `Ao dizer "|- H", estamos afirmando que |- P v ¬P`]
         ['p `Ou seja, I[P v ¬P], para qualquer I.`]
         ['p `E essa afirmação está correta porque se I[P] = F, vamos ter [false v ¬false] = [false v true] = true`]
         ['p `E, se I[P] = T, vamos ter [true v ¬true] = [true v false] = true`]
         )

       (-fold {:open true} `O sistema Pa tem três axiomas "base":`
         ['p `Ax1: |- (H v H) -> H`]
         ['p `Ax2: |- G -> (H v G)`]
         ['p `Ax3: |- (H v G) -> ((E v H) -> (E v G))`]
         ['p `Note como todas essas "afirmações" são no formato "|- H". Como falei anteriormente, isso quer dizer que elas são sempre verdades - ou seja, tautologias, e portanto podem ser usadas em qualquer situação.`]
         (-fold {:open true} `TODO: tentar explicar intuitivamente cada um dos axiomas`
           ['p `TODO: E PORQUE ESCOLHERAM ESSES? PARECE HORRIVEL`])
         )

       ['p `Além dos três axiomas apresentados, ainda há algumas regras disponíveis:`]

       (-fold {} (-summary 2 `Modus Ponens`)
         ['p `Na verdade eu já acabei mostrando ela como exemplo, mas vou definir ela mais formalmente:`]
         ['p `Tenhamos duas fórmulas, H e G.`]
         ['p `i. H`]
         ['p `ii. H -> G`]
         ['p `iii. Portanto, G`]
         ['p `Explicação intuitiva: se sabemos que H implica G, e sabemos que H é verdadeiro, então G tem que ser verdadeiro.`]
         )

       (-fold {} (-summary 2 `Regra da substituição`)
         ['p `Tenhamos um conjunto de fórmulas C, e uma conclusão H, tal que C |- H.`]
         ['p `Se H não possui nenhum símbolo proposicional presente em C, então podemos também dizer que |- H, porque H é verdadeiro independentemente de C ser verdade ou não.`]

         (-fold {} `Exemplo: C = {P -> Q}, H = R v ¬R`
           ['p `P -> Q não tem como nos ajudar a concluir que R v ¬R, porque nem fala sobre R - fala sobre P e Q.`]
           ['p `Portanto, R v ¬R é verdade, mas não por causa que P -> Q é verdade, e portanto podemos concluir |- R v ¬R.`])

         ['p `E, quando sabemos que |- H, ao trocarmos qualquer símbolo presente em H por qualquer coisa, |- H ainda vai ser verdadeiro.`]

         (-fold {} `Exemplo: |- (P ^ (P -> Q)) -> Q`
           ['p `Dizer que isso é verdade é dizer que, se I[P] = T e I[P -> Q] = T, então I[Q] = T. E faz sentido (é o modus ponens!)`]
           ['p `E, se você trocar P por X e Q por J, teremos |- (X ^ (X -> J)) -> J, que ainda faz sentido.`])

           ['p `A regra da substituição pode ser, de certo modo, considerada um dos princípios (se não "o princípio") da álgebra, eu acho, que é que, quando você tem uma ` ['i `variável livre`] ` em uma afirmação, se vocẽ trocar ela por qualquer outra coisa (a grosso modo) a afirmação ainda vai ser verdadeira.`]
           ['p `Exemplo: x² > 0. Se você trocar x por 1, é verdade. Se trocar por -1, é verdade.`])
       )

     (-fold {:open true} (-summary 2 `Usando o sistema Pa para provar coisas`)
       ['p `Para usar esse sistema para provar a afirmação C |- H, você basicamente faz uma lista numerada de afirmações, até conseguir afirmar C |- H.`]
       ['p `Lembrando que, se a afirmação é |- H, é a mesma coisa que dizer que C é vazio (C = {})`]

       ['p `As afirmações podem ser:`]
       ['p `- Um modus ponens de duas afirmações anteriores;`]
       ['p `- Uma das hipóteses disponíveis (no conjunto C, ou, no caso de uma questão, que o professor disponibilizou);`]
       ['p `- Um dos três axiomas (você pode usar a regra da substituição para trocar os H/G/E de lá);`]

       ['p `Lembre sempre de anotar quais passos foram feitos naquela linha (geralmente à direita).`]

       (-fold {} `Exemplo: C |- R, onde C = {P, P -> (Q -> R), (Q v Q)}`
         (-table-simple
           nil
           [`1.` `C |- P` `do conjunto C`]
           [`2.` `C |- (Q v Q)` `do conjunto C`]
           [`3.` `C |- (Q v Q) -> Q` `Ax1, onde H = Q`]
           [`4.` `C |- Q` `Modus ponens de 2. e 3.`]
           [`5.` `C |- P -> (Q -> R)` `do conjunto C`]
           [`6.` `C |- Q -> R` `Modus ponens de 1. e 5.`]
           [`7.` `C |- R` `Modus ponens de 4. e 6.`]
           )
         ['p `c.q.d.`]))

     (-fold {:open true} (-summary 2 `Bibliografia`)
       ['p `- Aulas na universidade [...]`]
       ['p `- ` (-link `https://pt.wikipedia.org/wiki/Axioma` `Axiomas - Wikipédia`)]
       ['p `- ` (-link `https://www.facom.ufu.br/~logica/apresenta%E7%F5es%20de%20l%F3gica/Capitulo6.ppt` `"Capítulo 6" - Lógica para Computação`)]
       ['p `- ` (-link `https://www.yumpu.com/pt/document/read/14383267/um-sistema-axiomatico-na-logica-proposicional-universidade-` `"Um sistema axiomático na lógica proposicional"`)]
       )
     )
   ])

(def root
  (common/make-page
    :head head
    :body body))
