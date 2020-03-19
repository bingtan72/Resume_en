
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
%% v1.4: Detect TL2018 to handle accented characters in class information
\@ifl@t@r\fmtversion{2018/04/01}{\UseRawInputEncoding}{}
\ProvidesClass{altacv}[2018/07/27 AltaCV v1.1.4, yet another alternative class for a résumé/curriculum vitae.]

%% v1.1: Optionally load academicons
\newif\if@academicons
\DeclareOption{academicons}{\@academiconstrue}
%% v1.1.3: Choice of round/square photo
\newif\if@normalphoto
\DeclareOption{normalphoto}{\@normalphototrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax

\LoadClass{extarticle}

\RequirePackage[margin=2cm]{geometry}
\RequirePackage{fontawesome}

%% v1.1: Optionally load academicons
\if@academicons
  %% Patch to make academicons compilable with XeLaTeX
  \ExplSyntaxOn
  \msg_redirect_name:nnn { fontspec } { font-not-found } { none }
  \ExplSyntaxOff
  \RequirePackage{academicons}
  \newfontfamily{\AI}{academicons.ttf}
\fi

\RequirePackage{xcolor}

\colorlet{accent}{blue!70!black}
\colorlet{heading}{black}
\colorlet{emphasis}{black}
\colorlet{body}{black!80!white}
\newcommand{\itemmarker}{{\small\textbullet}}
\newcommand{\ratingmarker}{\faCircle}
\usepackage{pdfpages}
\RequirePackage{tikz}
\usetikzlibrary{arrows}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{enumitem}
\setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vskip0.25\baselineskip}
\setlist[itemize]{label=\itemmarker}
\RequirePackage{graphicx}
\RequirePackage{etoolbox}
\RequirePackage{dashrule}
\RequirePackage{multirow,tabularx}
\RequirePackage{changepage}
% \RequirePackage{marginfix}

\setlength{\parindent}{0pt}
\newcommand{\divider}{\textcolor{body!30}{\hdashrule{\linewidth}{0.6pt}{0.5ex}}\smallskip}

\newenvironment{fullwidth}{%
  \begin{adjustwidth}{}{\dimexpr-\marginparwidth-\marginparsep\relax}}
  {\end{adjustwidth}}





\newcommand{\emailsymbol}{\faAt}
\newcommand{\phonesymbol}{\faPhone}
\newcommand{\homepagesymbol}{\faChain}
\newcommand{\locationsymbol}{\faMapMarker}
\newcommand{\linkedinsymbol}{\faLinkedin}
\newcommand{\twittersymbol}{\faTwitter}
\newcommand{\githubsymbol}{\faGithub}
\newcommand{\orcidsymbol}{\aiOrcid}
\newcommand{\mailsymbol}{\faEnvelope}

