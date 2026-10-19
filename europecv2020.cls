%!TEX encoding = UTF-8 Unicode
%%
%% europecv2020.cls -- An unofficial LaTeX class for curricula vitae in
%% the Europass format introduced in 2020
%%
%% Copyright (C) 2026 Giuseppe Silano and the EuropeCV contributors
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
%% Development: https://github.com/gsilano/EuropeCV
%% CTAN:        https://ctan.org/pkg/europecv
%%
%% The europecv class implements the original two-column Europass CV.
%% This class implements the single-column layout of the CVs created
%% with the Europass online editor since 2020 (https://europass.europa.eu/):
%% a header with picture, name and personal data, section titles followed
%% by a rule, entries made of dates, title and organisation, and a grid
%% for the self-assessment of language skills. Most of the commands of
%% europecv are available, so that existing CVs can be converted easily.
%%
\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{europecv2020}[2026/10/19 v2026.10.19 Europass (2020) curriculum vitae class]

% Language and input encoding options, personal data and
% cross-referencing commands, shared with the europecv class
\input{europecv-common.def}

% Keys introduced by this layout: English defaults, which the language
% definition files (ecv*.def) may redefine
\def\ecv@otherlangkey{\ecv@utf{Other language(s)}}
\def\ecv@levelskey{\ecv@utf{Levels}}
% Used by the language definition files
\def\ecv@kern{\kern0.5pt}
\providecommand*\ecvbranding{}
\providecommand*\ecvtitle{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\if@ecv@logo \@ecv@logotrue
\newif\if@ecv@sans \@ecv@sanstrue
\newif\if@ecv@geometry \@ecv@geometrytrue
\DeclareOption{logo}{\@ecv@logotrue}
\DeclareOption{nologo}{\@ecv@logofalse}
\DeclareOption{nobranding}{\@ecv@logofalse}
% Sans serif fonts are the default, as in the Europass CV
\DeclareOption{serif}{\@ecv@sansfalse}
% Do not set the page margins (use the geometry package instead)
\DeclareOption{nogeometry}{\@ecv@geometryfalse}
% Options of europecv without meaning in this layout: accepted, so that
% a CV can be converted by just changing the name of the class
\newcommand*\ecv@ignoreoption[1]{%
  \DeclareOption{#1}{%
    \ClassInfo{europecv2020}{Option `#1' ignored by this class}}}
\ecv@ignoreoption{notitle}
\ecv@ignoreoption{noflag}
\ecv@ignoreoption{flagWB}
\ecv@ignoreoption{flagBW}
\ecv@ignoreoption{flagCMYK}
\ecv@ignoreoption{flagBlueCMYK}
\ecv@ignoreoption{booktabs}
\ecv@ignoreoption{totpages}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ExecuteOptions{english}
\ProcessOptions\relax

\LoadClass{article}

\RequirePackage{array}
\RequirePackage{fancyhdr}
\RequirePackage{totpages}

\if@ecv@sans
  \renewcommand{\familydefault}{\sfdefault}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colours and sizes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The colours are given as xcolor specifications and defined at
% \begin{document}, so that the user can load xcolor with any option.
% The default accent colour is the blue of the flag of the European Union.
\newcommand*\ecvAccentColor[2][HTML]{\def\ecv@accent{{#1}{#2}}}
\newcommand*\ecvDateColor[2][HTML]{\def\ecv@datecolor{{#1}{#2}}}
\ecvAccentColor{003399}
\ecvDateColor{5A5A5A}

\newlength\ecv@photowidth
\newcommand*\ecvPhotoWidth[1]{\setlength\ecv@photowidth{#1}}
\ecvPhotoWidth{3cm}
\newlength\ecv@logowidth
\newcommand*\ecvLogoWidth[1]{\setlength\ecv@logowidth{#1}}
\ecvLogoWidth{2.3cm}
\newlength\ecv@langwidth
\newcommand*\ecvLanguageWidth[1]{\setlength\ecv@langwidth{#1}}
\ecvLanguageWidth{.2\linewidth}

% Commands of europecv without meaning in this layout (kept so that
% existing CVs compile without changes)
\newcommand*\ecvRuleWidth[1]{}
\newcommand*\ecvColSep[1]{}
\newcommand*\ecvLeftColumnWidth[1]{}
\newcommand*\ecvExtraRowHeight[1]{}
\newcommand*\ecvNoHorRule{}
\newcommand*\ecvWithHorRule{}
\newcommand*\ecvFlagWidth[1]{}
\newcommand*\ecvLogoOffset[1]{}
\newcommand*\ecvTitleKern[1]{}
\newcommand*\draweuropeflag{}
\newenvironment{europecv}{}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Packages loaded at the beginning of the document and page style
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\AddToHook{begindocument/before}{%
  \@ifpackageloaded{graphicx}{}{\RequirePackage{graphicx}}%
  \@ifpackageloaded{xcolor}{}{\RequirePackage{xcolor}}%
  \edef\@tempa{\noexpand\definecolor{ecvaccent}\ecv@accent
    \noexpand\definecolor{ecvdate}\ecv@datecolor}\@tempa
  \if@ecv@geometry
    \@ifpackageloaded{geometry}{}{%
      \RequirePackage[top=1.5cm,bottom=2.2cm,left=1.8cm,right=1.8cm,
        footskip=1cm]{geometry}}%
  \fi
  \@ifpackageloaded{hyperref}%
    {\RequirePackage{hyperref}}%
    {\RequirePackage{hyperref}%
     \hypersetup{colorlinks,allcolors=ecvaccent}}%
  \urlstyle{same}%
  \pagestyle{fancy}%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyfoot[L]{\parbox[b]{.75\textwidth}{\raggedright\footnotesize\ecv@rfoot}}%
  \fancyfoot[R]{\footnotesize\ecv@page}%
}

% Page number (\ecvpage changes it) and footnote (\ecvfootnote)
\newcommand*{\ecvpage}[1]{\def\ecv@page{#1}}
\ecvpage{\ecv@pagekey~\thepage~/~\ref{TotPages}}
\def\ecv@hungarianfooter{\ecvpage{\thepage~/~\ref{TotPages}.~\ecv@pagekey}}
\newcommand\ecvfootnote[1]{\def\ecv@rfoot{#1}}
\ecvfootnote{}

\setlength{\parindent}{0pt}
\renewcommand{\labelitemi}{\textbullet}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Header with picture, name and personal data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Without options, the picture is scaled to the width set by \ecvPhotoWidth
\def\ecv@picture[#1]#2{%
  \def\ecvarg{#2}%
  \ifx\@empty\ecvarg
    \renewcommand*{\ecvdrawpicture}{}%
  \else
    \def\ecvarg{#1}%
    \ifx\@empty\ecvarg
      \renewcommand*{\ecvdrawpicture}{\includegraphics[width=\ecv@photowidth]{#2}}%
    \else
      \renewcommand*{\ecvdrawpicture}{\includegraphics[#1]{#2}}%
    \fi
  \fi}

\newcommand*\draweuropasslogo{%
  \if@ecv@logo\includegraphics[width=\ecv@logowidth]{europasslogo}\fi}

% Additional contact items: \ecvcontact{<label>}{<value>}
\newcommand*\ecv@extracontacts{}
\newcommand\ecvcontact[2]{%
  \g@addto@macro\ecv@extracontacts{\ecv@infoitem{#1}{#2}}}

% Items of a line of personal data, separated by a vertical bar
\newif\if@ecv@firstitem
\newsavebox\ecv@linebox
\newcommand*\ecv@separator{%
  \unskip\hskip.6em plus .2em\penalty0
  {\color{ecvaccent}\textbar}\hskip.6em plus .2em\relax}
% An item is printed only if its value is not empty (i.e., if it has a
% width when typeset)
\newcommand\ecv@infoitem[2]{%
  \setbox\@tempboxa\hbox{#2}%
  \ifdim\wd\@tempboxa>\z@
    \if@ecv@firstitem\@ecv@firstitemfalse\else\ecv@separator\fi
    \mbox{\textbf{#1:}}~#2%
  \fi}
\newcommand\ecv@infoline[1]{%
  \@ecv@firstitemtrue
  \setbox\ecv@linebox\hbox{#1}%
  \ifdim\wd\ecv@linebox>\z@ \par#1\par\fi}

\newsavebox\ecv@photobox
\newsavebox\ecv@logobox
\newlength\ecv@infowidth
\newcommand*\ecvpersonalinfo[1][1.5em]{%
  \par
  \sbox\ecv@photobox{\ecvdrawpicture}%
  \sbox\ecv@logobox{\draweuropasslogo}%
  \setlength\ecv@infowidth{\linewidth}%
  \ifdim\wd\ecv@photobox>\z@
    \addtolength\ecv@infowidth{-\wd\ecv@photobox}%
    \addtolength\ecv@infowidth{-1.5em}%
  \fi
  \ifdim\wd\ecv@logobox>\z@
    \addtolength\ecv@infowidth{-\wd\ecv@logobox}%
    \addtolength\ecv@infowidth{-1em}%
  \fi
  \noindent
  \ifdim\wd\ecv@photobox>\z@
    \parbox[t]{\wd\ecv@photobox}{\vspace{0pt}\usebox\ecv@photobox}\hspace{1.5em}%
  \fi
  \parbox[t]{\ecv@infowidth}{\vspace{0pt}\raggedright
    {\LARGE\bfseries\ecv@name\par}%
    \vspace{.6em}%
    \small
    \ecv@infoline{%
      \ecv@infoitem{\ecv@birthkey}{\ecv@birth}%
      \ecv@infoitem{\ecv@nationalitykey}{\ecv@nationality}%
      \ecv@infoitem{\ecv@genderkey}{\ecv@gender}}%
    \ecv@infoline{%
      \ecv@infoitem{\ecv@telkey}{\ecv@telephone}%
      \ecv@infoitem{\ecv@mobilekey}{\ecv@mobile}%
      \ecv@infoitem{\ecv@officekey}{\ecv@office}%
      \ecv@infoitem{\ecv@faxkey}{\ecv@fax}}%
    \ecv@infoline{%
      \ecv@infoitem{\ecv@emailkey}{\ecv@email}%
      \ecv@infoitem{\ecv@professionalkey}{\ecv@professional}%
      \ecv@infoitem{\ecv@peckey}{\ecv@pec}}%
    \ecv@infoline{%
      \ecv@infoitem{\ecv@homepagekey}{\ecv@homepage}%
      \ecv@infoitem{\ecv@skypekey}{\ecv@skype}%
      \ecv@infoitem{\ecv@matrixriotkey}{\ecv@matrixriot}%
      \ecv@infoitem{\ecv@youtubekey}{\ecv@youtube}%
      \ecv@extracontacts}%
    \ecv@infoline{%
      \ecv@infoitem{\ecv@addresskey}{\ecv@address}%
      \ecv@infoitem{\ecv@addresskey}{\ecv@mobileAddress}%
      \ecv@infoitem{\ecv@addresskey}{\ecv@officeAddress}}%
    \ifx\@empty\ecv@date\else
      \vspace{.3em}{\color{ecvdate}\itshape
        {\let\\\relax\ecv@datekey}\unskip\space\ecv@date\par}%
    \fi
  }%
  \ifdim\wd\ecv@logobox>\z@
    \hfill\parbox[t]{\wd\ecv@logobox}{\vspace{0pt}\usebox\ecv@logobox}%
  \fi
  \par\vspace{#1}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sections and entries
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \section[<vspace>]{<title>}: the title is followed by a rule; the
% optional argument is the space after the title. Each section is also
% added to the PDF bookmarks.
\newcounter{ecv@section}
\renewcommand{\section}{\@ifstar{\ecv@section}{\ecv@section}}
\newcommand{\ecv@section}[2][.6em]{%
  \par\addvspace{1.4em}%
  \stepcounter{ecv@section}%
  \pdfbookmark[1]{#2}{ecv@section.\theecv@section}%
  \noindent{\color{ecvaccent}\large\bfseries\MakeUppercase{#2}}%
  \hspace{.6em}{\color{ecvaccent}\leaders\hrule height 3.4pt depth -2.6pt\hfill}%
  \par\nobreak\vspace{#1}%
  \@afterheading
}
\let\ecvsection\section
\renewcommand{\subsection}{\@ifstar{\ecv@subsection}{\ecv@subsection}}
\newcommand{\ecv@subsection}[2][.3em]{%
  \par\addvspace{.9em}%
  \noindent{\bfseries #2}\par\nobreak\vspace{#1}%
  \@afterheading
}

% \ecventry{<dates>}{<place>}{<title>}{<organisation>}, followed by the
% description (text, lists, ...). Empty arguments are omitted.
\newcommand\ecventry[4]{%
  \par\addvspace{.9em}%
  \def\@tempa{#1#2}%
  \ifx\@tempa\@empty\else
    \noindent{\small\color{ecvdate}#1%
      \def\@tempa{#1}\def\@tempb{#2}%
      \ifx\@tempa\@empty\else\ifx\@tempb\@empty\else
        \hspace{.5em}{\color{ecvaccent}\textbar}\hspace{.5em}\fi\fi
      #2\par}\nobreak
  \fi
  \def\@tempa{#3}%
  \ifx\@tempa\@empty\else
    \noindent{\bfseries #3\par}\nobreak
  \fi
  \def\@tempa{#4}%
  \ifx\@tempa\@empty\else
    \noindent{#4\par}\nobreak
  \fi
  \vspace{.3em}%
  \@afterheading
}

% \ecvitem[<vspace>]{<label>}{<text>}: as in europecv. A short label
% (e.g. [J1] for a publication) is set on the left of the text, with a
% hanging indentation; a longer one (e.g. dates) above the text. The
% starred form puts a bullet before the label.
\newlength\ecv@itemlabelwidth
\setlength\ecv@itemlabelwidth{3em}
\newif\if@ecvitemstar
\newcommand\ecvitem{\@ifstar{\@ecvitemstartrue\@ecvitem}%
  {\@ecvitemstarfalse\@ecvitem}}
\newcommand\@ecvitem[3][.4em]{%
  \par
  \sbox\@tempboxa{\small\if@ecvitemstar\textbullet\ \fi#2}%
  \ifdim\wd\@tempboxa=\z@
    \noindent #3\par
  \else\ifdim\wd\@tempboxa<\ecv@itemlabelwidth
    \hangindent\ecv@itemlabelwidth
    \noindent\makebox[\ecv@itemlabelwidth][l]{\color{ecvdate}\usebox\@tempboxa}%
    #3\par
  \else
    \noindent{\small\color{ecvdate}\usebox\@tempboxa\par}\nobreak
    \noindent #3\par
  \fi\fi
  \vspace{#1}%
}
\newcommand{\ecvbullet}{\raisebox{.35ex}[0cm][0cm]{\tiny\textbullet}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Language skills
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand*\ecvmothertongue[2][.8em]{%
  \par\noindent\ecv@mothertonguekey: \textbf{#2}\par\vspace{#1}%
}

\newlength\ecv@levelwidth
\newcommand*\ecv@setlevelwidth{%
  \setlength\ecv@levelwidth{\linewidth}%
  \addtolength\ecv@levelwidth{-\ecv@langwidth}%
  \divide\ecv@levelwidth by 5
  \addtolength\ecv@levelwidth{-2\tabcolsep}%
}
\newcommand*\ecv@rule{%
  \par\nointerlineskip\noindent{\color{ecvaccent}\rule{\linewidth}{.4pt}}\par
  \nointerlineskip}
\newcommand\ecv@langrow[6]{%
  \ecv@setlevelwidth
  \noindent
  \begin{tabular}{@{}p{\ecv@langwidth}@{}
      *{5}{>{\centering\arraybackslash}p{\ecv@levelwidth}}@{}}
    #1 & #2 & #3 & #4 & #5 & #6
  \end{tabular}\par
}

% The argument is accepted for compatibility with europecv and ignored
\newcommand*\ecvlanguageheader[1]{%
  \par\noindent\ecv@otherlangkey:\par\nobreak\vspace{.4em}%
  \ecv@setlevelwidth
  \begingroup\small\bfseries\color{ecvaccent}%
  \noindent
  \begin{tabular}{@{}p{\ecv@langwidth}@{}
      >{\centering\arraybackslash}p{\dimexpr2\ecv@levelwidth+2\tabcolsep\relax}
      >{\centering\arraybackslash}p{\dimexpr2\ecv@levelwidth+2\tabcolsep\relax}
      >{\centering\arraybackslash}p{\ecv@levelwidth}@{}}
    & \ecv@understandkey & \ecv@speakkey
    & \ecv@writekey
  \end{tabular}\par\nobreak
  \endgroup
  \begingroup\footnotesize\color{ecvaccent}%
  \ecv@langrow{}{\ecv@listenkey}{\ecv@readkey}{\ecv@interactkey}%
    {\ecv@productkey}{}%
  \endgroup
  \nobreak\ecv@rule
}
% \ecvlanguage[<vspace>]{<language>}{<listening>}{<reading>}%
%   {<spoken interaction>}{<spoken production>}{<writing>}
\newcommand*\ecvlanguage[7][0pt]{%
  \nobreak\vspace{.2em}%
  \ecv@langrow{\textbf{#2}}{#3}{#4}{#5}{#6}{#7}%
  \vspace{.2em}\ecv@rule\vspace{#1}%
}
\let\ecvlastlanguage\ecvlanguage
% Legend of the levels; the argument is accepted for compatibility with
% europecv and ignored
\newcommand*\ecvlanguagefooter[2][0pt]{%
  \par\vspace{.3em}%
  \noindent{\footnotesize\itshape\color{ecvdate}%
    \ecv@levelskey: A1/A2: \ecv@cefbasickey\ --
    B1/B2: \ecv@cefindepkey\ -- C1/C2: \ecv@cefprofkey\par}%
  \vspace{#1}%
}
\newcommand*\ecvCEF[2]{#1}
\newcommand*\ecvAOne{A1}
\newcommand*\ecvATwo{A2}
\newcommand*\ecvBOne{B1}
\newcommand*\ecvBTwo{B2}
\newcommand*\ecvCOne{C1}
\newcommand*\ecvCTwo{C2}

\endinput
