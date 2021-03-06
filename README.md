# uffstex

Classe de trabalhos acadêmicos da Universidade Federal da Fronteira Sul baseada em abnTeX2.

# Como utilizar?

Simplesmente coloque os arquivos `uffstex.cls` e `logo.png` na pasta do seu projeto LaTeX (local ou na web, como no Overleaf).

## Dependências

- Sua distribuição preferida de LaTeX (contendo `graphicx`, `indentfirst`, `lastpage`, `textcase`, `xparse` e `xpatch`)
- [abnTeX2](https://ctan.org/pkg/abntex2)
- Estilo ABNT para bibLaTeX ([biblatex-abnt](https://ctan.org/pkg/biblatex-abnt))

No caso do Tex Live, **recomenda-se fortemente** que seja utilizado o [instalador](https://www.tug.org/texlive/acquire-netinstall.html) disponibilizado pelo projeto ao invés dos pacotes disponíveis nos repositórios padrões do seu sistema operacional, pois ele possui as versões mais recentes das dependências do uffstex. Em geral, versões mais antigas ainda funcionam, mas podem apresentar comportamentos não esperados ou não testados.

## Uso local

Conhece o [latexmk](http://personal.psu.edu/jcc8/software/latexmk/)? Ele automatiza o processo de compilação. Por exemplo:

```sh
latexmk tcc.tex -pdf -pv
```

A opção `-pdf` gera o PDF, enquanto a `-pv` o abre automaticamente com o leitor padrão do sistema. Existe também a opção `-pvc` que fica continuamente compilando o arquivo a partir das mudanças feitas ao longo do tempo.

Uma maneira legal de separar a fonte do uffstex do seu projeto é por meio de links simbólicos. Por exemplo, se o repositório foi clonado na pasta `caminho/para/uffstex/` e seu projeto está em `caminho/para/projeto/`, você pode executar (no Linux):

```sh
ln -s caminho/para/uffstex/uffstex.cls caminho/para/projeto/
ln -s caminho/para/uffstex/logo.png caminho/para/projeto/
```

Deste modo, basta um `git pull` para atualizar sua versão do uffstex e não há interferência com um possível repositório do seu próprio projeto.

## Mais informações

Este é um projeto em construção. Por enquanto não há documentação, mas o código do exemplo ([`exemplos/tcc.tex`](exemplos/tcc.tex)) está bem completo e comentado. Comece por lá!
O que não estiver documentado no exemplo ou no código da classe pode ser consultado na documentação do [abnTeX2](https://ctan.org/pkg/abntex2). As regras da UFFS para elaboração de trabalhos acadêmicos pode ser consultada [aqui](https://www.uffs.edu.br/campi/chapeco/biblioteca/normalizacao-de-trabalhos).

# Como contribuir

Queremos sua ajuda! Contribua utilizando, testando, reportando *issues* e discutindo (com respeito). Assim como documentação, ainda não temos *guidelines*, mas **quem quiser também será bem-vindo a tornar-se um contribuinte regular via *pull requests* ou como parte da equipe!**
