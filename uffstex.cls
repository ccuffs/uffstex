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
\ProvidesClass{uffstex}[2018/12/01 v0.10.5]

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
  \renewcommand*{\orientadorname}{Orientador}
  \renewcommand*{\coorientadorname}{Coorientador}
  \providecommand*{\bacharelname}{Bacharel}
  \providecommand*{\licenciaturaname}{Licenciatura}
  \providecommand*{\bancaname}{banca avaliadora}
  \providecommand*{\declaracaoaprovacao}{Este trabalho de conclus\~ao de curso
    foi defendido e aprovado pela \bancaname\ em:}
  \providecommand*{\algoritmoname}{Algoritmo}
  \providecommand*{\listalgoritmoname}{Lista de \algoritmoname{}s}
  \providecommand*{\cipfolhas}{f}
  \providecommand*{\cipiii}{T\'itulo}
  \providecommand*{\notacopia}{Todos os direitos autorais reservados
  a \imprimirautor. A reprodu\c{c}\~ao de partes ou do todo deste trabalho s\'o
  poder\'a ser feita mediante a cita\c{c}\~ao da fonte.}
  % abntex2 já utiliza 'anexoname' e 'anexosname'...
  \providecommand*{\annexname}{Anexo}
  \providecommand*{\annexesname}{Anexos}
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
  \renewcommand*{\orientadorname}{Advisor}
  \renewcommand*{\coorientadorname}{Co-advisor}
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
  \renewcommand*{\cipfolhas}{pp}
  \renewcommand*{\cipiii}{Title}
  \renewcommand*{\notacopia}{All rights reserved to \imprimirautor.
  This work or any portion thereof may not be reproduced
  without citing the source.}
  % abntex2 já utiliza 'anexoname' e 'anexosname'...
  \renewcommand*{\annexname}{Annex}
  \renewcommand*{\annexesname}{Annexes}
}
\addto\extrasenglish{
  \instituicao{Federal University of Fronteira Sul}
  \preambulo{Final undergraduate work submitted as %
      requirement to obtain a \imprimirgrau's degree in %
      \imprimircurso\ from the \imprimirinstituicao.}
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

\ExplSyntaxOn
\regex_const:Nn \g__dados_divnome_regex {(?:(.+)\ )?(.+)}
\cs_new_protected:Npn \dados_divnome:NNn #1#2#3
{
    \regex_extract_once:NnN \g__dados_divnome_regex {#3} \l_tmpa_rslt
    \seq_pop_right:NN \l_tmpa_rslt #2
    \seq_pop_right:NN \l_tmpa_rslt #1
    % se não há sobrenome na entrada, #1 está vazia e o nome foi parar em #2
    \ifthenelse{\equal{#1}{} \and \not\equal{#2}{}}
    {
        % então seta #1 = #2 e depois limpa #2
        \tl_gset_eq:NN #1 #2
        \tl_gclear:N #2
    }{}
}

\RenewDocumentCommand \autor { m }
{
    \author{#1}
    \dados_divnome:NNn\autorinicio\autorultnome{#1}
}

\RenewDocumentCommand \orientador { O{\orientadorname} m }
{
    \RenewDocumentCommand \imprimirorientadorRotulo{}{#1:}
    \RenewDocumentCommand \imprimirorientador{}{#2}
    \dados_divnome:NNn\orientadorinicio\orientadorultnome{#2}
}

\RenewDocumentCommand \coorientador { O{\coorientadorname} m }
{
    \RenewDocumentCommand \imprimircoorientadorRotulo{}{#1:}
    \RenewDocumentCommand \imprimircoorientador{}{#2}
    \dados_divnome:NNn\coorientadorinicio\coorientadorultnome{#2}
}
\ExplSyntaxOff

\providecommand*{\imprimircidade}{}
\ProvideDocumentCommand \cidade { m }
{
    \renewcommand*{\imprimircidade}{#1}
}

\providecommand*{\imprimiruf}{}
\ProvideDocumentCommand \uf { m }
{
    \renewcommand*{\imprimiruf}{#1}
}

% =======================================
% Palavras-chave (funcionalidade baseada na classe mdtuffs)
% =======================================
\ExplSyntaxOn
\tl_const:Nn \c_kw_csprefix_tl {palavrach}
\int_const:Nn \c_kw_max_int {5}
\int_zero_new:N \g_kw_count_int

\cs_new:Npn \kw_add:n #1
{
    \cs_new:cpn {\c_kw_csprefix_tl\int_to_alph:n{\g_kw_count_int}} {#1}
}

\NewDocumentCommand \palavrachave { m }
{
    \int_compare:nTF {\g_kw_count_int < \c_kw_max_int}
    {
        \int_incr:N \g_kw_count_int
        \kw_add:n {#1}
    }
    {
        \ClassWarning{uffstex}{Voc\^e~excedeu~o~limite~de~
        \int_to_arabic:n {\c_kw_max_int}~palavras-chave.~Apenas~
        \int_to_arabic:n {\c_kw_max_int}~ser\~ao~exibidas}
    }
}

\NewDocumentCommand \imprimirpc { m }
{
    \int_compare:nTF {1 <= #1 <= \c_kw_max_int}
    {
        \use:c {\c_kw_csprefix_tl\int_to_alph:n{#1}}
    }
    {
        \ClassError{uffstex}{Palavra-chave~#1~n\~ao~existe}
            {Verifique~o~n\'umero~que~voc\^e~passou~como~par\^ametro~
            para~o~comando~\imprimirpc~e~quantas~palavras-chave~voc\^e~definiu.}
    }
}

\NewDocumentCommand \imprimirpcs { s O{\@.} }
{
    \int_zero_new:N \l_kw_count_int
    \int_while_do:nn {\l_kw_count_int < \g_kw_count_int}
    {
        \int_incr:N \l_kw_count_int
        % se usar comando com *, enumera as palavras-chave
        \IfBooleanT{#1}{\int_to_arabic:n {\l_kw_count_int}.\nobreakspace}
        \imprimirpc{\l_kw_count_int}#2

        % se o contador ainda é menor que o valor máximo, coloca um espaço
        % (ou seja, coloca um espaço entre as palavras-chave)
        \int_compare:nTF {\l_kw_count_int < \c_kw_max_int}{~}{}
    }
}
\ExplSyntaxOff

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

        \vspace{\baselineskip}

        \MakeTextUppercase{\imprimirinstituicao}\\
        \MakeTextUppercase{\imprimircampusRotulo\ \imprimircidade}\\
        \MakeTextUppercase{\imprimircursoRotulo\ \imprimircurso}

        \vspace{3cm}

        \MakeTextUppercase{\imprimirautor}

        \vspace{4.5cm}

        \MakeTextUppercase{\imprimirtitulo}
        \abntex@ifnotempty{\imprimirsubtitulo}{
            \\\textmd{\MakeTextUppercase{\imprimirsubtitulo}}
        }

        \vspace{\fill}

        \MakeTextUppercase{\imprimircidade}\\
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

    \vspace{7cm}

    \MakeTextUppercase{\imprimirtitulo}
    \abntex@ifnotempty{\imprimirsubtitulo}{
        \\\textmd{\MakeTextUppercase{\imprimirsubtitulo}}
    }

    \vspace{3cm}

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

    \textbf{\MakeTextUppercase{\imprimircidade}}\\
    \textbf{\the\year}
}

% ==============================================================================
% Ficha catalográfica (funcionalidade baseada na classe mdtuffs)
% ==============================================================================
\ProvideDocumentEnvironment{cip}{}
{\thispagestyle{empty}\begin{SingleSpace}}
{\end{SingleSpace}}

\ProvideDocumentCommand
\imprimircip{ o }{
    \imprimircipframe
    \IfValueT{#1}{
        \vspace{4ex}
        \nominata{#1}
    }
    \clearpage%
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
        \noindent
        \abntex@ifnotempty{\autorultnome}{\autorultnome, }\autorinicio

        \imprimirtitulo\abntex@ifnotempty{\imprimirsubtitulo}
            {: \imprimirsubtitulo} / \imprimirautor. -- \the\year.\\
        \indent\pageref*{LastPage}~\cipfolhas.: il.

        \imprimirorientadorRotulo\ \imprimirorientador.\\
        \abntex@ifnotempty{\imprimircoorientador}{
            \indent\imprimircoorientadorRotulo\ \imprimircoorientador.\\
        }
        \indent\imprimirtipotrabalho\ -- \imprimirinstituicao,
        \imprimircursoRotulo\ \imprimircurso,
        \imprimircidade, \abntex@ifnotempty{\imprimiruf}{\imprimiruf,}{}
        \the\year.

        \imprimirpcs*
        I.~\abntex@ifnotempty{\orientadorultnome}
            {\orientadorultnome, }{}\orientadorinicio,
            \MakeTextLowercase{\orientadorname}.
        \ifthenelse{\equal{\imprimircoorientador}{}}
        {
            % se não há coorientador, pula pra instituição
            II.~\imprimirinstituicao.
            III.~\cipiii.
        }
        {
            II.~\abntex@ifnotempty{\coorientadorultnome}
                {\coorientadorultnome, }{}\coorientadorinicio,
                \MakeTextLowercase{\coorientadorname}.
            III.~\imprimirinstituicao.
            IV.~\cipiii.
        }
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
    \noindent\notacopia\\
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
        % \crefname é definido automaticamente com \MakeLowercase do \Crefname
        \Crefname{algoritmo}{\algoritmoname}{\algoritmoname{}s}
        \Crefname{anexo}{\annexname}{\annexesname}

        \if@cref@capitalise%
            \crefname{algoritmo}{\algoritmoname}{\algoritmoname{}s}%
        \fi%
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
