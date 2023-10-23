\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{note}[2020/11/17 George's LaTeX Colorful Course Notes Class]

\LoadClass[11pt]{article}



%==================================================
%  Required Packages
%==================================================

% Packages for general setup
\RequirePackage[utf8]{inputenc}
\RequirePackage[english]{babel}
\RequirePackage[T1]{fontenc}

% Packages for page setup and document structure
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage[hidelinks,breaklinks,bookmarks]{hyperref}

% Packages for back-end uses
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\RequirePackage{xifthen}

% Packages for general math typesetting
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{amsfonts}
\RequirePackage{mathtools}
\RequirePackage{commath}

% Packages for general uses
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{setspace}
\RequirePackage{float}
\RequirePackage{enumitem}
\RequirePackage[theorems,breakable,skins]{tcolorbox}
\RequirePackage[nameinlink]{cleveref}
\RequirePackage[bottom]{footmisc}



%==================================================
%  Document Setup and Customization
%==================================================

% Page layout
\geometry{a4paper,margin=1.2in} % Page size and margins
\renewcommand{\baselinestretch}{1.1} % Line spacing
\setlength{\parskip}{0em}

% Colors
\definecolor{secondary}{gray}{0.6}
\definecolor{orange}{HTML}{ffa502}
\definecolor{lightorange}{HTML}{eccc68}
\definecolor{green}{HTML}{2ed573}
\definecolor{lightgreen}{HTML}{7bed9f}
\definecolor{coral}{HTML}{ff6348}
\definecolor{lightcoral}{HTML}{ff7f50}
\definecolor{pink}{HTML}{ff4757}
\definecolor{lightpink}{HTML}{ff6b81}
\definecolor{blue}{HTML}{1e90ff}
\definecolor{lightblue}{HTML}{70a1ff}
\definecolor{purple}{HTML}{3742fa}
\definecolor{lightpurple}{HTML}{5352ed}

% Table of contents
\setcounter{tocdepth}{2}



%==================================================
%  Title Customization
%==================================================

% Define extra title commands
\newcommand{\course}[1]{\def\@course{#1}}
\newcommand{\courseterm}[1]{\def\@courseterm{#1}}
\newcommand{\email}[1]{\def\@email{#1}}

% Undefine original title command to avoid ambiguity
\let\title\undefined

% % Make title information optional
\let\@course\empty
\let\@courseterm\relax
\let\@email\relax

% Command for printing the heading
\renewcommand{\maketitle}{
  \large
  \begin{center}
    \vspace*{0.4in}
    \textbf{\LARGE \@course}
    \ifdefvoid{\@courseterm}{}{\\[0.2em] \@courseterm} \\[1.4em]
    {\@author}
    \ifdefvoid{\@email}{}{\\[-0.1em] {\normalsize \texttt{\href{mailto:\@email}{\@email}}}}
    \ifdefvoid{\@date}{}{\\[0.9em] \@date}
    \vspace*{0.2in}
  \end{center}
}



%==================================================
%  Environments and Counters
%==================================================

% Basic numbering settings
\numberwithin{equation}{section}
\numberwithin{figure}{section}

% Base tcolorbox styles
\tcbset{
  plainstyle/.style={
    toptitle=0.25em,
    bottomtitle=0.25em,
    fonttitle=\bfseries\upshape,
    fontupper=\slshape,
    colback=black!3,
    separator sign none,
    description font=\mdseries,
    description delimiters parenthesis,
  },
  definitionstyle/.style={
    plainstyle,
    fontupper=\upshape,
    sharp corners=all,
  },
}

% Individual environments
\newtcbtheorem[auto counter, number within=section]{theorem}{Theorem}{
  plainstyle,
  label type=theorem,
  colbacktitle=lightcoral,
  colframe=lightcoral,
}{thm}
\newtcbtheorem[auto counter, number within=section, use counter from=theorem]{lemma}{Lemma}{
  plainstyle,
  label type=lemma,
  colbacktitle=lightpink,
  colframe=lightpink,
}{lem}
\newtcbtheorem[auto counter, number within=section, use counter from=theorem]{corollary}{Corollary}{
  plainstyle,
  label type=corollary,
  colbacktitle=orange,
  colframe=orange,
}{cor}
\newtcbtheorem[auto counter, number within=section, use counter from=theorem]{proposition}{Proposition}{
  plainstyle,
  label type=proposition,
  colbacktitle=green,
  colframe=green,
}{prop}
\newtcbtheorem[auto counter, number within=section, use counter from=theorem]{axiom}{Axiom}{
  plainstyle,
  label type=axiom,
  fontupper=\upshape,
}{axm}
\newtcbtheorem[auto counter, number within=section]{definition}{Definition}{
  definitionstyle,
  label type=definition,
  colbacktitle=blue,
  colframe=blue,
}{def}
\newtcbtheorem[auto counter, number within=section]{example}{Example}{
  definitionstyle,
  label type=example,
  colbacktitle=lightpurple,
  colframe=lightpurple,
}{ex}
\tcolorboxenvironment{proof}{
  blanker,breakable,left=5mm,
  before skip=10pt,after skip=10pt,
  borderline west={0.5mm}{0pt}{secondary},
}

% CleverRef Names
\crefname{theorem}{Theorem}{Theorem}
\crefname{lemma}{Lemma}{Lemma}
\crefname{corollary}{Corollary}{Corollary}
\crefname{Proposition}{proposition}{proposition}
\crefname{Axiom}{axiom}{axiom}
\crefname{definition}{Definition}{Definition}
\crefname{example}{Example}{Example}



%==================================================
%  Lists
%==================================================

\setlist{font=\upshape}%,topsep=0.5em}

\newlist{romanenum}{enumerate}{1}
\setlist[romanenum]{label=(\roman*)}%,labelsep=0.75em}


%==================================================
%  Macros and Shorthands
%==================================================

% General Text
\newcommand*{\term}[1]{\underline{\textit{#1}}}
\renewcommand*{\em}{\textbf}
\newcommand*{\tsp}{\textsuperscript}
\newcommand*{\tsb}{\textsubscript}
\newcommand{\supth}{\tsp{th}}
\renewcommand{\comment}[1]{{\textcolor{secondary}{#1}}} % This may cause a problem

% General Math
\let\oldemptyset\emptyset
\let\emptyset\varnothing
\let\oldepsilon\epsilon
\let\epsilon\varepsilon
\let\varepsilon\oldepsilon
\let\oldabs\abs
\renewcommand{\abs}[1]{\,\oldabs{#1}}
\DeclarePairedDelimiter\ceil{\lceil}{\rceil}
\DeclarePairedDelimiter\floor{\lfloor}{\rfloor}

% Sets
\newcommand{\NN}{\mathbb{N}}
\newcommand{\ZZ}{\mathbb{Z}}
\newcommand{\QQ}{\mathbb{Q}}
\newcommand{\RR}{\mathbb{R}}
\newcommand{\CC}{\mathbb{C}}



%==================================================
%  Behavior Tweaking and Customization
%==================================================

% Better \overline (only works for short maths)
\let\oldoverline\overline
\renewcommand*{\overline}[1]{
  \sbox0{$\mathrm{#1}\m@th$}%
  \sbox2{$#1\m@th$}%
  \rlap{%
    \hbox to\wd2{%
      \hfill
      $\oldoverline{\vrule width 0pt height\ht0 \kern\wd0 }$%
    }%
  }%
  \copy2 %
}

% Remove space around \left, \right, and others
\let\oldleft\left
\let\oldright\right
\renewcommand{\left}{\mathopen{}\mathclose\bgroup\oldleft}
\renewcommand{\right}{\aftergroup\egroup\oldright}
\let\oldbig\big
\let\oldbigg\bigg
\let\oldBig\Big
\let\oldBigg\Bigg
\renewcommand{\big}{\mathopen{}\mathclose\oldbig}
\renewcommand{\bigg}{\mathopen{}\mathclose\oldbigg}
\renewcommand{\Big}{\mathopen{}\mathclose\oldBig}
\renewcommand{\Bigg}{\mathopen{}\mathclose\oldBigg}

% Centering in indented environments
\newcommand{\nomathindent}{\displayindent0pt \displaywidth\textwidth}
\makeatletter
\patchcmd\start@gather{$$}{%
  $$%
  \displaywidth=\textwidth
  \displayindent=-\leftskip
}{}{\errmessage{Cannot patch \string\start@gather}}
\patchcmd\start@align{$$}{%
  $$%
  \displaywidth=\textwidth
  \displayindent=-\leftskip
}{}{\errmessage{Cannot patch \string\start@align}}
\patchcmd\start@multline{$$}{%
  $$%
  \displaywidth=\textwidth
  \displayindent=-\leftskip
}{}{\errmessage{Cannot patch \string\start@multline}}
\patchcmd\mathdisplay{$$}{%
  $$%
  \displaywidth=\textwidth
  \displayindent=-\leftskip
}{}{\errmessage{Cannot patch \string\mathdisplay}}
\makeatother