\newcommand{\printinfo}[2]{\mbox{\textcolor{accent}{\normalfont #1}\hspace{0.5em}#2\hspace{2em}}}

\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\photo}[2]{\def\@photo{#2}\def\@photodiameter{#1}}
\newcommand{\email}[1]{\printinfo{\emailsymbol}{#1}}
\newcommand{\mailaddress}[1]{\printinfo{\mailsymbol}{#1}}
\newcommand{\phone}[1]{\printinfo{\phonesymbol}{#1}}
\newcommand{\homepage}[1]{\printinfo{\homepagesymbol}{#1}}
\newcommand{\twitter}[1]{\printinfo{\twittersymbol}{#1}}
\newcommand{\linkedin}[1]{\printinfo{\linkedinsymbol}{#1}}
\newcommand{\github}[1]{\printinfo{\githubsymbol}{#1}}
\newcommand{\orcid}[1]{\printinfo{\orcidsymbol}{#1}}
\newcommand{\location}[1]{\printinfo{\locationsymbol}{#1}}

\newcommand{\personalinfo}[1]{\def\@personalinfo{#1}}

\newcommand{\makecvheader}{%
  \begingroup
    \ifdef{\@photodiameter}{\begin{minipage}{\dimexpr\linewidth-\@photodiameter-2em}}{}%
    \raggedright\color{heading}%
    {\Huge\bfseries{\@name}\par}
    \medskip
    {\large\bfseries\color{accent}\@tagline\par}
    \medskip
    {\large\color{accent}\@personalinfo\par}
    \ifdef{\@photodiameter}{%
    \end{minipage}\hfill%
    \begin{minipage}{\@photodiameter}
    \if@normalphoto
      \includegraphics[width=\linewidth]{\@photo}
    \else
      \tikz\path[fill overzoom image={\@photo}]circle[radius=0.5\linewidth];
    \fi%
    \end{minipage}\par}{}%
  \endgroup\medskip
}

\renewenvironment{quote}{\color{accent}\itshape\large}{\par}

\newcommand{\cvsection}[2][]{%
  \bigskip%
  \ifstrequal{#1}{}{}{\marginpar{\vspace*{\dimexpr1pt-\baselineskip}\raggedright\input{#1}}}%
  {\color{heading}\Large\bfseries{#2}}\\[-1ex]%
 \bigskip%
}

\newcommand{\cvsubsection}[1]{%
  \smallskip%
  {\color{emphasis}\large\bfseries{#1}\par}\medskip
}

% v1.1.4: fixes inconsistent font size
\newcommand{\cvevent}[5]{%
  {\large\color{emphasis}#1\par}
  \smallskip\normalsize
  \ifstrequal{#2}{}{}{
  \textbf{\color{accent}#2}\par
  \smallskip}
  \ifstrequal{#3}{}{}{{\small\makebox[0.4\linewidth][l]{\hspace{0.5em}#3}}}%
  \ifstrequal{#4}{}{}{{\small\makebox[0.35\linewidth][l]{\hspace{0.5em}#4}}}%
\ifstrequal{#5}{}{}{{\small\makebox[0.4\linewidth][l]{\faBriefcase
\hspace{0.5em}#5~hrs}}}\par
\smallskip
}
\newcommand{\pic}[3]{%
\includegraphics[width=#2in, height=#3in]{#1}
}

\newcommand{\edua}[7]{%
  \begin{tabularx}{\linewidth}{@{}p{4em} @{\hspace{1ex}} >{\raggedright\arraybackslash}X@{}}
	\multirow{2}{*}{\Large\color{accent}{#1}} & {\small\makebox[0.8\linewidth][l]{\large\color{emphasis}{{#2}}}}{\small\makebox[0.2\linewidth][l]{\hspace{0.5em}{#4}}}\smallskip\\ & {\makebox[0.8\linewidth][l]{\textbf{\color{accent}{#5}}}}{\small\makebox[0.2\linewidth][l]{\hspace{0.5em}{#7}}}\smallskip\\ &  {\small\makebox[0.5\linewidth][l]{\hspace{0.5em}{#3}}}{\small\makebox[0.5\linewidth][l]{\hspace{0.5em}{{#6}}}}
\end{tabularx}%
	\smallskip
}	
\newcommand{\experience}[7]{%
\begin{tabularx}{\linewidth}{@{}p{0.5in} @{\hspace{0ex}} >{\raggedright\arraybackslash}X@{}}
	\multirow{2}{*}{\large\color{Black}{#1}} & {\small\makebox[0.8\linewidth][l]{\textbf{\large\color{Black}{#5}}}}{\small\makebox[0.2\linewidth][l]{ \mbox{}\hfill{{#3}}}}\smallskip\\ & {\makebox[0.8\linewidth][l]{\large{\color{accent}{{#2}}}}}{\small\makebox[0.2\linewidth][l]{ \mbox{}\hfill{{#6}}}}%
	\smallskip%
\end{tabularx}%
}

\newcommand{\centered}[1]{\begin{tabular}{l} #1 \end{tabular}}


\newcommand{\educ}[7]{%
\begin{tabularx}{\linewidth}{@{}p{0.5in} @{\hspace{1ex}} >{\raggedright\arraybackslash}X@{}}
	\multirow{3}{*}{\large\color{accent}{#1}} & ~\\ & {\makebox[0.8\linewidth][l]{\textbf{\large{\color{accent}{#5}}}}}{\small\makebox[0.2\linewidth][l]{\mbox{}\hfill{#6}}} %
\end{tabularx}
}

\newcommand{\edud}[7]{%
\begin{tabularx}{\linewidth}{@{}p{0em} @{\hspace{1ex}} >{\raggedright\arraybackslash}X@{}}
	\multirow{2}{*}{\Large\color{accent}{#1}} & {\small\makebox[0.8\linewidth][l]{\large\color{emphasis}{#2}}}{\small\makebox[0.2\linewidth][l]{\mbox{}\hfill {#3}\mbox{\hspace{0.3in}}}}
\end{tabularx}%
\vspace{-5mm}
}

\newcommand{\proj}[3]{%
	{\makebox[0.8\linewidth][l]{\normalsize\color{accent}{#1}}}{\small\makebox[0.2\linewidth][l]{ \mbox{}\hfill#2}}
{#3\par}
}

\newcommand{\cvref}[2]{%
  \smallskip
  \textcolor{emphasis}{\textbf{#1}}\par
  \begin{description}[font=\color{accent},style=multiline,leftmargin=1.25em]
  \item[\normalfont\emailsymbol] #2
  \end{description}
}

% v1.1.2: make it easier to add a sidebar aligned with top of next page
\RequirePackage{afterpage}
\newcommand{\addsidebar}[2][]{\marginpar{%
  \ifstrequal{#1}{}{}{\vspace*{#1}}%
  \input{#2}}%
}

\AtBeginDocument{%
  \pagestyle{empty}
  \color{body}
  \raggedright
}


%% Linked Itemize

\newcounter{mylist} % new counter for amount of lists
\newcounter{mycnt}[mylist] % create new item counter
\newcounter{mytmp}[mylist] % tmp counter needed for checking before/after current item

\newcommand{\drawoptionsconn}{gray, shorten <= .5mm, shorten >= .5mm, thick}
\newcommand{\drawoptionsshort}{gray, shorten <= .5mm, shorten >= -1mm, thick}

\newcommand{\myitem}{% Modified `\item` to update counter and save nodes
  \stepcounter{mycnt}%
  \item[\linkedlist{%
    i\alph{mylist}\arabic{mycnt}}]%
  \label{item-\alph{mylist}\arabic{mycnt}}%
  \ifnum\value{mycnt}>1%
    \ifnum\getpagerefnumber{item-\alph{mylist}\arabic{mytmp}}<\getpagerefnumber{item-\alph{mylist}\arabic{mycnt}}%
      \begin{tikzpicture}[remember picture,overlay]%
        \expandafter\draw\expandafter[\drawoptionsshort] (i\alph{mylist}\arabic{mycnt}) --
          ++(0,3mm) --
          (i\alph{mylist}\arabic{mycnt} |- current page text area.north);% draw short line
      \end{tikzpicture}%
    \else%
      \begin{tikzpicture}[remember picture,overlay]%
        \expandafter\draw\expandafter[\drawoptionsconn] (i\alph{mylist}\arabic{mytmp}) -- (i\alph{mylist}\arabic{mycnt});% draw the connecting lines
      \end{tikzpicture}%
    \fi%
  \fi%
  \addtocounter{mytmp}{2}%
  \IfRefUndefinedExpandable{item-\alph{mylist}\arabic{mytmp}}{}{% defined
    \ifnum\getpagerefnumber{item-\alph{mylist}\arabic{mytmp}}>\getpagerefnumber{item-\alph{mylist}\arabic{mycnt}}%
      \begin{tikzpicture}[remember picture,overlay]%
      \expandafter\draw\expandafter[\drawoptionsshort] (i\alph{mylist}\arabic{mycnt}) --
        ++(0,-3mm) --
        (i\alph{mylist}\arabic{mycnt} |- current page text area.south);% draw short line
      \end{tikzpicture}%
    \fi%
  }%
  \addtocounter{mytmp}{-1}%
}

\newcommand{\linkedlist}[1]{
  \raisebox{0pt}[0pt][0pt]{\begin{tikzpicture}[remember picture]%
  \node (#1) [gray,circle,fill,inner sep=1.5pt]{};
  \end{tikzpicture}}%
}

\newenvironment{myitemize}{%
% Create new `myitemize` environment to keep track of the counters
  \stepcounter{mylist}% increment list counter
  \begin{itemize}
}{\end{itemize}%
  }


\newcommand{\physlablink}[1]{%
\textcolor{blue}{\href{#1}{physlab.org}}}

\newcommand{\rglink}[1]{%
\textcolor{blue}{\href{#1}{researchgate.net}}}
%%%% TO RIGHT #####
\newcommand{\dragright}[1]{%
\mbox{}\hfill\small{#1\quad}%
}











%%%%%% Custom Item %%%%%%%%%%%%%
\newlist{cvitemize}{itemize}{3}

\setlist[cvitemize,1]{label=$\bullet$,topsep=0pt,itemsep=1.11pt}

\setlist[cvitemize,2]{label={--},leftmargin=-0.5cm,font=\bfseries,topsep=0pt,itemsep=1.11pt}



%%%%%% tabitemize %%%%%%%%%%%%%
\NewEnviron{tabitemize}
{\begin{addtab}
    \begin{cvitemize}
    \BODY
    \end{cvitemize}
\end{addtab}}

%%%%%% addtab %%%%%%%%%%%%%
\newenvironment{addtab}{%
\begin{adjustwidth}{0.5in}{}}
{\end{adjustwidth}}
%%%%%% cvtab %%%%%%%%%%%%%
\newenvironment{cvtab}{%
\begin{adjustwidth}{0.4in}{}}
{\end{adjustwidth}}
%%%%%% addsubtab %%%%%%%%%%%%%
\newenvironment{addsubtab}{%
\begin{adjustwidth}{0.25in}{}}
{\end{adjustwidth}}


%%%%%% linkeditem %%%%%%%%%%%%%
\NewEnviron{linkeditemize}
{\begin{myitemize}
    \addtolength{\itemindent}{0.45cm}
    \BODY
\begin{linkeditemize}}
    
%%%%%% rightside %%%%%%%%%%%%%    
\newcommand{\rightside}[1]{ \mbox{}\hfill \small{#1}}


%%%%%% rightside %%%%%%%%%%%%%
\newcommand{\whitetext}[1]{\textcolor{white}{{\fontsize{0.1}{0} \selectfont #1}}}