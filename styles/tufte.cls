\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{note}[2020/11/17 A Tufte-styled class for lecture notes.]

\LoadClass[nofonts,justified]{tufte-handout}



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
%\RequirePackage[hidelinks,breaklinks,bookmarks]{hyperref}
\RequirePackage{sectsty}

% Packages for document font settings
\RequirePackage[osf,sc]{mathpazo} % Palatino for main text and math
%\RequirePackage[scaled=0.90]{helvet} % Helvetica for sans-serif
%\RequirePackage[scaled=0.85]{beramono} % Bera Mono for monospaced

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
%\RequirePackage[bottom]{footmisc}
\RequirePackage{contour}
\RequirePackage{ulem}

% Overwrite tufte handling of marginnote
\let\@twoside\undefined
\let\marginnote\undefined
\RequirePackage{marginnote}
\renewcommand*{\marginfont}{\footnotesize}
\newcounter{marginnoteCounter}
\let\oldmarginnote\marginnote
\renewcommand{\marginnote}[1]{\stepcounter{marginnoteCounter}\textsuperscript{\arabic{marginnoteCounter}}\oldmarginnote{{\normalsize\textsuperscript{\arabic{marginnoteCounter}}}\,#1}}
\RequirePackage{marginfix}
% Force marginnote to only be on the right side
\AtBeginDocument{
  \makeatletter
  \patchcmd{\@addmarginpar}{\ifodd\c@page}{\ifodd\c@page\@tempcnta\m@ne}{}{}
  \makeatother
  \reversemarginpar
}



%==================================================
%  Document Setup and Customization
%==================================================

% Page layout
\geometry{
  a4paper,
  left=15mm,
  textwidth=126mm, % Body width
  marginparsep=8mm, % Gutter
  marginparwidth=50mm, % Margin note width
}
\renewcommand{\baselinestretch}{1.05} % Line spacing
\setlength{\parskip}{0em}
\allsectionsfont{\normalfont \bfseries}


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

\definecolor{defcolor}{HTML}{273c75}

% Table of contents
\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{2}



%==================================================
%  Title Customization
%==================================================

% Define extra title commands
\newcommand{\school}[1]{\def\@school{#1}}
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
  \noindent\large
  %\vspace*{0.4in}
  \ifdefvoid{\@courseterm}{}{\@courseterm \\[1.4em]}
  \textbf{\LARGE \@course} \\
  {\textit{\@author}}
  \ifdefvoid{\@email}{}{\\[-0.2em] {\normalsize \texttt{\href{mailto:\@email}{\@email}}}}
  \ifdefvoid{\@date}{}{\\[0.9em] \@date}
  \vspace*{0.2in}
}



%==================================================
%  Environments and Counters
%==================================================

% Basic numbering settings
\numberwithin{equation}{section}
\numberwithin{figure}{section}

% Base tcolorbox styles
\tcbset{
  basicstyle/.style={
    blanker,
    enhanced,
    oversize,
    boxsep=0mm,
    before skip=1.5em,
    after skip=1.5em,
    bottomtitle=1em,
    opacityback=0,
    opacityframe=0,
    opacitybacktitle=0,
    fonttitle=\sffamily\bfseries\upshape,
    description font=\mdseries,
    description delimiters={(}{)\vspace{-0.25em}},
    separator sign none,
  }
}

% Individual environments
\newlength{\envBorderWidth}
\newlength{\envBorderOffset}
\setlength{\envBorderWidth}{0.4mm}
\setlength{\envBorderOffset}{-4mm}
\newtcbtheorem[auto counter, number within=section]{theorem}{Theorem}{
  basicstyle,
  label type=theorem,
  coltitle={lightcoral},
  borderline west={\envBorderWidth}{\envBorderOffset}{lightcoral}
}{thm}
\newtcbtheorem[auto counter, number within=section, use counter from=theorem]{lemma}{Lemma}{
  basicstyle,
  label type=lemma,
  coltitle={lightpink},
  borderline west={\envBorderWidth}{\envBorderOffset}{lightpink}
}{lem}
\newtcbtheorem[auto counter, number within=section, use counter from=theorem]{corollary}{Corollary}{
  basicstyle,
  label type=corollary,
  coltitle={orange},
  borderline west={\envBorderWidth}{\envBorderOffset}{orange}
}{cor}
\newtcbtheorem[auto counter, number within=section, use counter from=theorem]{proposition}{Proposition}{
  basicstyle,
  label type=proposition,
  coltitle={green},
  borderline west={\envBorderWidth}{\envBorderOffset}{green}
}{prop}
\newtcbtheorem[auto counter, number within=section, use counter from=theorem]{axiom}{Axiom}{
  basicstyle,
  label type=axiom,
  coltitle={black},
  borderline west={\envBorderWidth}{\envBorderOffset}{black}
}{axm}
\newtcbtheorem[auto counter, number within=section]{definition}{Definition}{
  basicstyle,
  label type=definition,
  coltitle={defcolor},
  borderline west={\envBorderWidth}{\envBorderOffset}{defcolor}
}{def}
\newtcbtheorem[auto counter, number within=section]{example}{Example}{
  basicstyle,
  label type=example,
  coltitle={lightpurple},
  borderline west={\envBorderWidth}{\envBorderOffset}{lightpurple}
}{ex}
\tcolorboxenvironment{proof}{
  basicstyle,
  breakable,
  borderline west={\envBorderWidth}{\envBorderOffset}{secondary},
}

% CleverRef Names
\crefname{theorem}{Theorem}{Theorem}
\crefname{lemma}{Lemma}{Lemma}
\crefname{corollary}{Corollary}{Corollary}
\crefname{proposition}{Proposition}{Proposition}
\crefname{axiom}{Axiom}{Axiom}
\crefname{definition}{Definition}{Definition}
\crefname{example}{Example}{Example}



%==================================================
%  Lists
%==================================================

\setlist{font=\upshape}%,topsep=0.5em}

\newlist{romanenum}{enumerate}{1}
\setlist[romanenum]{label=(\roman*),leftmargin=2em}%,labelsep=0.75em}


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

% Better \underline
\renewcommand{\ULdepth}{2pt}
\contourlength{1pt}
\let\oldunderline\underline
\renewcommand{\underline}[1]{%
  \uline{\phantom{#1}}%
  \llap{\contour{white}{#1}}%
}

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
