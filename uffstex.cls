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
\ProvidesClass{uffstex}[2018/07/15 v0.4 Classe de trabalhos acadêmicos
da Universidade Federal da Fronteira Sul baseada em abnTeX2]

% ==============================================================================
% Carregando pacotes necessários
% ==============================================================================
\RequirePackage{xpatch}
\RequirePackage{graphicx}
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
}
\addto\extrasenglish{
  \instituicao{Federal University of Fronteira Sul}
  \preambulo{Final undergraduate paper submitted as %
      requirement to obtain the \imprimirgrau's degree in %
      \imprimircurso\ from \imprimirinstituicao.}
}

% ==============================================================================
% Comandos de dados
% ==============================================================================
% Versões com * das definições de comandos são recomendadas
% quando os parâmetros não são parágrafos inteiros
\providecommand*{\hoje}{\today}

\newcommand*{\imprimircampusRotulo}{\campusname}

\providecommand*{\imprimirgrau}{\bacharelname}
\providecommand*{\licenciatura}{\renewcommand*{\imprimirgrau}{\licenciaturaname}}
\newcommand*{\grau}[1]{\renewcommand*{\imprimirgrau}{#1}}

\newcommand*{\imprimircursoRotulo}{\cursoname}
\providecommand*{\imprimircurso}{}
\newcommand*{\curso}[1]{\renewcommand*{\imprimircurso}{#1}}

\providecommand*{\imprimirsubtitulo}{}
\newcommand*{\subtitulo}[1]{\renewcommand*{\imprimirsubtitulo}{#1}}

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
        % altura, o LaTeX a escala (largura
        % ficará menor)
        \includegraphics[height=20mm]{logo.png}

        \vspace{1cm}

        \MakeTextUppercase{\imprimirinstituicao}\\
        \MakeTextUppercase{\imprimircampusRotulo\ \imprimirlocal}\\
        \MakeTextUppercase{\imprimircursoRotulo\ \imprimircurso}

        \vspace{3cm}

        \MakeTextUppercase{\imprimirautor}

        \vspace{5cm}

        \MakeTextUppercase{\imprimirtitulo}\\
        \textmd{\MakeTextUppercase{\imprimirsubtitulo}}

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

    \MakeTextUppercase{\imprimirtitulo}\\
    \textmd{\MakeTextUppercase{\imprimirsubtitulo}}

    \vspace{2cm}

    \abntex@ifnotempty{\imprimirpreambulo}{
        \hspace*{0.49\textwidth}
        \begin{minipage}{0.5\textwidth}
            \mdseries
            \footnotesize
            \SingleSpacing

            \imprimirpreambulo

            \imprimirorientadorRotulo\ \imprimirorientador\\
            \imprimircoorientadorRotulo\ \imprimircoorientador
        \end{minipage}
    }

    \vfill

    \textbf{\MakeTextUppercase{\imprimirlocal}}\\
    \textbf{\the\year}
}
