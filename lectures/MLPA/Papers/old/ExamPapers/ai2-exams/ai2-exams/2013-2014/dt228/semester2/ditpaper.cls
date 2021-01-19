% Filename  : ditpaper.cls
% Purpose   : A LaTeX class for producing exam papers and/or model solutions
%                 in accordance with DIT guidelines.
% Author    : Emmet Caulfield
% Revision  : $Id: ditpaper.cls 3 2006-02-20 16:29:53Z emmet $
% Repository: $HeadURL: http://svn.netrogen.lan/tex-ditpaper/trunk/ditpaper.cls $
%
\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{ditpaper}[2004/08/19 (C) Emmet Caulfield]

%============================================================
% This class is for DIT exam papers; it is based on the base
% 'article' class.
%
% This class is compatible with 'amssymb', 'graphicx', and 
% 'subfigure' (I've used them) and I have no real reason to
% believe that it would be incompatible with any package. 
%------------------------------------------------------------


% For the exam code in the top-right corner, using the 
% 'fancyhdr' package is way handier than rolling our own 
% \rhead command.
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{times}

%====================== OPTIONS SECTION =====================
% For keeping track of the 'solution' option which (when 
% included) causes the marking scheme or model solution to be 
% included in the output.
\newif\ifsolution \solutionfalse
\DeclareOption{solution}{\solutiontrue}
\DeclareOption{nosolution}{\solutionfalse}
\PassOptionsToClass{a4paper,oneside}{article}
\DeclareOption*{%
	\PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}
%------------------------------------------------------------


%============================================================
% When the solutions are included, we want it to be *very*
% obvious: 'SOLUTIONS' is emblazoned across the page and
% written into the headers
%------------------------------------------------------------
\newcommand\@solStamp{}
\ifsolution
   \renewcommand\@solStamp{\bfseries{*** SOLUTIONS ***}}
   \ifx\pdfoutput\undefined% We are not running pdfLaTeX
      \RequirePackage{draftcopy}
      \draftcopyName{SOLUTIONS}{120}
   \else
      \RequirePackage{pdfdraftcopy}
      \draftstring{SOLUTIONS}
      \draftfontsize{120}
      \draftcolor{gray20}
   \fi
\fi
%------------------------------------------------------------


%============================================================
\newcommand\@facility{FLOUNDER STREET, DUBLIN 42 (\emph{use \texttt{\bs{}facility\{\}}})}
\newcommand\facility[1]{\renewcommand\@facility{\MakeUppercase{#1}}}
\newcommand\@course{BSc Widget Pegging}
\newcommand\course[1]{\renewcommand\@course{#1}}
\newcommand\@stage{Year 9}
\newcommand\stage[1]{\renewcommand\@stage{#1}}
\newcommand\@session{Mental Examinations 20xx}
\newcommand\session[1]{\renewcommand\@session{\MakeUppercase{#1}}}
\renewcommand\title[1]{\renewcommand\@title{#1}}

\newcommand\@examcode{Z123/456}
\newcommand\examcode[1]{\renewcommand\@examcode{#1}}

\newcommand\@examiners{Examiners' Names}
\newcommand\examiners[1]{\renewcommand\@examiners{#1}}

\newcommand\@examdate{}
\newcommand\examdate[1]{\renewcommand\@examdate{#1 \hspace{1em} }}

\newcommand\@examtime{Time Allowed: 3 hours}
\newcommand\examtime[1]{\renewcommand\@examtime{#1}}

\newcommand\@instructions{Remove your shoes.\par{}Hold them aloft.}
\newcommand\instructions[1]{\renewcommand\@instructions{#1}}


%============================================================
% Eegads this is dreadful
%------------------------------------------------------------
\renewcommand\maketitle{\begin{titlepage}%
% Put exam code in right corner:
\begin{flushright}
  \@examcode
\end{flushright}
% Save the current \parskip value and use 3mm on the title
% page:
\newlength\saved@parskip
\setlength\saved@parskip\parskip
\setlength\parskip{3mm}
% Lay out the title page manually:
\begin{center}%
  {\textbf{DUBLIN INSTITUTE OF TECHNOLOGY}}\\
  {\textbf{\@facility}\\}%
  \vspace{2mm}%
  \rule{3cm}{1pt}\\%
  \vspace{3mm}%
  {\huge\textbf \@course \par}%
  \vspace{4mm}%
  {\large\textbf \@stage \par}%
  \rule{3cm}{1pt}\\%
  \vspace{4mm}%
  {\Large\textbf \@session \par}%
  \ifsolution
    {\Huge\textit\@solStamp\par}
  \fi
  \rule{3cm}{1pt}\\%
  \vspace{1cm}%
  {\Large\bfseries\textsc\@title \par}
  \vspace{1cm}%
  {\large \@examiners \par}
  \vspace{1cm}%
  {\large \@examdate \@examtime \par}
  \vspace{1cm}%
  {\large \@instructions \par}
  \ifsolution
    \vspace{1cm}
    \Huge \textit \@solStamp \par
    \Huge \textit \@solStamp \par
  \fi
\end{center}%
\setlength\parskip\saved@parskip
\end{titlepage}%
}


%============================================================
% So we can just say '\question blah', we abuse LaTeX's
% 'enumerate' environment, alias '\question' to '\item', and
% make the indent for top-level list environments zero.
\AtBeginDocument{%
  \maketitle

  % Make it so the examcode is in the top-right corner and page
  % numbers appear centred at the bottom.
  \fancyhf{}
  \renewcommand\headrulewidth{0pt}
  \renewcommand\footrulewidth{0pt}
  \pagestyle{fancy}
  \lhead{} \chead{\@solStamp} \rhead{\@examcode} 
  \lfoot{\@solStamp} \cfoot{Page \thepage ~ of \pageref{LastPage}} \rfoot{\@solStamp}

  \begin{enumerate}
}
\AtEndDocument{%
  \end{enumerate}
}
\newcommand\question{\vspace{5ex}\item}
\setlength\leftmargini{0em}
%------------------------------------------------------------


%============================================================
% Marks for a section appear flush-right in parentheses.
\renewcommand\marks[1]{%
  \begin{flushright}%
    (#1 marks)%
  \end{flushright}%
}
%------------------------------------------------------------


%============================================================
% Third level enumerated lists appear in brackets:
\renewcommand{\labelenumiii}{(\theenumiii)}
%------------------------------------------------------------


%============================================================
% It's handy to have \clearpage conditional on whether
% we're producing the solutions or the paper.
\newcommand\clearpageinsolution{%
\ifsolution
  \clearpage
\fi
}

\newcommand\clearpageinpaper{%
\ifsolution\else
  \clearpage
\fi
}
%------------------------------------------------------------


%============================================================
% 'answer' environment and 'ans' command for putting boxes 
% around the answers. Unfortunately, there is no easy way of
% putting something in a box that automatically splits over
% page breaks.
\newlength{\answidth} 
\newlength{\anspadding}
\setlength{\fboxsep}{4pt}

\newcommand*\setanswidth{%
    \setlength{\answidth}{\linewidth}%
    % anspadding = fboxsep + fboxrule:
    \setlength{\anspadding}{\fboxsep}%
    \addtolength{\anspadding}{\fboxrule}%
    \addtolength{\answidth}{-2\anspadding}%
}
 
\newcommand\ans[2]{ %
  \ifsolution%
    \setanswidth{}
    \par{}\fbox{%
      \parbox{\answidth}{\textsf{#2 \textbf{[#1]}}}
    }%
  \fi
}

\newsavebox\answerbox
\newenvironment{answer}{
    \setanswidth{}
    \setlength{\leftmargini}{2em}
    \setlength{\itemsep}{0ex}
    \setlength{\partopsep}{0ex}
    \begin{lrbox}{\answerbox}
        \begin{minipage}{\answidth}
          \begin{sffamily}
          \setlength\parskip{1ex}
}
{
          \end{sffamily}
        \end{minipage}
    \end{lrbox}
    \ifsolution
      \fbox{\usebox{\answerbox}}
%    \fbox[\textwidth][r]{\usebox{\answerbox}}
    \fi
}

% Sadly, we have to break answer boxes manually :-(
\newcommand\answerbreak{%
   \begin{flushright}%
      \textit{Continued\ldots{}}%
   \end{flushright}%
   \end{answer}%
   \begin{answer}%
      \textit{\ldots{}continued.}%
}
%------------------------------------------------------------
