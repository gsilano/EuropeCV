%!TEX encoding = UTF-8 Unicode
%%
%% europecv.cls -- An unofficial LaTeX class for European curricula vitae
%%
%% Copyright (C) Nicola Vitacolonna (original author)
%% Copyright (C) 2018-2026 Giuseppe Silano and the EuropeCV contributors
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   https://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2008 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%% The Current Maintainer of this work is Giuseppe Silano.
%%
%% This work consists of the files europecv.cls, europecv2020.cls,
%% europecv-common.def, ecv*.def and europecv.tex, together with the
%% images, examples and templates listed in the README.md file.
%%
%% Development: https://github.com/gsilano/EuropeCV
%% CTAN:        https://ctan.org/pkg/europecv
%%
\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{europecv}[2026/10/19 v2026.10.19 European curriculum vitae class]

% Europass CV models and instructions:
%   https://europass.europa.eu/
% Common European Framework of Reference for Languages (CEFR):
%   https://www.coe.int/en/web/common-european-framework-reference-languages

% Code shared with the europecv2020 class: language and input encoding
% options, cross-referencing and personal data commands
\input{europecv-common.def}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title, branding, logo and flag
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% No title. This must come *after* the language definitions.
\DeclareOption{notitle}{%
  \AtEndOfClass{\renewcommand*\ecvtitle{}}%
}

% No branding (i.e., no "Europass" text in the title).
% The nobranding option was contributed by Marc-Andre Hermanns.
\DeclareOption{nobranding}{%
  \AtEndOfClass{\renewcommand*\ecvbranding{}}%
}

% Europass logo
\DeclareOption{logo}{%
  \providecommand*\draweuropasslogo{%
    \includegraphics[width=\ecv@logowidth]{europasslogo}}%
}
\DeclareOption{nologo}{\renewcommand*\draweuropasslogo{}}

% Flags of the European Union
\DeclareOption{noflag}{\providecommand*\draweuropeflag{}}
\DeclareOption{flagWB}{%
  \renewcommand*\draweuropeflag{%
    \includegraphics[width=\ecv@flagwidth]{EuropeFlagWB}}%
}
\DeclareOption{flagBW}{%
  \renewcommand*\draweuropeflag{%
    \includegraphics[width=\ecv@flagwidth]{EuropeFlagBW}}%
}
\DeclareOption{flagCMYK}{%
  \renewcommand*\draweuropeflag{%
    \includegraphics[width=\ecv@flagwidth]{EuropeFlagCMYK}}%
}
\DeclareOption{flagBlueCMYK}{%
  \renewcommand*\draweuropeflag{%
    \includegraphics[width=\ecv@flagwidth]{EuropeFlagBlueCMYK}}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Page numbering and tables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{totpages}{%
  \AtEndOfClass{%
    \RequirePackage{totpages}%
    \def\ecv@totpages{~/~\ref{TotPages}}%
  }%
}

\DeclareOption{booktabs}{%
  \AtEndOfClass{\RequirePackage{booktabs}}%
  \def\ecv@booktabs{}%
}

% Pass all other options (a4paper, 10pt, draft, openbib, etc.) to article
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}

\ExecuteOptions{english,noflag,logo} % Default options

\ProcessOptions\relax

\LoadClass{article}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Required packages and page layout
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{fancyhdr} % For page numbering

