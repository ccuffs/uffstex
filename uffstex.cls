%%
%% Customizações do abnTeX2 (https://www.abntex.net.br/)
%% para a Universidade Federal da Fronteira Sul (UFFS).
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is the ccuffs team.
%%
%% This work consists of the file uffstex.cls.
%%
%% Further information about abnTeX2 is available on https://www.abntex.net.br/.
%% Further information about ccuffs is available on https://ccuffs.github.io/.
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uffstex}[2018/11/18 v0.7.0]

% ==============================================================================
% Carregando pacotes necessários
% ==============================================================================
\RequirePackage{xparse}
\RequirePackage{xpatch}
\RequirePackage{graphicx}
\RequirePackage{lastpage}
\RequirePackage{textcase}
% pacote indentfirst certifica que sempre haverá
% identação de parágrafo na 1a linha de um novo parágrafo
\RequirePackage{indentfirst}

% ==============================================================================
% Opções padrão para o abntex2
% ==============================================================================
% para controlar onde um capítulo pode iniciar: openleft, openright, openany
% para indicar impressão apenas em anverso ou anverso e verso: oneside, twoside
\PassOptionsToClass{
    12pt,
    a4paper,
    openright,
    twoside,
    brazil,
    chapter=TITLE, % capitaliza títulos primários no texto
    section=TITLE % capitaliza títulos secundários no texto
}{abntex2}

% ==============================================================================
% Declaração das opções da classe
% ==============================================================================

% \AtEndOfClass é utilizado para adiar a execução
% do código até o final do processamento desta classe
% pois o comando \ABNTEXchapterfont é definido pelo
% abntex2, a qual não está carregada neste momento
%
% opção "serif" para redefinir o estilo dos variados
% títulos do abntex2 com família de fontes serifadas
\DeclareOption{serif}{
    \AtEndOfClass{\renewcommand{\ABNTEXchapterfont}{\rmfamily\bfseries}}
}

% \DeclareOption* lida com os comandos não explicitamente
% especificados nesta classe e então os repassa para a
% classe abntex2
\DeclareOption*{
    \PassOptionsToClass{\CurrentOption}{abntex2}
}

\ProcessOptions\relax

\LoadClass{abntex2}

% ==============================================================================
% "Constantes"
% ==============================================================================
\providecommand*{\algoritmoext}{loalg}

% ==============================================================================
% Patches
% ==============================================================================
% patch pra deixar seções em caixa alta no sumário
% (cortesia de Lars Andersen, da classe Memoir)
\xpatchcmd{\H@old@sectm@m}{\fi#7}{%
    \fi\ifnum#2=1\relax\texorpdfstring{\MakeTextUppercase{#7}}{#7}\else#7\fi%
}{%
    \ClassInfo{uffstex}{patch para seções secundárias em caixa alta no
    sumário aplicado com sucesso}%
}{%
    \ClassWarning{uffstex}{patch para seções secundárias em caixa alta no
    sumário falhou}%
}

% patch para deixar apenas o número da página no cabeçalho
\xpatchcmd{\textual}{\pagestyle{abntheadings}}{\pagestyle{simple}}{%
  \ClassInfo{uffstex}{patch para cabeçalho simples de página
  aplicado com sucesso}%
}{%
  \ClassWarning{uffstex}{patch para cabeçalho simples de página falhou}%
}

% ==============================================================================
% Configurações de tamanhos e comprimentos
% ==============================================================================
% tamanho da indentação de novo parágrafo
\setlength{\parindent}{1.25cm}

% espaçamento entre títulos e texto (até seção quinária)
\setlength{\afterchapskip}{\baselineskip}
\setlength{\aftersecskip}{\baselineskip}
\setlength{\aftersubsecskip}{\baselineskip}
\setlength{\aftersubsubsecskip}{\baselineskip}
% (abnTeX2 define \subsubsubsection como \paragraph)
\setlength{\afterparaskip}{\baselineskip}

% remove espaço vertical que antecede uma seção primária no sumário
\setlength{\cftbeforechapterskip}{0cm}

% ==============================================================================
% Localização
% ==============================================================================
% português do Brasil
% por mais que especifiquemos "brazilian" como opção global,
% o abntex2 passa a opção "brazil" pro babel...
\addto\captionsbrazil{
  \providecommand*{\campusname}{campus de}
  \providecommand*{\cursoname}{curso de}
  \providecommand*{\bacharelname}{Bacharel}
  \providecommand*{\licenciaturaname}{Licenciatura}
  \providecommand*{\bancaname}{banca avaliadora}
  \providecommand*{\declaracaoaprovacao}{Este trabalho de conclus\~ao de curso
    foi defendido e aprovado pela \bancaname\ em:}
  \providecommand*{\algoritmoname}{Algoritmo}
  \providecommand*{\listalgoritmoname}{Lista de \algoritmoname{}s}
}
\addto\extrasbrazil{
  \instituicao{Universidade Federal da Fronteira Sul}
  % texto "natureza do trabalho"; está um pouco diferente
  % do modelo da normalização de trabalhos da universidade...
  % como fica o título de quem fez licenciatura?
  \preambulo{Trabalho de conclus\~ao de curso apresentado %
      como requisito para obten\c{c}\~ao do grau de \imprimirgrau\ em %
      \imprimircurso\ da \imprimirinstituicao.}
}

