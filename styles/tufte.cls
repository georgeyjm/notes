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
%\RequirePackage{newpxtext}
%\RequirePackage{newpxmath} % if not loaded, uncomment amssymb, amsthm
%\RequirePackage[scaled=0.90]{helvet} % Helvetica for sans-serif
%\RequirePackage[scaled=0.85]{beramono} % Bera Mono for monospaced

% Packages for back-end uses
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\RequirePackage{xifthen}

% Packages for general math typesetting
\RequirePackage{amsmath}
\RequirePackage{amssymb} % loaded by newpxmath
\RequirePackage{amsthm} % loaded by newpxmath
\RequirePackage{amsfonts}
\RequirePackage{mathtools}
\RequirePackage{commath}
\RequirePackage{bm}
\RequirePackage{thmtools}

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



%==================================================
%  Document Setup and Customization
%==================================================

% Page layout
\geometry{
  a4paper,
  left=15mm,
  bottom=25mm,
  textwidth=126mm, % Body width
  marginparsep=8mm, % Gutter
  marginparwidth=50mm, % Margin note width
}
\renewcommand{\baselinestretch}{1.1} % Line spacing
%\renewcommand{\arraystretch}{0.6} % Matrix line spacing
\setlength{\parskip}{0em}
\allsectionsfont{\normalfont \bfseries}
\AtBeginEnvironment{pmatrix}{\renewcommand{\arraystretch}{0.8}} % Matrix line spacing


% Colors
\definecolor{secondary}{gray}{0.9}
\definecolor{axiomcolor}{gray}{0}

%\definecolor{defcolor}{HTML}{273c75} % 273c75
%\definecolor{theoremcolor}{HTML}{2c6e49} % 419d78
%\definecolor{propcolor}{HTML}{30b398}
%\definecolor{lemmacolor}{HTML}{674b85}
%\definecolor{corollarycolor}{HTML}{c79b24} % c5ae6c
%\definecolor{examplecolor}{HTML}{d94646}

