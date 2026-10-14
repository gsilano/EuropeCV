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
%% This work consists of the files europecv.cls, ecv*.def and
%% europecv.tex, together with the images, examples and templates
%% listed in the README.md file.
%%
%% Development: https://github.com/gsilano/EuropeCV
%% CTAN:        https://ctan.org/pkg/europecv
%%
\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{europecv}[2026/10/14 v2026.10.14 European curriculum vitae class]

% Europass CV models and instructions:
%   https://europass.europa.eu/
% Common European Framework of Reference for Languages (CEFR):
%   https://www.coe.int/en/web/common-european-framework-reference-languages

% Wrapper used by the language definition files (ecv*.def), which are
% always UTF-8 encoded. With 8-bit engines, the text is locally read as
% UTF-8 even when the document uses another input encoding (e.g., latin1).
% Unicode engines (XeTeX and LuaTeX) need no special treatment.
% The detection of Unicode engines was originally contributed by
% David Carlisle.
\ifx\Umathchar\@undefined
  \def\ecv@str@utfviii{utf8}
  \def\ecv@str@utfviiix{utf8x}
  \newcommand\ecv@utf[1]{{%
    \ifx\inputencodingname\@undefined\else
      \edef\@tempa{\inputencodingname}%
      \ifx\@tempa\ecv@str@utfviii\else
        \ifx\@tempa\ecv@str@utfviiix\else
          \inputencoding{utf8}%
        \fi
      \fi
    \fi
    #1}}
\else
  \newcommand\ecv@utf[1]{{#1}}
\fi
\newcommand{\ecv@upshape}[1]{\textup{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Language options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \ecv@declarelanguage{<option>}{<def file suffix>}{<language name>}
% loads ecv<suffix>.def at the end of the class.
\newcommand*\ecv@declarelanguage[3]{%
  \DeclareOption{#1}{%
    \AtEndOfClass{%
      \InputIfFileExists{ecv#2.def}{}{%
        \ClassWarningNoLine{europecv}%
          {#3 definition file `ecv#2.def' not found}}%
    }%
  }%
}

% English is always loaded first (see \ExecuteOptions below): it provides
% the fallback for any key that a translation does not define.
\DeclareOption{english}{%
  \AtEndOfClass{%
    \InputIfFileExists{ecven.def}{}{%
      \ClassError{europecv}{English definition file `ecven.def' not found}%
      {The file should be inside the europecv folder.\MessageBreak
       Try to re-install the europecv class.}}%
  }%
}
\ecv@declarelanguage{italian}{it}{Italian}
\ecv@declarelanguage{spanish}{es}{Spanish}
\ecv@declarelanguage{french}{fr}{French}
\ecv@declarelanguage{danish}{da}{Danish}
\ecv@declarelanguage{german}{de}{German}
\ecv@declarelanguage{finnish}{fi}{Finnish}
\ecv@declarelanguage{portuges}{pt}{Portuguese}
\ecv@declarelanguage{portuguese}{pt}{Portuguese}
\ecv@declarelanguage{swedish}{sv}{Swedish}
\ecv@declarelanguage{norwegian}{no}{Norwegian}
\ecv@declarelanguage{dutch}{nl}{Dutch}
\ecv@declarelanguage{catalan}{ca}{Catalan}
\ecv@declarelanguage{polish}{pl}{Polish}
\DeclareOption{hungarian}{%
  \AtEndOfClass{%
    \InputIfFileExists{ecvhu.def}{}{%
      \ClassWarningNoLine{europecv}%
        {Hungarian definition file `ecvhu.def' not found}}%
    % Hungarian puts the page number before the word "page"
    \ecvpage{\thepage\ifx\@empty\ecv@totpages.\else\ecv@totpages\fi~\ecv@pagekey}%
    \def\ecv@lfoot{%
      \footnotesize\textrm{\ecv@page~- \textrm{\ecv@footername} \ecv@cvofkey}}%
  }%
}
\ecv@declarelanguage{estonian}{et}{Estonian}
\ecv@declarelanguage{icelandic}{is}{Icelandic}
\ecv@declarelanguage{lithuanian}{lt}{Lithuanian}
\ecv@declarelanguage{czech}{cs}{Czech}
\ecv@declarelanguage{slovak}{sk}{Slovak}
\ecv@declarelanguage{latvian}{lv}{Latvian}
\ecv@declarelanguage{slovenian}{sl}{Slovenian}
\DeclareOption{romanian}{%
  % Provides \cb for comma-below letters (s and t)
  \AtEndOfClass{\RequirePackage{combelow}}%
  \AtEndOfClass{%
    \InputIfFileExists{ecvro.def}{}{%
      \ClassWarningNoLine{europecv}%
        {Romanian definition file `ecvro.def' not found}}%
  }%
}
\ecv@declarelanguage{maltese}{mt}{Maltese}
\ecv@declarelanguage{bulgarian}{bg}{Bulgarian}
\ecv@declarelanguage{greek}{gr}{Greek}
\ecv@declarelanguage{galician}{gl}{Galician}
\ecv@declarelanguage{serbian}{sr}{Serbian}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input encodings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Each option loads the inputenc package with the given encoding.
% UTF-8 is the LaTeX default, so utf8 (and the obsolete utf8x, which is
% mapped to utf8) is effectively a no-op with pdfLaTeX. Unicode engines
% (XeLaTeX, LuaLaTeX) always read UTF-8 and ignore these options.
\newcommand*\ecv@inputenc[1]{%
  \ifx\Umathchar\@undefined
    \AtEndOfClass{\RequirePackage[#1]{inputenc}}%
  \else
    \ClassWarningNoLine{europecv}{Option `#1' ignored: Unicode engines
      always\MessageBreak read UTF-8 input}%
  \fi
}
\newcommand*\ecv@declareinputenc[1]{%
  \DeclareOption{#1}{\ecv@inputenc{#1}}%
}
\ecv@declareinputenc{ascii}
\ecv@declareinputenc{latin1}
\ecv@declareinputenc{latin2}
\ecv@declareinputenc{latin3}
\ecv@declareinputenc{latin4}
\ecv@declareinputenc{latin5}
\ecv@declareinputenc{latin9}
\ecv@declareinputenc{latin10}
\ecv@declareinputenc{decmulti}
\ecv@declareinputenc{cp850}
\ecv@declareinputenc{cp852}
\ecv@declareinputenc{cp858}
\ecv@declareinputenc{cp437}
\ecv@declareinputenc{cp437de}
\ecv@declareinputenc{cp865}
\ecv@declareinputenc{applemac}
\ecv@declareinputenc{next}
\ecv@declareinputenc{cp1250}
\ecv@declareinputenc{cp1252}
\ecv@declareinputenc{cp1257}
\ecv@declareinputenc{ansinew}
\ecv@declareinputenc{utf8}
\DeclareOption{utf8x}{\ecv@inputenc{utf8}}
\ecv@declareinputenc{koi8-r}
\ecv@declareinputenc{koi8-ru}
\ecv@declareinputenc{koi8-u}
\ecv@declareinputenc{cp1251}
\ecv@declareinputenc{cp855}
\ecv@declareinputenc{cp866}
\ecv@declareinputenc{maccyr}
\ecv@declareinputenc{macukr}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{helvetica}{%
  \renewcommand{\rmdefault}{phv}%
  \renewcommand{\sfdefault}{phv}%
}
\DeclareOption{arial}{%
  \renewcommand{\rmdefault}{ma1}% (this font is NOT installed by default!)
  \renewcommand{\sfdefault}{ma1}%
}
\DeclareOption{narrow}{%
  \renewcommand{\seriesdefault}{c}% Narrow
  \renewcommand{\bfdefault}{bc}%    Boldface narrow
}

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
% Cross-referenced numbered entries (publications, projects, awards...)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \ecv@settarget{<key>}{<text>} typesets <text>, makes it the target of
% a hyperlink named <key>, and records <text> in the .aux file so that
% \ecv@reflink{<key>} can print it (as a link) anywhere in the document.
% The recorded text is stored in \ecv@ref@<key>, so that any key can be
% used without the risk of overwriting existing commands.
\newcommand*\ecv@setref[2]{\global\@namedef{ecv@ref@#1}{#2}}
\newcommand\ecv@settarget[2]{%
  \hypertarget{#1}{#2}%
  \protected@write\@auxout{}{\string\ecv@setref{#1}{#2}}%
}
\newcommand*\ecv@reflink[1]{%
  \@ifundefined{ecv@ref@#1}{%
    \textbf{??}%
    \G@refundefinedtrue
    \ClassWarning{europecv}{Reference `#1' on page \thepage\space
      undefined}%
  }{%
    \hyperlink{#1}{\@nameuse{ecv@ref@#1}}%
  }%
}
% \myhyperlink is kept for backward compatibility with older versions of
% the class (it is defined at \begin{document} with \providecommand, so a
% user definition made in the preamble takes precedence)
\AddToHook{begindocument/before}{\providecommand*\myhyperlink[1]{\ecv@reflink{#1}}}

% \ecvNewReferenceType{<Name>}{<prefix>} defines the counter <Name> and
% the commands \ecvdisplay<Name>[<key>] and \ecvref<Name>[<key>].
% \ecvdisplay<Name> steps the counter and prints [<prefix><number>];
% \ecvref<Name> prints a link to the entry labelled <key>.
\newcommand*\ecvNewReferenceType[2]{%
  \newcounter{#1}%
  \expandafter\newcommand\csname ecvdisplay#1\endcsname[1][]{%
    \stepcounter{#1}%
    \ecv@settarget{##1}{[#2\csname the#1\endcsname]}%
  }%
  \expandafter\newcommand\csname ecvref#1\endcsname[1][]{%
    \ecv@reflink{##1}%
  }%
}
\@onlypreamble\ecvNewReferenceType

\ecvNewReferenceType{ConferencePublications}{C}
\ecvNewReferenceType{BookChapterPublications}{BC}
\ecvNewReferenceType{ReferredJournalsPublications}{J}
\ecvNewReferenceType{Workshops}{W}
\ecvNewReferenceType{Posters}{P}
\ecvNewReferenceType{ResearchProjects}{RP}
\ecvNewReferenceType{Awards}{A}
% Old name, kept for backward compatibility
\let\ecvrefWorkshopsPublications\ecvrefWorkshops

% Footnote-like references are typeset as a superscript number
\newcounter{FootNoteCounter}
\newcommand{\ecvdisplayFootNoteCounter}[1][]{%
  \stepcounter{FootNoteCounter}%
  \ecv@settarget{#1}{\textsuperscript{\theFootNoteCounter}}%
}
\newcommand{\ecvrefFootNoteCounter}[1][]{%
  \ecv@reflink{#1}%
}

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

% Make sure that the .aux file can still be read if the class is
% changed after a compilation
\AddToHook{begindocument}{%
  \if@filesw
    \immediate\write\@mainaux{\string\providecommand\string\ecv@setref[2]{}}%
  \fi
}

% Thanks to Roman Bertle for suggesting the following:
\renewcommand{\labelitemi}{\normalfont\bfseries \textendash}
\renewcommand{\labelitemii}{\textasteriskcentered}
\renewcommand{\labelitemiii}{\textperiodcentered}

\newcommand*{\ecvfirstname}[1]{\def\ecv@firstname{#1}} % Deprecated
\newcommand*{\ecvlastname}[1]{\def\ecv@lastname{#1}} % Deprecated
\newcommand*{\ecvname}[1]{\def\ecv@name{#1}} % Replaces the above
\newcommand*{\ecvfootername}[1]{\def\ecv@footername{#1}}
% \ecvaddress[mobileAddress][officeAddress]{homeAddress}
\def\ecvaddress{%
   \@ifnextchar[%
     {\ecvaddress@i}
     {\ecvaddress@i[]}%
}
\def\ecvaddress@i[#1]{%
   \@ifnextchar[%
     {\ecvaddress@ii{#1}}
     {\ecvaddress@ii{#1}[]}%
}
\def\ecvaddress@ii#1[#2]#3{%
 \def\ecv@mobileAddress{#1}
 \def\ecv@officeAddress{#2}
 \def\ecv@address{#3}
}
% \ecvtelephone[mobile][office]{home}
\def\ecvtelephone{%
   \@ifnextchar[%
     {\ecvtelephone@i}
     {\ecvtelephone@i[]}%
}
\def\ecvtelephone@i[#1]{%
   \@ifnextchar[%
     {\ecvtelephone@ii{#1}}
     {\ecvtelephone@ii{#1}[]}%
}
\def\ecvtelephone@ii#1[#2]#3{%
 \def\ecv@mobile{#1}
 \def\ecv@office{#2}
 \def\ecv@telephone{#3}
}
\newcommand*{\ecvfax}[1]{\def\ecv@fax{#1}}
\newcommand*{\ecvdate}[1]{\def\ecv@date{#1}}
\newcommand*{\ecvemail}[1]{\def\ecv@email{#1}}
\newcommand*{\ecvprofessional}[1]{\def\ecv@professional{#1}}
\newcommand*{\ecvskype}[1]{\def\ecv@skype{#1}}
\newcommand*{\ecvmatrixriot}[1]{\def\ecv@matrixriot{#1}}
\newcommand*{\ecvyoutube}[1]{\def\ecv@youtube{#1}}
\newcommand*{\ecvpec}[1]{\def\ecv@pec{#1}}
\newcommand*{\ecvhomepage}[1]{\def\ecv@homepage{#1}}
\newcommand*{\ecvnationality}[1]{\def\ecv@nationality{#1}}
\newcommand*{\ecvdateofbirth}[1]{\def\ecv@birth{#1}}
\newcommand*{\ecvgender}[1]{\def\ecv@gender{#1}}
% Personal picture
\newcommand*{\ecvdrawpicture}{}
\newcommand*{\ecvbeforepicture}[1]{\def\ecv@beforepic{#1}}
\newcommand*{\ecvafterpicture}[1]{\def\ecv@afterpic{#1}}
\newcommand*\ecvpicture{%
\@ifnextchar[\ecv@picture{\ecv@picture[]}}
\def\ecv@picture[#1]#2{%
\def\ecvarg{#2}
\ifx\@empty\ecvarg\renewcommand*{\ecvdrawpicture}{}\else
\renewcommand*{\ecvdrawpicture}{\includegraphics[#1]{#2}}
\fi}
% The following must be used inside \ecvbeforepicture
% or \ecvafterpicture
\newcommand*{\ecvspace}[1]{\tabularnewline[#1] &}
\ecvbeforepicture{\raggedleft}
\ecvdate{}
\ecvafterpicture{}
\ecvfirstname{}
\ecvlastname{}
\ecvname{\ecv@lastname\ \ecv@firstname}
\ecvfootername{\ecv@name}
\ecvaddress{}
\ecvskype{}
\ecvmatrixriot{}
\ecvyoutube{}
\ecvprofessional{}
\ecvtelephone{}
\ecvfax{}
\ecvemail{}
\ecvpec{}
\ecvnationality{}
\ecvdateofbirth{}
\ecvgender{}
\ecvhomepage{}
\ecvpicture{}


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