% inglês
\addto\captionsenglish{
  \renewcommand*{\campusname}{campus of}
  \renewcommand*{\cursoname}{course of}
  \renewcommand*{\orientadorname}{Advisor:}
  \renewcommand*{\coorientadorname}{Co-advisor:}
  \renewcommand*{\bacharelname}{Bachelor}
  % "Licenciate" foi o mais próximo que encontrei,
  % mas pode não significar a mesma coisa que no Brasil:
  % https://www.merriam-webster.com/dictionary/licentiate
  % https://en.oxforddictionaries.com/definition/licentiate
  % https://en.wikipedia.org/wiki/Licentiate_(degree)
  \renewcommand*{\licenciaturaname}{Licenciate}
  \renewcommand*{\folhadeaprovacaoname}{Approval sheet}
  \renewcommand*{\bancaname}{examination committee}
  \renewcommand*{\declaracaoaprovacao}{This final undergraduate work
    was defended and approved by the \bancaname\ on:}
  \renewcommand*{\algoritmoname}{Algorithm}
  \renewcommand*{\listalgoritmoname}{List of \algoritmoname{}s}
}
\addto\extrasenglish{
  \instituicao{Federal University of Fronteira Sul}
  \preambulo{Final undergraduate work submitted as %
      requirement to obtain the \imprimirgrau's degree in %
      \imprimircurso\ from \imprimirinstituicao.}
}

% ==============================================================================
% Comandos de dados
% ==============================================================================
% Versões com * das definições de comandos são recomendadas
% quando os parâmetros não são parágrafos inteiros
\newcommand*{\uffstex}{UFFS\TeX}

\providecommand*{\hoje}{\the\year-\the\month-\the\day}

\newcommand*{\imprimircampusRotulo}{\campusname}