\definecolor{defcolor}{HTML}{2e5090}
\definecolor{theoremcolor}{HTML}{4f7942}
\definecolor{propcolor}{HTML}{009b7d}
\definecolor{lemmacolor}{HTML}{915c83}
\definecolor{corollarycolor}{HTML}{a57c00}
\definecolor{examplecolor}{HTML}{cb410b}

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
  coltitle={theoremcolor},
  borderline west={\envBorderWidth}{\envBorderOffset}{theoremcolor}
}{thm}
\newtcbtheorem[auto counter, number within=section, use counter from=theorem]{lemma}{Lemma}{
  basicstyle,
  label type=lemma,
  coltitle={lemmacolor},
  borderline west={\envBorderWidth}{\envBorderOffset}{lemmacolor}
}{lem}
\newtcbtheorem[auto counter, number within=section, use counter from=theorem]{corollary}{Corollary}{
  basicstyle,
  label type=corollary,
  coltitle={corollarycolor},
  borderline west={\envBorderWidth}{\envBorderOffset}{corollarycolor}
}{cor}
\newtcbtheorem[auto counter, number within=section, use counter from=theorem]{proposition}{Proposition}{
  basicstyle,
  label type=proposition,
  coltitle={propcolor},
  borderline west={\envBorderWidth}{\envBorderOffset}{propcolor}
}{prop}
\newtcbtheorem[auto counter, number within=section, use counter from=theorem]{axiom}{Axiom}{
  basicstyle,
  label type=axiom,
  coltitle={axiomcolor},
  borderline west={\envBorderWidth}{\envBorderOffset}{axiomcolor}
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
  coltitle={examplecolor},
  borderline west={\envBorderWidth}{\envBorderOffset}{examplecolor}
}{ex}
\tcolorboxenvironment{proof}{
  basicstyle,
  breakable,
  top=1.5em,
  enlarge top by=-1.5em,
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

% Named cref
\newcommand{\namedcref}[1]{\cref{#1} (\nameref{#1})}
\newcommand{\namedCref}[1]{\Cref{#1} (\nameref{#1})}
%\newcommand{\namedcref}[1]{\nameref{#1} (\ref{#1})}
%\newcommand{\namedCref}[1]{\nameref{#1} (\ref{#1})}



%==================================================
%  Lists
%==================================================

\setlist{font=\upshape}%,topsep=0.5em}

\newlist{romanenum}{enumerate}{1}
\setlist[romanenum]{label=(\roman*),leftmargin=2.5em}%,labelsep=0.75em}

%\renewcommand{\descriptionlabel}[1]{%
%  \hspace{\labelsep}\normalfont\underline{#1}% 
%}


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
\let\oldleq\leq
\let\leq\leqslant
\let\oldgeq\geq
\let\geq\geqslant
\let\smalltilde\tilde
\let\tilde\widetilde
\newcommand{\contradiction}{\!\scalebox{1.25}{\textreferencemark}}
\renewcommand{\abs}[1]{\,\oldabs{#1}}
\newcommand{\defeq}{\coloneqq} % \coloneq or \vcentcolon
\newcommand{\funcarg}{\makebox[1ex]{\textbf{$\cdot$}}}
\DeclarePairedDelimiter\ceil{\lceil}{\rceil}
\DeclarePairedDelimiter\floor{\lfloor}{\rfloor}
\DeclareMathOperator{\image}{Im}

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

% Overwrite tufte handling of marginnote
\let\marginnote\undefined
\RequirePackage{marginnote}
\renewcommand*{\marginfont}{\footnotesize}
\newcounter{marginnoteCounter}
\let\oldmarginnote\marginnote
\renewcommand{\marginnote}[1]{\stepcounter{marginnoteCounter}\textsuperscript{\arabic{marginnoteCounter}}\oldmarginnote{{\normalsize\textsuperscript{\arabic{marginnoteCounter}}}\,#1}} % Can add [0.25em] offset
%\RequirePackage{marginfix}

% Force marginnote to only be on the right side
\AtBeginDocument{
  \makeatletter
  \long\def\@mn@@@marginnote[#1]#2[#3]{%
    \begingroup
      \ifmmode\mn@strut\let\@tempa\mn@vadjust\else
        \if@inlabel\leavevmode\fi
        \ifhmode\mn@strut\let\@tempa\mn@vadjust\else\let\@tempa\mn@vlap\fi
      \fi
      \@tempa{%
        \vbox to\z@{%
          \vss
          \@mn@margintest
          \if@reversemargin\if@tempswa
              \@tempswafalse
            \else
              \@tempswatrue
          \fi\fi
            \rlap{%
              \ifx\@mn@currxpos\relax
                \kern\marginnoterightadjust
                \if@mn@verbose
                  \PackageInfo{marginnote}{%
                    xpos not known,\MessageBreak
                    using \string\marginnoterightadjust}%
                \fi
              \else\ifx\@mn@currxpos\@empty
                  \kern\marginnoterightadjust
                  \if@mn@verbose
                    \PackageInfo{marginnote}{%
                      xpos not known,\MessageBreak
                      using \string\marginnoterightadjust}%
                  \fi
                \else
                  \if@mn@verbose
                    \PackageInfo{marginnote}{%
                      xpos seems to be \@mn@currxpos,\MessageBreak
                      \string\marginnoterightadjust
                      \space ignored}%
                  \fi
                  \begingroup
                    \setlength{\@tempdima}{\@mn@currxpos}%
                    \kern-\@tempdima
                    \if@twoside\ifodd\@mn@currpage\relax
                        \kern\oddsidemargin
                      \else
                        \kern\evensidemargin
                      \fi
                    \else
                      \kern\oddsidemargin
                    \fi
                    \kern 1in
                  \endgroup
                \fi
              \fi
              \kern\marginnotetextwidth\kern\marginparsep
              \vbox to\z@{\kern\marginnotevadjust\kern #3
                \vbox to\z@{%
                  \hsize\marginparwidth
                  \linewidth\hsize
                  \kern-\parskip
                  \marginfont\raggedrightmarginnote\strut\hspace{\z@}%
                  \ignorespaces#2\endgraf
                  \vss}%
                \vss}%
            }%
        }%
      }%
    \endgroup
  }
  \makeatother
}

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