\def\ecv@totpages{}
\newcommand*{\ecvpage}[1]{\def\ecv@page{#1}}
\ecvpage{\ecv@pagekey~\thepage\ecv@totpages}

% Page number
\def\ecv@lfoot{%
  \footnotesize\textrm{\ecv@page~-~\ecv@cvofkey}\\
  \textrm{\ecv@footername}
}

% Right Footnote to be shown on every page
\newcommand\ecvfootnote[1]{\def\ecv@rfoot{#1}}
\ecvfootnote{}

\AddToHook{begindocument/before}{%
  % graphicx is needed to draw the logo, the flags and the picture
  \@ifpackageloaded{graphicx}{}{\RequirePackage{graphicx}}%
  % Loaded by previous versions of the class: kept for compatibility
  \RequirePackage{etoolbox}%
  % hyperref is needed by the cross-referencing commands
  \RequirePackage{hyperref}%
  % Ensure that \ecv@leftcolwidth and \ecv@rightcolwidth
  % are correctly defined
  \ecvLeftColumnWidth{\ecv@leftcolwidth}%
  % Set layout
  \pagestyle{fancy}%
  \fancyhead{}%
  \fancyfoot{}%
  \fancyfoot[L]{\begin{minipage}{\ecv@leftcolwidth}%
    \begin{flushright}\footnotesize\ecv@lfoot\end{flushright}%
    \end{minipage}}%
  \fancyfoot[R]{\begin{minipage}{\ecv@rightcolwidth}%
    \footnotesize\ecv@rfoot
    \end{minipage}}%
  \renewcommand{\headrulewidth}{0pt}%
} % End \AddToHook{begindocument/before}


% Thanks to Roman Bertle for suggesting the following:
\renewcommand{\labelitemi}{\normalfont\bfseries \textendash}
\renewcommand{\labelitemii}{\textasteriskcentered}
\renewcommand{\labelitemiii}{\textperiodcentered}


% Footer of the hungarian option (see europecv-common.def)
\def\ecv@hungarianfooter{%
  \ecvpage{\thepage\ifx\@empty\ecv@totpages.\else\ecv@totpages\fi~\ecv@pagekey}%
  \def\ecv@lfoot{%
    \footnotesize\textrm{\ecv@page~- \textrm{\ecv@footername} \ecv@cvofkey}}%
}
\providecommand{\ecvpersonalinfo}[1][0pt]{%
{\ifx\@empty\ecv@date\else
	\vspace{1em}\large\par\textbf{\ecv@datekey \ecv@date}
\fi} & \tabularnewline
& \tabularnewline
\ifx\@empty\ecvdrawpicture\else
   &\ecv@beforepic\ecvdrawpicture\ecv@afterpic\tabularnewline
\fi
{\large\par\textbf{\ecv@infosectionkey}} & \tabularnewline
& \tabularnewline
\ecv@namekey & \large\textbf{\ecv@name}\tabularnewline[5pt]
\ifx\@empty\ecv@address\else
   \ecv@addresskey &\ecv@address
   \tabularnewline[5pt]
   \ifx\@empty\ecv@mobileAddress \else
     \ecv@addresskey &\ecv@mobileAddress
     \tabularnewline[5pt]
   \fi
   \ifx\@empty\ecv@officeAddress \else
     \ecv@addresskey  &\ecv@officeAddress
     \tabularnewline[5pt]
   \fi
\fi
\ifx\@empty\ecv@telephone\else
   \ecv@telkey &\ecv@telephone
   \ifx\@empty\ecv@mobile\else
     \qquad  \ecv@mobilekey:  \ecv@mobile
   \fi
   \ifx\@empty\ecv@office\else
     \qquad  \ecv@officekey:  \ecv@office
   \fi
   \tabularnewline[5pt]
\fi
\ifx\@empty\ecv@fax\else
\ecv@faxkey       &\ecv@fax \tabularnewline[5pt]
\fi
\ifx\@empty\ecv@email\else
\ecv@emailkey       &\ecv@email \tabularnewline[5pt]
\fi
\ifx\@empty\ecv@professional\else
\ecv@professionalkey       &\ecv@professional \tabularnewline[5pt]
\fi
\ifx\@empty\ecv@pec\else
\ecv@peckey       &\ecv@pec \tabularnewline[5pt]
\fi
\ifx\@empty\ecv@homepage\else
\ecv@homepagekey       &\ecv@homepage \tabularnewline[5pt]
\fi
\ifx\@empty\ecv@skype\else
\ecv@skypekey       &\ecv@skype \tabularnewline[5pt]
\fi
\ifx\@empty\ecv@matrixriot\else
\ecv@matrixriotkey       &\ecv@matrixriot \tabularnewline[5pt]
\fi
\ifx\@empty\ecv@youtube\else
\ecv@youtubekey      &\ecv@youtube \tabularnewline[5pt]
\fi
\ifx\@empty\ecv@nationality\else
\ecv@nationalitykey & \ecv@nationality \tabularnewline[5pt]
\fi
\ifx\@empty\ecv@birth\else
\ecv@birthkey       & \ecv@birth \tabularnewline[5pt]
\fi
\ifx\@empty\ecv@gender\else
\ecv@genderkey      & \ecv@gender \tabularnewline[#1]
\fi
}

% Spoken language information
\newcommand*\ecvmothertongue[2][0pt]{%
{\large\ecv@mothertonguekey} & \large\textbf{#2}\tabularnewline[#1]
}
\newlength\ecv@langparwidth

\ifx\ecv@booktabs\undefined % Use table conforming to EU model
  \newcommand*\ecvlanguageheader[1]{%
  {\large\textit{\ecv@assesskey}}\\ \textit{\ecv@levelkey}${}^{\mbox{\scriptsize#1}}$&
  \setlength\extrarowheight{2pt}
  \begin{tabular}[t]{|m{\ecv@langparwidth}|m{\ecv@langparwidth}|m{\ecv@langparwidth}|m{\ecv@langparwidth}|m{\ecv@langparwidth}|}
  \firsthline
  \multicolumn{2}{|c|}{\textbf{\ecv@understandkey}}&\multicolumn{2}{c|}{\textbf{\ecv@speakkey}}&\centering\textbf{\ecv@writekey}\tabularnewline\cline{1-4}
  \centering\small{\ecv@listenkey}   & \centering \small{\ecv@readkey} &\centering \small{\ecv@interactkey} &\centering \small{\ecv@productkey} & \tabularnewline
  %\lasthline
  \hline
  \end{tabular} \tabularnewline[-\arrayrulewidth]
  }
  \newcommand*\ecvlanguage[7][0pt]{
  {\textbf{#2}} &
  \setlength\extrarowheight{0pt}
  \begin{tabular}{|m{\ecv@langparwidth}|m{\ecv@langparwidth}|m{\ecv@langparwidth}|m{\ecv@langparwidth}|m{\ecv@langparwidth}|}
  \hline
   #3 & #4 & #5 & #6 & #7 \tabularnewline
  \hline
  \end{tabular}\vspace{#1}
  \tabularnewline[-\arrayrulewidth]
  }
  \newcommand*\ecvlastlanguage[7][0pt]{\ecvlanguage[#1]{#2}{#3}{#4}{#5}{#6}{#7}}
\else % Use booktabs
  \newcommand*\ecvlanguageheader[1]{%
  {\large\textit{\ecv@assesskey}}\\ \textit{\ecv@levelkey}${}^{\mbox{\scriptsize#1}}$&
  \setlength\extrarowheight{0pt}
  \begin{tabular}[t]{m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}}
  \toprule
  \multicolumn{2}{c}{\textbf{\ecv@understandkey}}&\multicolumn{2}{c}{\textbf{\ecv@speakkey}}&\centering\textbf{\ecv@writekey}\tabularnewline
  \centering\small{\ecv@listenkey}   & \centering \small{\ecv@readkey} &\centering \small{\ecv@interactkey} &\centering \small{\ecv@productkey} & \tabularnewline
  \midrule
  \end{tabular}\vspace{2\arrayrulewidth}\tabularnewline
  }
  \newcommand*\ecvlanguage[7][0pt]{
  {\textbf{#2}} &
  \setlength\extrarowheight{0pt}
  \begin{tabular}{m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}}
   #3 & #4 & #5 & #6 & #7\tabularnewline \midrule
  \end{tabular}\vspace{#1}
  \tabularnewline
  }
  \newcommand*\ecvlastlanguage[7][0pt]{
  {\textbf{#2}} &
  \setlength\extrarowheight{0pt}
  \begin{tabular}{m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}}
   #3 & #4 & #5 & #6 & #7\tabularnewline \bottomrule
  \end{tabular}\vspace{#1}
  \tabularnewline
  }
\fi

\newcommand*\ecvlanguagefooter[2][0pt]{\ecvitem[#1]{}{\quad\footnotesize{${}^{\mbox{\tiny#2}}$\textit{\ecv@langfooterkey}}}}

% See the Common European Framework of Reference for Languages:
% https://www.coe.int/en/web/common-european-framework-reference-languages
\newcommand*\ecvCEF[2]{%
  \begin{tabular}{@{}>{\footnotesize}p{.2\ecv@langparwidth}@{\hspace{1mm}}>{\footnotesize\centering}p{.74\ecv@langparwidth}@{}}
#1 & #2\tabularnewline
  \end{tabular}%
}

\newcommand*\ecvAOne{\ecvCEF{A1}{\ecv@cefbasickey}}
\newcommand*\ecvATwo{\ecvCEF{A2}{\ecv@cefbasickey}}
\newcommand*\ecvBOne{\ecvCEF{B1}{\ecv@cefindepkey}}
\newcommand*\ecvBTwo{\ecvCEF{B2}{\ecv@cefindepkey}}
\newcommand*\ecvCOne{\ecvCEF{C1}{\ecv@cefprofkey}}
\newcommand*\ecvCTwo{\ecvCEF{C2}{\ecv@cefprofkey}}

\def\ecv@kern{\kern0.5pt}
%\def\ecv@kern{}
\newcommand*{\ecvTitleKern}[1]{\def\ecv@kern{\kern#1}}
\newlength\ecv@rulewidth
\newlength\ecv@colsep
\newlength\ecv@leftcolwidth
\newlength\ecv@rightcolwidth
\newlength\ecv@extrarowheight
\newcommand*{\ecvRuleWidth}[1]{\setlength\ecv@rulewidth{#1}}
\newcommand*{\ecvColSep}[1]{%
  \addtolength{\ecv@leftcolwidth}{\ecv@colsep}
  \addtolength{\ecv@rightcolwidth}{\ecv@colsep}
  \setlength\ecv@colsep{#1}
  \addtolength{\ecv@leftcolwidth}{-\ecv@colsep}
  \addtolength{\ecv@rightcolwidth}{-\ecv@colsep}}
\newcommand*{\ecvLeftColumnWidth}[1]{\setlength\ecv@leftcolwidth{#1}%
             \setlength{\ecv@rightcolwidth}{\textwidth}
            \addtolength{\ecv@rightcolwidth}{-\ecv@leftcolwidth}
            \addtolength{\ecv@rightcolwidth}{-2\ecv@colsep}
            \addtolength{\ecv@rightcolwidth}{-\ecv@rulewidth}}
\newcommand*{\ecvExtraRowHeight}[1]{\setlength\ecv@extrarowheight{#1}}
\newcommand*{\ecvNoHorRule}{\def\ecv@hrule{}}
\newcommand*{\ecvWithHorRule}{\def\ecv@hrule{\cline{1-1}}}
% Initialization
\ecvRuleWidth{\arrayrulewidth}
\setlength\ecv@colsep{12pt}
\setlength\ecv@leftcolwidth{50mm} % Default left column width
\ecvExtraRowHeight{0pt}
\ecvWithHorRule

% Flag size
\newlength\ecv@flagwidth
\newcommand*{\ecvFlagWidth}[1]{\setlength\ecv@flagwidth{#1}}
\ecvFlagWidth{10mm}

% Logo size
\newlength\ecv@logowidth
\newlength\ecv@logooffset
\newcommand*{\ecvLogoWidth}[1]{\setlength\ecv@logowidth{#1}}
\newcommand*{\ecvLogoOffset}[1]{\setlength\ecv@logooffset{#1}}
\ecvLogoWidth{2.30cm}
\ecvLogoOffset{1cm}
%\typeout{logo width=\the\ecv@logowidth}
%\typeout{logo offset=\the\ecv@logooffset}

% Text bullet
\newcommand{\ecvbullet}{\raisebox{.35ex}[0cm][0cm]{\tiny\textbullet}}

\newenvironment{europecv}{%
  \ecvLeftColumnWidth{\ecv@leftcolwidth}
  \setlength\arrayrulewidth{\ecv@rulewidth}
  \setlength\extrarowheight{\ecv@extrarowheight}
  \setlength\LTleft{0pt}
  \setlength\LTright{0pt}
  % Language table paragraph width
  \setlength\ecv@langparwidth{.199\ecv@rightcolwidth}
  \addtolength{\ecv@langparwidth}{-2\tabcolsep}
  \addtolength{\ecv@langparwidth}{-2\arrayrulewidth}
% Begin
\begin{longtable}[l]{@{}>{\raggedleft}p{\ecv@leftcolwidth}@{\hspace{\ecv@colsep}}|@{\extracolsep{\ecv@colsep}}p{\ecv@rightcolwidth}@{}}
  \ecv@hrule
  \ifx\@empty\draweuropasslogo\else
    % Any better way of achieving the same result?!?
    \vskip-\ecv@logooffset\draweuropasslogo\hfill\phantom{.}& \tabularnewline
  \fi
  \ifx\@empty\ecvtitle\else
     \ifx\@empty\draweuropasslogo
       & \tabularnewline[-.5em]
     \fi
     \ecvtitle &\tabularnewline
  \fi
  \ifx\@empty\draweuropeflag\else
     & \tabularnewline
     \draweuropeflag& \tabularnewline
  \fi
}
{\end{longtable}}

% \section[<vspace>]{<title>} starts a new section of the CV.
% The starred form is accepted (and behaves the same) for compatibility
% with code written for the standard classes.
\renewcommand{\section}{\@ifstar{\ecv@section}{\ecv@section}}
\newcommand{\ecv@section}[2][10pt]{%
  {\large{\par\textbf{#2}}}\vspace{#1} & \tabularnewline\nopagebreak
}

% Alias for backwards compatibility
\let\ecvsection\section

% Redefine from article.cls without section header
\renewenvironment{thebibliography}[1]
     {%\section*{\refname}%
      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

\newif\if@ecvitemstar
\newcommand\ecvitem{\@ifstar{\@ecvitemstartrue \@ecvitem}%
  {\@ecvitemstarfalse\@ecvitem}}
\newcommand\@ecvitem[3][2pt]{%
  \if@ecvitemstar \ecvbullet\ \fi #2\vspace{#1} & #3
    \vspace{#1}\tabularnewline}