\providecommand*{\imprimirgrau}{\bacharelname}
\providecommand*{\licenciatura}{\renewcommand*{\imprimirgrau}{\licenciaturaname}}
\newcommand*{\grau}[1]{\renewcommand*{\imprimirgrau}{#1}}

\newcommand*{\imprimircursoRotulo}{\cursoname}
\providecommand*{\imprimircurso}{}
\newcommand*{\curso}[1]{\renewcommand*{\imprimircurso}{#1}}

\providecommand*{\imprimirsubtitulo}{}
\newcommand*{\subtitulo}[1]{\renewcommand*{\imprimirsubtitulo}{#1}}

% palavras-chave
\newcounter{pccounter}
\NewDocumentCommand \palavrachave { m }{
    \ifthenelse{\value{pccounter} < 5}{
        \addtocounter{pccounter}{1}
        \expandafter\newcommand\csname palavrach\alph{pccounter}\endcsname{#1}
    }{
        \ClassWarning{uffstex}
        {Voc\^e excedeu o limite de 5 palavras-chave. Apenas 5 ser\~ao exibidas}
    }
}

% ==============================================================================
% Fontes padrões dos títulos até seção quinária (texto e sumário)
% ==============================================================================
% controle de caixa alta é feito aparte
% capítulo no texto (negrito e caixa alta)
\renewcommand{\ABNTEXchapterfont}{\sffamily\bfseries}
\renewcommand{\ABNTEXchapterfontsize}{\normalsize}
% capítulo no sumário
\renewcommand{\cftchapterfont}{\ABNTEXchapterfont}
\renewcommand{\cftchapterpagefont}{\cftchapterfont}

% seção no texto (normal e caixa alta)
\renewcommand{\ABNTEXsectionfont}{\ABNTEXchapterfont\mdseries}
\renewcommand{\ABNTEXsectionfontsize}{\normalsize}
% seção no sumário
\renewcommand{\cftsectionfont}{\ABNTEXsectionfont}
\renewcommand{\cftsectionpagefont}{\cftsectionfont}

% subseção no texto (negrito e caixa baixa; reutiliza fonte do capítulo)
\renewcommand{\ABNTEXsubsectionfont}{\ABNTEXchapterfont}
\renewcommand{\ABNTEXsubsectionfontsize}{\normalsize}
% subseção no sumário
\renewcommand{\cftsubsectionfont}{\ABNTEXsubsectionfont}
\renewcommand{\cftsubsectionpagefont}{\cftsubsectionfont}

% sub-subseção no texto (normal e caixa baixa; reutiliza fonte da seção)
\renewcommand{\ABNTEXsubsubsectionfont}{\ABNTEXsectionfont}
\renewcommand{\ABNTEXsubsubsectionfontsize}{\normalsize}
% sub-subseção no sumário
\renewcommand{\cftsubsubsectionfont}{\ABNTEXsubsubsectionfont}
\renewcommand{\cftsubsubsectionpagefont}{\cftsubsubsectionfont}

% sub-sub-subseção no texto (itálico e caixa baixa; reutiliza fonte da seção)
\renewcommand{\ABNTEXsubsubsubsectionfont}{\ABNTEXsectionfont\itshape}
\renewcommand{\ABNTEXsubsubsubsectionfontsize}{\normalsize}
% sub-sub-subseção no sumário
\renewcommand{\cftparagraphfont}{\ABNTEXsubsubsubsectionfont}
\renewcommand{\cftparagraphpagefont}{\cftparagraphfont}

% ==============================================================================
% Capa
% ==============================================================================
\renewcommand{\imprimircapa}{
    \begin{capa}
        \centering
        \ABNTEXchapterfont

        % a logo deveria ser 20mm x 20mm, mas
        % daí vai distorcer... colocando só
        % altura, o LaTeX escala a largura
        \includegraphics[height=20mm]{logo.png}

        \vspace{1cm}

        \MakeTextUppercase{\imprimirinstituicao}\\
        \MakeTextUppercase{\imprimircampusRotulo\ \imprimirlocal}\\
        \MakeTextUppercase{\imprimircursoRotulo\ \imprimircurso}

        \vspace{3cm}

        \MakeTextUppercase{\imprimirautor}

        \vspace{5cm}

        \MakeTextUppercase{\imprimirtitulo}
        \abntex@ifnotempty{\imprimirsubtitulo}{
            \\\textmd{\MakeTextUppercase{\imprimirsubtitulo}}
        }

        \vspace{\fill}

        \MakeTextUppercase{\imprimirlocal}\\
        \the\year
    \end{capa}
}

% ==============================================================================
% Folha de rosto
% ==============================================================================
\renewcommand{\folhaderostocontent}{
    \centering
    \ABNTEXchapterfont

    \MakeTextUppercase{\imprimirautor}

    \vspace{6cm}

    \MakeTextUppercase{\imprimirtitulo}
    \abntex@ifnotempty{\imprimirsubtitulo}{
        \\\textmd{\MakeTextUppercase{\imprimirsubtitulo}}
    }

    \vspace{2cm}

    \abntex@ifnotempty{\imprimirpreambulo}{
        \hspace*{0.49\textwidth}
        \begin{minipage}{0.5\textwidth}
            \mdseries
            \footnotesize
            \SingleSpacing

            \imprimirpreambulo

            \imprimirorientadorRotulo\ \imprimirorientador
            \abntex@ifnotempty{\imprimircoorientador}{
                \\\imprimircoorientadorRotulo\ \imprimircoorientador
            }
        \end{minipage}
    }

    \vfill

    \textbf{\MakeTextUppercase{\imprimirlocal}}\\
    \textbf{\the\year}
}

% ==============================================================================
% Ficha catalográfica
% ==============================================================================
\ProvideDocumentEnvironment{cip}{}
{\thispagestyle{empty}\begin{SingleSpace}}
{\end{SingleSpace}}

\ProvideDocumentCommand
\imprimircip{ o }{
    \imprimircipframe
    \IfValueT{#1}{
        \vspace{2ex}
        \nominata{#1}
    }
}

\ProvideDocumentCommand
\imprimircipframe{}{
\vspace*{\fill}
\begin{cip}
    \noindent
    \framebox[14cm]{
    \begin{minipage}[c]{12cm}
        \setlength{\parindent}{2em}
        \setlength{\parskip}{1.4ex}
        \vspace*{2ex}
        \noindent\imprimirautor

        \imprimirtitulo\ / \imprimirautor. -- \the\year.\\
        \indent\pageref*{LastPage}~f.: il.

        \imprimirorientadorRotulo\ \imprimirorientador\\
        \abntex@ifnotempty{\imprimircoorientador}{
            \indent\imprimircoorientadorRotulo\ \imprimircoorientador\\
        }
        \indent\imprimirtipotrabalho\ -- \imprimirinstituicao,
        \imprimircursoRotulo\ \imprimircurso, \imprimirlocal, \the\year.

        \ifthenelse{\isundefined{\palavracha}}{}{1.~\palavracha.}
        \ifthenelse{\isundefined{\palavrachb}}{}{2.~\palavrachb.}
        \ifthenelse{\isundefined{\palavrachc}}{}{3.~\palavrachc.}
        \ifthenelse{\isundefined{\palavrachd}}{}{4.~\palavrachd.}
        \ifthenelse{\isundefined{\palavrache}}{}{5.~\palavrache.}
        I.~\imprimirorientador.
        II.~\imprimirinstituicao.
        III.~T\'itulo
        \vspace{4ex}
    \end{minipage}
    }
\end{cip}
}

\ProvideDocumentCommand \nominata{ m }{
\begin{SingleSpace}
    \hrule
    \vspace{6pt}
    \noindent\copyright\ \the\year\\
    \noindent Todos os direitos autorais reservados a \imprimirautor.
    A reprodu\c{c}\~ao de partes ou do todo deste trabalho s\'o poder\'a ser
    feita mediante a cita\c{c}\~ao da fonte.\\
    \noindent E-mail: {#1}
\end{SingleSpace}
}

% ==============================================================================
% Folha de aprovação
% ==============================================================================
% o regulamento de TCC de CC exige pelo menos 3 membros pra banca
% (orientador e mais dois). Este comando, portanto, exige dois membros
% (o orientador é impresso automaticamente) e suporta mais dois opcionais,
% totalizando 5 membros. O coorientador não é impresso automaticamente pois
% o manual de elaboração de TCC quer a sigla da instituição após o nome
% abaixo da linha da assinatura e o coorientador não é obrigado a ser da UFFS.
% O primeiro parâmetro, opcional, é a data da defesa.
% O valor padrão para a data de defesa é a data configurada no documento com
% a macro \data.
\ProvideDocumentCommand
\imprimirfolhadeaprovacao{ O{\imprimirdata} m m o o }{
\begin{folhadeaprovacao}
    \OnehalfSpacing
    \begin{center}
        \ABNTEXchapterfont%
        \MakeTextUppercase{\imprimirautor}

        \vspace{\baselineskip}

        \MakeTextUppercase{\imprimirtitulo}
        \abntex@ifnotempty{\imprimirsubtitulo}{
            \\\textmd{\MakeTextUppercase{\imprimirsubtitulo}}
        }
    \end{center}

    \vspace{\baselineskip}

    \noindent\imprimirpreambulo%

    \vspace{\baselineskip}

    \noindent\imprimirorientadorRotulo\ \imprimirorientador
    \abntex@ifnotempty{\imprimircoorientador}{
        \\\imprimircoorientadorRotulo\ \imprimircoorientador
    }

    \vspace{2\baselineskip}

    \noindent\declaracaoaprovacao\ #1.

    \vspace{2\baselineskip}

    \noindent\MakeTextUppercase{\bancaname}

    \assinatura{\imprimirorientador\ -- UFFS}
    \assinatura{#2}
    \assinatura{#3}
    \IfValueT{#4}{
        \assinatura{#4}
    }
    \IfValueT{#5}{
        \assinatura{#5}
    }
\end{folhadeaprovacao}
}

% ==============================================================================
% Ambiente `algoritmo` e definição da lista de algoritmos
% ==============================================================================
\newfloat{algoritmo}{\algoritmoext}{\algoritmoname}

\newlistof{listofalgoritmos}{\algoritmoext}{\listalgoritmoname}
\newlistentry{algoritmo}{\algoritmoext}{0}
\renewcommand*{\cftalgoritmoname}{\algoritmoname\space}
\renewcommand*{\cftalgoritmoaftersnum}{\hfill\textendash\hfill}

\AtBeginDocument{
    \@ifpackageloaded{cleveref}{
        \crefname{algoritmo}{\algoritmoname}{\algoritmoname{}s}
    }{}
    \@ifpackageloaded{datetime2}{
        \renewcommand*{\imprimirdata}{\DTMdate{\thedate}}
    }{}
}

% ==============================================================================
% Correção do título da seção das referências
% ==============================================================================
\AtBeginDocument{
  \@ifpackageloaded{biblatex}{
    % definição do título baseada no abnTeX2
    % (https://github.com/abntex/abntex2/blob/master/tex/latex/abntex2/abntex2.cls#L537,
    % que por sua vez é baseada na definição
    % padrão do Memoir), mas utilizando o
    % comando \defbibheading como recomendado
    % pela documentação do BibLaTeX quando
    % ele for carregado
    \defbibheading{abnt}[\refname]{
      \chapter*{#1}
      \bibmark
      \ifmemoirbibintoc{ % front-end do BibLaTeX
        \phantomsection
        \addcontentsline{toc}{chapter}{\texorpdfstring{\MakeTextUppercase{#1}}{#1}}
      }{}
      \prebibhook
    }
  }{}
}
