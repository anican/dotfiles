\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mfcs}


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{theory}{
    \AtBeginDocument{\theory}
}
\DeclareOption{written}{
    \AtBeginDocument{\written}
}
\DeclareOption{homework}{\AtBeginDocument{\homework}}
\DeclareOption{programming}{\AtBeginDocument{\programming}}
\DeclareOption{solutions}{\AtBeginDocument{\solutions}}
\DeclareOption{quiz}{\AtBeginDocument{\quiz}}
\DeclareOption{recitation}{\AtBeginDocument{\recitation}}
\DeclareOption{ink}{\AtBeginDocument{\ink}}
\DeclareOption{section}{\AtBeginDocument{\sectionX}}
\DeclareOption{quickcheck}{\AtBeginDocument{\quickcheck}}
\DeclareOption{blastfromthepast}{\AtBeginDocument{\blastfromthepast}}
\DeclareOption{proofwriting}{\AtBeginDocument{\proofwriting}}
\DeclareOption{workshop}{\AtBeginDocument{\workshop}}
\DeclareOption{competition}{\AtBeginDocument{\competition}}
\DeclareOption{ep}{\AtBeginDocument{\ep}}

\DeclareOption{optional}{
    \AtBeginDocument{\optional}
}

\newcommand{\basecls}{
    \LoadClass[11pt, letterpaper]{article}
    \usepackage[letterpaper]{geometry} %showframe option is helpful for checking
    \geometry{textwidth=\paperwidth, textheight=\paperheight, noheadfoot}

    \setlength{\textwidth}{7in}
    \setlength{\textheight}{9.6in}

    \setlength{\oddsidemargin}{-0.3in}
    \setlength{\evensidemargin}{-0.3in}
    \setlength{\topmargin}{-0.3in}
    \setlength{\marginparsep}{0.3in}
    \setlength{\marginparwidth}{0pt}
    \setlength{\footskip}{30pt}

    \IfEndWith*{\jobname}{-solutions}{
        \AtBeginDocument{\solutions}
        \typeout{Compiling \jobname...}
    }{
        \typeout{Compiling \jobname...}
        \write18{lualatex --jobname="\jobname-solutions" \jobname}
    }
}
\DeclareOption{standalone}{\renewcommand{\basecls}{
    \LoadClass[border = 5pt]{standalone}}
    \AtBeginDocument{
        \NoHeader
        \NoPageNumbers
    }
}
\ProcessOptions\relax


\usepackage{xstring}
\basecls

%\RequirePackage{fullpage}

\newcommand{\mfcs}{}

\usepackage{upquote}
\usepackage[framemethod=tikz]{mdframed}
\usepackage{varwidth}
\usepackage{manfnt}
\usepackage[normalem]{ulem}
\usepackage{adjustbox}
\usepackage{etoolbox}
\usepackage{enumerate}
\usepackage{cancel}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage{amstext}
\usepackage{amscd}
\usepackage{amsmath}
\usepackage{xspace}
\usepackage{theorem}
\usepackage{float}
\usepackage{graphicx}
\usepackage{ifthen}
\usepackage{versions}
\usepackage{verbatim}
\usepackage{fancyvrb}
\usepackage{calc}
\usepackage{multicol}
\usepackage{pdflscape}
\usepackage{tabu}
\usepackage{hyperref}
\hypersetup{
    colorlinks=true,       % false: boxed links; true: colored links
    urlcolor=colour,       % color of external links
    linkcolor=colour
}
\usepackage{textcomp}
\usepackage{multicol}
\usepackage{xparse}

\edef\oldtt{\ttdefault}
\usepackage[scaled]{beramono}
\usepackage[T1]{fontenc}
\renewcommand*\ttdefault{\oldtt}

\newenvironment{btHighlight}[1][]
{\begingroup\tikzset{bt@Highlight@par/.style={#1}}\begin{lrbox}{\@tempboxa}}
{\end{lrbox}\bt@HL@box[bt@Highlight@par]{\@tempboxa}\endgroup}

\newcommand\btHL[1][]{%
  \begin{btHighlight}[#1]\bgroup\aftergroup\bt@HL@endenv%
}
\def\bt@HL@endenv{%
  \end{btHighlight}%
  \egroup
}
\newcommand{\bt@HL@box}[2][]{%
  \tikz[#1]{%
    \pgfpathrectangle{\pgfpoint{1pt}{0pt}}{\pgfpoint{\wd #2}{\ht #2}}%
    \pgfusepath{use as bounding box}%
    \node[anchor=base west,outer sep=0pt,inner xsep=1pt, inner ysep=0pt, rounded corners=3pt, minimum height=\ht\strutbox+0pt,#1]{\raisebox{1pt}{\strut}\strut\usebox{#2}};
  }%
}

\usepackage{listings}
\newcommand{\fillinlistings}{
    \lstset{ %
    language=Java, numbers=left, numberstyle=\footnotesize, stepnumber=1,
    numbersep=8pt, showspaces=false, showstringspaces=false, tabsize=4,
    breaklines=true, breakatwhitespace=false,
    basicstyle=\normalsize\fontfamily{fvm}\selectfont, columns=flexible,
    mathescape=true, escapeinside={(*}{*)},
    %morekeywords={},
    keywordstyle=[2]\color{magenta}, keywords=[2]{FlipCoin, RollDie},
    otherkeywords={@requires, @ensures},
    moredelim=**[is][{\btHL[fill=yellow]}]{`}{`},
    }
}
\newcommand{\normallistings}{
    \lstset{ %
    language=Java, numbers=left, numberstyle=\footnotesize, stepnumber=1,
    numbersep=8pt, showspaces=false, showstringspaces=false, tabsize=4,
    breaklines=true, breakatwhitespace=false,
    basicstyle=\footnotesize\fontfamily{fvm}\selectfont, columns=flexible,
    mathescape=true, escapeinside={(*}{*)},
    %morekeywords={},
    keywordstyle=[2]\color{magenta}, keywords=[2]{FlipCoin, RollDie},
    otherkeywords={@requires, @ensures},
    moredelim=**[is][{\btHL[fill=yellow]}]{`}{`},
    }
}
\normallistings
\newcommand{\codefont}{\fontfamily{fvm}\selectfont}

\newcommand{\textcode}[1]{\text{\it\codefont#1}}

\lstdefinestyle{tinycode}{numbers=none,basicstyle=\tiny\fontfamily{fvm}\selectfont}
\lstdefinestyle{smallcode}{numbers=none,basicstyle=\scriptsize\fontfamily{fvm}\selectfont}
\newcommand{\bgcol}{black}
\lstdefinestyle{smallcoden}{numberstyle=\color{\bgcol}\tiny,basicstyle=\scriptsize\fontfamily{fvm}\selectfont}
\lstdefinestyle{largecode}{basicstyle=\Large\fontfamily{fvm}\selectfont}
\lstdefinestyle{nonumbers}{numbers=none}

\renewcommand{\familydefault}{\sfdefault}

%\usepackage[usenames, dvipnamestable]{xcolor}
\definecolor{forestgreen}{RGB}{34,139,34}
\definecolor{darkblue}{RGB}{0,104,139}

\usepackage{LinkedList}
\usepackage{colortbl}
%\usepackage{LinkedList}
\usepackage{tikz}

\usepackage{circuitikz}
\usepackage{tikz}
\usepackage{tikz-qtree}
\usetikzlibrary{fit}
\usetikzlibrary{patterns}
\usetikzlibrary{arrows}
\usetikzlibrary{backgrounds}
\usetikzlibrary{shadows}
\usetikzlibrary{positioning}
\usetikzlibrary{automata}
\usetikzlibrary{graphdrawing}
\usetikzlibrary{graphs}
\usetikzlibrary{snakes}
\usegdlibrary{trees,force,layered,circular}
\usetikzlibrary{circuits.logic.US}

\tikzset{between/.style args={#1 and #2}{
    at = ($(#1)!0.5!(#2)$)
}}
\tikzset{inside/.code=\preto\tikz@auto@anchor{\pgf@x-\pgf@x\pgf@y-\pgf@y}}

\newcommand*\cd[1]{\tikz[baseline=(char.base)]{
            \node[shape=circle,draw,inner sep=2pt] (char) {#1};}}

\usepackage{marginnote}
\usepackage{ragged2e}
\renewcommand*{\raggedleftmarginnote}{\RaggedLeft}
\renewcommand*{\raggedrightmarginnote}{\RaggedRight}
\newcommand{\hasmarginnotes}{
    \setlength{\textwidth}{6.6in}
    \setlength{\marginparsep}{20pt}
    \setlength{\marginparwidth}{0.8in}

}

\setlength{\headheight}{0pt}
\setlength{\headsep}{0pt}

\setlength{\parindent}{0pt}
\setlength{\parskip}{1pt plus 0pt}
\setlength{\abovedisplayskip}{8pt plus 3pt minus 6pt}
\setlength{\intextsep}{15pt plus 3pt minus 6pt}


%
% Default parameter values
%
\newcommand{\TechniquesQuestions}{\begin{center}\color{colour}\LARGE\textbf{\textsf{Techniques Questions}}\end{center}}
\newcommand{\ProofsQuestions}{\begin{center}\color{colour}\LARGE\textbf{\textsf{Proofs Questions}}\end{center}}
\newcommand{\TheDueDate}{Katilsday, February 31}
\newcommand{\TheNumber}{}
\newcommand{\TheDirections}{Write up carefully argued solutions to the
following problems. Your solution should be clear enough that it should
explain to someone who does not already understand the answer why it works. You may use results from lecture, the theorems handout, and previous homeworks without proof.}

\newcommand{\mfcsdate}[1]{\renewcommand{\TheDueDate}{#1}}
\newcommand{\mfcsnumber}[1]{\renewcommand{\TheNumber}{#1}}
\newcommand{\directions}[1]{\renewcommand{\TheDirections}{#1}}
\renewcommand{\labelenumi}{(\alph{enumi})}

\usepackage{todonotes}
\usepackage{mathtools}
\usepackage[shortlabels]{enumitem}
\newlist{judgements}{enumerate}{1}
\setlist[judgements]{itemsep=0.6em, label={\footnotesize\arabic*} (\;\;\;\;), style=standard}

\newcommand{\udensdot}[1]{%
    \tikz[baseline=(todotted.base)]{
        \node[inner sep=0pt,outer sep=3pt] (todotted) {#1};
        \draw[ultra thick, densely dotted] (todotted.south west) -- (todotted.south east);
    }%
}%

\newcommand{\utri}[1]{%
    \tikz[baseline=(todotted.base)]{
        \node[inner sep=0pt,outer sep=3pt] (todotted) {#1};
        \draw[thick, decoration=triangles,segment object length=1pt,segment length=2pt, decorate] (todotted.south west) -- (todotted.south east);
    }%
}%




%
% Make the homework header
%

%%%%%%%%%%%%%%%%%% Toggling of document types %%%%%%%%%%%%%%%%%%%%%%
\newcommand{\ifthen}[2]{\ifthenelse{#1}{#2}{}}

\newcommand{\TheType}{Document}
\newcommand{\TheFlavorA}{}
\newcommand{\TheFlavorB}{}
\newcommand{\TheFlavorC}{}
\newcommand{\TheCourseFlavor}{}
\newboolean{ShowNumbers}
\setboolean{ShowNumbers}{true}
\newboolean{ShowNumbersX}
\setboolean{ShowNumbersX}{false}
\newboolean{ShowPoints}
\setboolean{ShowPoints}{true}
\newboolean{ShowSolutions}
\setboolean{ShowSolutions}{true}
\newboolean{ShowPurpose}
\setboolean{ShowPurpose}{true}
\newboolean{ShowDate}
\setboolean{ShowDate}{true}
\newboolean{YesDate}
\setboolean{YesDate}{true}
\newboolean{ShowDirections}
\setboolean{ShowDirections}{true}
\newboolean{Directions}
\setboolean{Directions}{false}
\newboolean{OnlyWarmup}
\setboolean{OnlyWarmup}{false}
\newboolean{Optional}
\setboolean{Optional}{false}


\newcounter{ThePointValue}
\setcounter{ThePointValue}{-1}
\newcommand{\points}[1]{\setcounter{ThePointValue}{#1}}
\newcommand{\unsetPoints}{\setcounter{ThePointValue}{-1}}

\newcommand{\showNumbers}{\ifthenelse{\boolean{ShowNumbersX}}{}{\setboolean{ShowNumbers}{true}}}
\newcommand{\hideNumbers}{\setboolean{ShowNumbers}{false}}
\newcommand{\NoQuestionNumbers}{\setboolean{ShowNumbersX}{true}}
\newcommand{\showPoints}{\setboolean{ShowPoints}{true}}
\newcommand{\hidePoints}{\setboolean{ShowPoints}{false}}
\newcommand{\showPurpose}{\setboolean{ShowPurpose}{true}}
\newcommand{\hidePurpose}{\setboolean{ShowPurpose}{false}}
\newcommand{\showDate}{\setboolean{ShowDate}{true}}
\newcommand{\hideDate}{\setboolean{ShowDate}{false}}
\newcommand{\NoDate}{\setboolean{YesDate}{false}}
\newcommand{\showDirections}{\setboolean{ShowDirections}{true}}
\newcommand{\hideDirections}{\setboolean{ShowDirections}{false}}
\newcommand{\nodirections}{\setboolean{Directions}{true}}

\newboolean{StandaloneProblem}
\setboolean{StandaloneProblem}{true}

% Default values are just a single problem by itself
\hideNumbers
\hidePoints
\hideDate
\hideDirections
\newcommand{\TheCategory}{}
\renewcommand{\TheType}{\TheCategory Problem}

\newcommand{\category}[1]{\renewcommand{\TheCategory}{#1 }}
\newboolean{CategoryInTitle}
\setboolean{CategoryInTitle}{false}
\newcommand{\categoryInTitle}{\setboolean{CategoryInTitle}{true}}

\newcommand{\VerificationQuestion}[1]{
    \points{20}
    \begin{question}{Verifications}
    For this question, you will be given \textbf{five} of your peers' proofs to review
    using Whiteboard.  The question you will be reviewing is \textbf{#1}.
    These verifications will be released on Friday and due with this homework assignment on Tuesday.
    If you did not submit the previous assignment, you will not receive verifications.  Verification
    scores will factor into your grade on the assignment you are verifying.
    \end{question}
}


\newcounter{TotalPoints}
\newcounter{CurrentQuestionPoints}
\newcommand{\checkPoints}[1]{%
    \AtEndDocument{%
        \ifthenelse{\equal{#1}{\arabic{TotalPoints}}}{}{
            \ifthen{\boolean{ShowPoints}}{
                \ClassError{mfcs}{%
                    The point values in your document sum to
                    \arabic{TotalPoints} of #1}{}%
            }%
        }%
    }%
}

\newcommand{\homework}{%
    \showNumbers
    \showPoints
    \showDate
    \showDirections
    \renewcommand{\TheType}{Homework}
}

\newcommand{\theory}{%
    \showNumbers
    \showPoints
    \showDate
    \showDirections
    \renewcommand{\TheType}{Theory Homework}
}

\newcommand{\written}{%
    \showNumbers
    \showPoints
    \showDate
    \showDirections
    \renewcommand{\TheType}{Written Homework}
}



\newcommand{\programming}{%
%    \problemDocument
    \hideNumbers
    \hidePoints
    \showDate
    \hideDirections
    \renewcommand{\TheType}{\TheTopic}
    \mfcsnumber{\!\!}
}


\newcommand{\studentname}{}

\newcommand{\TheSections}{}
\newcommand{\sections}[1]{\renewcommand{\TheSections}{#1}}

\newboolean{ShowSections}
\setboolean{ShowSections}{true}
\newcommand{\NoSections}{\setboolean{ShowSections}{false}}

\newboolean{ShowIDs}
\setboolean{ShowIDs}{true}
\newcommand{\NoID}{\setboolean{ShowIDs}{false}}

\newboolean{ShowNames}
\setboolean{ShowNames}{true}
\newcommand{\NoNames}{\setboolean{ShowNames}{false}}

\ExplSyntaxOn
\cs_generate_variant:Nn \clist_map_inline:nn {o}
\NewDocumentCommand{\PrintSectionsList}{m}{\clist_map_inline:on{#1}{##1\qquad\qquad}}
\NewDocumentCommand{\TTTRow}{m}{
   \seq_set_from_clist:Nn \l_tmpa_seq{#1}
   \seq_use:Nn \l_tmpa_seq{ & }
}
\newcommand{\cc}[1]{\cellcolor{yellow}#1}
\ExplSyntaxOff

\NewDocumentCommand{\tictactoe}{m m m}{\scalebox{0.7}{\def\arraystretch{1.5}
\hspace*{-0.4em}
\begin{tabular}{c|c|c}
\TTTRow{#1}\\\hline
\TTTRow{#2}\\\hline
\TTTRow{#3}
\end{tabular}
}}%


\newcommand{\fillininfo}[2]{
%% #1= space for answer, #2= autofill
    \let\fillin@Fmt=\fbox%%% box
    \begin{minipage}{#1}
        \fillin@Fmt{\parbox[b][1.5\height][b]{#1}{%
        \strut\hfil\hfill #2\hfill\hfil}}%
    \end{minipage}
}


\newcommand{\makename}{
%\vspace{-2em}
\begin{align*}
&\textbf{Name:}&&\fillininfo{0.94\textwidth}{}\\
\ifthen{\boolean{ShowIDs}}{&\textbf{ID \#:}&&\fillininfo{0.94\textwidth}{}\\}
\ifthen{\boolean{ShowSections}}{&\textbf{Section:}&&\vbox{\parbox[b][2.1\height][b]{0.94\textwidth}{\text{\;\;%
\PrintSectionsList{\TheSections}}}}}
\end{align*}
\vspace{-2em}
}
\newcommand{\MakeName}{\makename}

\newcommand{\quiz}{
%    \problemDocument
    \showNumbers
    \showPoints
    \showDate
    \hideDirections
    \renewcommand{\TheType}{Quiz}
    \renewcommand{\studentname}{\makename}
}

\newcommand{\TheTopic}{}
\NewDocumentCommand{\topic}{m G{}}{%
    \renewcommand{\TheTopic}{#1}%
    \renewcommand{\TheFlavorC}{#2}%
}


\NewDocumentCommand{\matchColon}{gg}{%
    #1\IfStrEq{#2}{\empty}{}{: #2}%
}
\NewDocumentCommand{\matchSpace}{gg}{%
    \IfStrEq{#2}{\empty}{}{#2 }#1%
}

\newcommand{\quickcheck}{
%    \problemDocument
    \showNumbers
    \hidePoints
    \hideDirections
    \renewcommand{\TheType}{\matchColon{QuickCheck}{\TheTopic}}
    \mfcsnumber{\!\!}
    \ifthen{\boolean{ShowNames}}{\renewcommand{\studentname}{\makename}}
}

\newcommand{\blastfromthepast}{
%    \problemDocument
    \showNumbers
    \hidePoints
    \showDate
    \hideDirections
    \renewcommand{\TheType}{\matchColon{BlastFromThePast}{\TheTopic}}
    \mfcsnumber{\!\!}
    \ifthen{\boolean{ShowNames}}{\renewcommand{\studentname}{\makename}}
}


\newcommand{\sectionX}{
%    \problemDocument
    \showNumbers
    \hidePoints
    \hideDate
    \hideDirections
    \let\TheNumberX\TheNumber
    \renewcommand{\TheNumber}{}
    \renewcommand{\TheType}{\matchColon{Section \TheNumberX}{\TheTopic}}
    \mfcsnumber{\!\!}
}


\newcommand{\recitation}{
%    \problemDocument
    \hideNumbers
    \hidePoints
    \hideDate
    \hideDirections
    \renewcommand{\TheType}{\matchColon{Recitation}{\TheTopic}}
    \mfcsnumber{\!\!}
}


\newcommand{\workshop}{\recitation\showDate\renewcommand{\TheType}{\matchSpace{Workshop}{\TheTopic}}\mfcsnumber{\!\!}}
\newcommand{\competition}{\recitation\showDate\renewcommand{\TheType}{\matchSpace{Competition}{\TheTopic}}\mfcsnumber{\!\!}}
\newcommand{\proofwriting}{\recitation\showDate\renewcommand{\TheType}{\TheTopic}\mfcsnumber{\!\!}}

\newcommand{\ep}{
%    \problemDocument
    \showNumbers
    \hidePoints
    \hideDirections
    \hideDate
    \mfcsnumber{\!\!}
    \renewcommand{\TheType}{\TheTopic}
}

\newcommand{\optional}{
    \setboolean{Optional}{true}
    \renewcommand{\TheDirections}{%
        \color{colour}This is \textbf{OPTIONAL}.  It will not be graded, and it's not worth any points.  If you would like to check your answer, we are happy
        to discuss it in office hours.
    }
    \renewcommand{\points}[1]{0}
}

\newcommand{\TheEPGuru}{}
\newcommand{\epguru}[1]{\renewcommand{\TheEPGuru}{#1}}
\newcommand{\TheFinalQuestion}{
    \begin{question}[70]{Generalization}
    A group of two in your recitation spent the past week investigating this topic.  For the last 20 minutes of
    today's recitation, they will present their results to you.
    \end{question}
}

\newcommand{\presenter}{
    \showNumbers
    \showPoints
    \showDirections
    \showDate
    \renewcommand{\TheDirections}{%
    You have a week to prepare typeset solutions to this exploratory problem as well as a generalization of it.  You will be expected to
    present your generalization in recitation on the due date.  Please send a pdf with your solutions (both to the problems here and
    your generalization(s)) by \emph{midnight} the night before your presentation.
    }
    \renewcommand{\TheFinalQuestion}{%
        \begin{question}[70]{Generalization}
        Once you've solved all the other problems, choose at least one generalization of the topic you've just explored.
        Construct and prove at least one theorem about your generalization.  \textbf{50} of the points for this problem are for
        constructing a suitable generalization; the other \textbf{20} points are for presenting this generalization to your
        recitation in the last 20 minutes of class.

        If you need help either coming up with a generalization or proving things about it, please contact this week's EP Guru,
        \textbf{\TheEPGuru}, or one of the instructors.  \textbf{\TheEPGuru} and the instructors will be available at various
        times during the week to help with this project.  Do yourself a favor and ask \textbf{\TheEPGuru} if your generalization
        is suitable at least a day before presenting.
        \end{question}

    }
}

\newcommand{\misc}{
%    \problemDocument
    \hideNumbers
    \hidePoints
    \hideDate
    \hideDirections
    \renewcommand{\TheNumber}{}
    \renewcommand{\TheType}{\TheTopic}
    \solutions
    \renewcommand{\TheFlavorB}{}
}

\newcommand{\inkpage}{}
\newcommand{\inkonly}[1]{}

\newcommand{\ink}{
    \misc
    \renewcommand{\inkpage}{\newpage}
    \renewcommand{\inkonly}[1]{##1}
}

\newcommand{\warmup}{
%    \problemDocument
    \hideDate
    \setboolean{OnlyWarmup}{true}
    \renewcommand{\TheFlavorA}{ Warmup}
    \let\question\comment %Everything from the question environment should
                          %be suppressed, because they are all normal
                          %questions
}

\newcommand{\fill@ans@color}[1]{\phantom{#1}}

\newcommand{\solutionnewpage}{}
\newcommand{\questionnewpage}{\newpage}

\newcommand{\solid}[1]{\textbf{Solution:} #1}
\newcommand{\voidf}[1]{}
\newcommand{\solutions}{
    \hideDirections
    \hideDate
    \setboolean{ShowSolutions}{true}
    \let\solution\solutionsave
    \let\sol\solid
    \let\suggest\suggestsave
    \let\endsuggest\endsuggestsave
    \let\fillinx\fillinxsave
    \let\endfillinx\endfillinxsave
    \let\fillincircle\fillincirclesave
    \let\endfillincircle\endfillincirclesave
    \expandafter\let\csname question-only\endcsname\comment
    \let\cheatsheet\comment
    \let\endcheatsheet\endcomment
    \expandafter\let\csname prog-restrict\endcsname\comment
    \expandafter\let\csname endprog-restrict\endcsname\endcomment
    \renewcommand{\answerfill}[1]{}
    \renewcommand{\solutionnewpage}{\newpage}
    \renewcommand{\questionnewpage}{}
    \renewcommand{\answerspace}[1]{}
    \renewcommand{\solutionspace}[1]{\vspace{##1}}
    \renewcommand{\makename}{}
    \renewcommand{\TheFlavorB}{ Solutions}
    \renewcommand{\PROBLEMS}{\begin{center}{\bf\color{colour}\LARGE Problem Solutions}\end{center}}
    \renewcommand{\REVIEWPROBLEMS}{\begin{center}{\bf\color{colour}\LARGE Review Problem Solutions}\end{center}}
    \renewcommand{\fill@ans@color}[1]{
\vspace{-1.8em}

\textbf{##1}
\vspace{0.5em}}
}

\newcommand{\Written}[1]{#1 [Written]}
\newcommand{\Online}[1]{#1 [Online]}
\newcommand{\SubmitLink}[1]{%
\begin{center}
    \fbox{\begin{minipage}{0.7\textwidth}
    \begin{center}
    You can submit and check your answers to this question using \url{#1}.
    \end{center}
    \end{minipage}}
\end{center}}


\newenvironment{question-only}{}{}

\newenvironment{solution}[1][Solution: ]{
    \subquestion*{#1}%
}

\def\hlinewd#1{%
\noalign{\ifnum0=`}\fi\hrule \@height #1 %
\futurelet\reserved@a\@xhline}

\newenvironment{truth-table}[3][c]{
\begin{center}
    \tabulinesep=1.5mm\begin{tabu}{*{#2}{|>{\sf}#1}|}\hline
            #3\\\hlinewd{1.2pt}
}{
\end{tabu}
\end{center}}

\newenvironment{suggest}[1][Practice-It Suggestions: ]{
    \vspace{1em}

    \subquestion*{#1}
    \vspace{0.3em}

    \begin{itemize}\setlength\itemsep{-0.1em}\setlength{\itemindent}{-1.5em}
}{\end{itemize}}

\newenvironment{cheatsheet}{\CHEATSHEET}{}

\newcommand*\fillinx[1]{\xout{#1}}
\newcommand*\fillincircle[1]{\tikz[baseline=(char.base)]{
            \node[shape=rounded rectangle,draw,inner sep=2pt] (char) {#1};}}


\let\solutionsave\solution
\let\suggestsave\suggest
\let\endsuggestsave\endsuggest
\let\fillinxsave\fillinx
\let\endfillinxsave\endfillinx
\let\fillincirclesave\fillincircle
\let\endfillincirclesave\endfillincircle

%\newcommand{\solution}[1]{%
%    \ifthen{\boolean{ShowSolutions}}{%
%        $ $\\\\
%        \textbf{Solution:} #1
%        %\vspace{-1.25ex}%
%        %\begin{indented}%
%        %\fbox{\begin{minipage}[c]{\linewidth}#1\end{minipage}}%
%        %\end{indented}%
%    }%
%}

\newcommand{\purpose}[1]{%
    \ifthen{\boolean{ShowPurpose}}{%
        \emph{Purpose:} #1
        $ $\\\\
    }%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcounter{TheQuestionNumber}
\newcounter{ThePartNumber}[TheQuestionNumber]

\NewDocumentEnvironment{question-base}{ o m }{%
    %\vspace{-3ex}%
    \textbf{%
        \textsf{%
            \vspace{-4ex}\section*{%
                \ifthen{\boolean{ShowNumbers}}%
                       {\arabic{TheQuestionNumber}. }#2%
                \ifthen{\boolean{ShowPoints}}{ (%
                    {#1 point\ifthenelse{\equal{#1}{1}}{}{s})}%
                }%
                \ifthen{\boolean{CategoryInTitle}}{ (\TheCategory\!\!)}}%
                \addtocounter{TheQuestionNumber}{1}%
                \setcounter{ThePartNumber}{0}%
        }%
    }%
}%


\newenvironment{warmup-question}{%
    \begin{question-base}{Warmup}{0}%
}{%
    \end{question-base}%
}

\NewDocumentEnvironment{question}{ o g }{%
    \ifthen{\boolean{Optional}}{\setcounter{ThePointValue}{0}}%
    \ifthen{\boolean{StandaloneProblem}}{\begin{document}}%
    \setcounter{CurrentQuestionPoints}{0}%
    \ifthenelse{\equal{-1}{\arabic{ThePointValue}}}{%
        \IfNoValueTF{#1}{%
             \ifthenelse{\boolean{ShowPoints}}{
                \ClassError{mfcs}{%
                    Question \arabic{TheQuestionNumber} does not have a point value.\MessageBreak
                    Give an optional argument: \protect\begin{question}[POINTS]{NAME}\MessageBreak
                    Or use the \protect\points\space command: \protect\points{POINTS}}{}
            }{%
            \begin{question-base}{\IfNoValueTF{#2}{\!\!\!}{#2}}%
            }%
        }{%
            \setcounter{ThePointValue}{#1}%
            \begin{question-base}[#1]{\IfNoValueTF{#2}{\!\!\!}{#2}}%
        }%
    }{%
     \begin{question-base}[\arabic{ThePointValue}]{#2}%
    }%
}{%
    \end{question-base}%
    \ifthen{\boolean{ShowPoints}}{%
        \ifthenelse{\equal{\arabic{ThePartNumber}}{0}}{}{%
        \ifthenelse{\equal{\arabic{ThePointValue}}{\arabic{CurrentQuestionPoints}}}{}{%
            \ClassError{mfcs}{%
                 Question \arabic{TheQuestionNumber} has conflicting points values.\MessageBreak
                 The total given is \arabic{ThePointValue}.\MessageBreak
                 The total calculated is \arabic{CurrentQuestionPoints}}{}%
        }}%
        \ifthen{\boolean{ShowPoints}}{%
            \addtocounter{TotalPoints}{\arabic{ThePointValue}}%
        }%
    }%
    \unsetPoints%
    \ifthen{\boolean{StandaloneProblem}}{\stop}%
    \vspace{4ex}
}

%\def\indented#1{\list{}{}\item[]}
%\let\indented=\endlist

\newcounter{ThePartValue}

\RenewDocumentEnvironment{part}{ g }{%
    \addtocounter{ThePartNumber}{1}%
    \ifthen{\boolean{Optional}}{\setcounter{ThePartValue}{0}}%
    \IfValueT{#1}{\setcounter{ThePartValue}{#1}}%
    \ifthen{\boolean{ShowPoints}}{%
        \IfNoValueT{#1}{%
            \ClassError{mfcs}{%
                 Part \arabic{ThePartNumber} does not have a point value.\MessageBreak
                 Give an optional argument: \protect\begin{part}{POINTS}\MessageBreak
                 Or switch to a document with no point values.\MessageBreak
                 The question total so far is \arabic{CurrentQuestionPoints}
                 out of \arabic{ThePointValue}}{}%
        }%
    }%
    \ifthen{\boolean{ShowPoints}}{
        \IfNoValueF{#1}{%
            \addtocounter{CurrentQuestionPoints}{\arabic{ThePartValue}}%
        }%
    }%
    %\begin{indented}%
    \begin{enumerate}[(\alph{ThePartNumber})]%
        \item\ifthen{\boolean{ShowPoints}}{[{\arabic{ThePartValue}} Point\ifthenelse{\equal{#1}{1}}{}{s}]}%
}{\end{enumerate}%
%\end{indented}
}

\newcommand{\id}[1]{#1}

%\newcommand{\problemDocument}{
    \renewcommand{\TheNumber}{$-\infty$}
    \setboolean{StandaloneProblem}{false}
    \setboolean{ShowSolutions}{false}
    \let\suggest\comment
    \let\endsuggest\endcomment
    \let\solution\comment
    \let\fillinx\id
    \let\endfillinx\endid
    \let\fillincircle\id
    \let\endfillincircle\endid

    \let\sol\voidf
    \setboolean{ShowPurpose}{false}
%}

    \hideNumbers
    \hidePoints
    \hideDate
    \hideDirections
    \renewcommand{\TheNumber}{}
    \renewcommand{\TheType}{\TheTopic}
    \renewcommand{\TheFlavorB}{}

\newcommand{\TheCourseNumber}{CSE XXX}
\newcommand{\TheCourseName}{Computer Science for Computer Scientists}
\NewDocumentCommand{\course}{m G{} G{} D(){}}{%
    \renewcommand{\TheCourseFlavor}{#3#4}\renewcommand{\TheCourseNumber}{#1}\renewcommand{\TheCourseName}{#2}%
}

\definecolor{colour}{rgb}{0,0,0}%
\newcommand{\MakeHeader}[3]{%
\ifthenelse{\boolean{Optional}}{\definecolor{colour}{rgb}{1,0,0}}{%
    \ifthenelse{\equal{\TheCourseNumber}{CSE 431}}{\definecolor{colour}{rgb}{0.141176471, 0.482352941, 0.62745098}}{%
\ifthenelse{\equal{\TheCourseNumber}{CSE 143H}}{\definecolor{colour}{rgb}{0,0.35,1}}{%
\ifthenelse{\equal{\TheCourseNumber}{CSE 301}}{\definecolor{colour}{rgb}{0,0.35,1}}{%
\ifthenelse{\equal{\TheCourseNumber}{CSE 143X}}{\definecolor{colour}{rgb}{0.53,0.0,0.65}}{%
\ifthenelse{\equal{\TheCourseNumber}{CSE 311}}{\definecolor{colour}{rgb}{0,0.45,0}}{%
\ifthenelse{\equal{\TheCourseNumber}{CSE 332}}{\definecolor{colour}{rgb}{0,0,0.585}}{%
    \definecolor{colour}{rgb}{0,0.45,0}%
}}}}}}}%

\ifthenelse{\equal{\TheCourseNumber}{CSE 431}} {\renewcommand{\TheCourseName}{Theory of Computation}}{%
\ifthenelse{\equal{\TheCourseNumber}{CSE 143X}}{\renewcommand{\TheCourseName}{Accelerated Computer Programming I/II}}{%
\ifthenelse{\equal{\TheCourseNumber}{CSE 143H}}{\renewcommand{\TheCourseName}{CSE 143 Honors Seminar}}{%
\ifthenelse{\equal{\TheCourseNumber}{CSE 301}}{\renewcommand{\TheCourseName}{Interview Prep
}}{%
\ifthenelse{\equal{\TheCourseNumber}{CSE 311}} {\renewcommand{\TheCourseName}{Foundations of Computing I}}{%
\ifthenelse{\equal{\TheCourseNumber}{CSE 332}} {\renewcommand{\TheCourseName}{Data Abstractions}}{%
}}}}}}

{\color{colour} {\noindent \Large%
\textbf{\textsf{\TheCourseNumber: \TheCourseName\hfill\TheCourseFlavor}}%
} \vspace{-1ex} \\ \rule[1mm]{\textwidth}{.3mm} \\%
{\Large \noindent \textbf{\textsf{\TheType\ifdefempty{#1}{}{\;}#1\TheFlavorA\TheFlavorB%
    \ifthen{\boolean{ShowDate}}{\ifthen{\boolean{YesDate}}{ (due #2)}}\hfill\TheFlavorC}}}%
}\ifthen{\boolean{ShowDirections}}{\ifthenelse{\boolean{Directions}}{\\\\}{\\\\%
\textsf{{\bf Directions}: {\sl#3}\\}}}%
\studentname%
\vspace{6ex}
}

\renewcommand{\section}{\@startsection{section}{1}{0mm}%
                                  {0ex}%
                                  {0.1ex plus .2ex}%
                                  {\normalfont\Large\bfseries\color{colour}}}%
\renewcommand{\subsection}{\@startsection{subsection}{1}{0mm}%
                                  {2ex}%
                                  {0.1ex plus .2ex}%
                                  {\normalfont\large\bfseries\color{colour}}}%
\renewcommand{\subsubsection}{\@startsection{subsubsection}{1}{0mm}%
                                  {2ex}%
                                  {0.1ex plus .2ex}%
                                  {\normalfont\normalsize\bfseries\color{colour}}}%

\renewcommand{\thesubsection}{(\arabic{subsection})\hspace{-0.5em}}
\newcommand{\subquestion}{\subsection}
\newcommand{\subsubquestion}{\subsubsection}


\newcommand{\NoHeader}{
    \renewcommand{\MakeHeader}[3]{}
}

\AtBeginDocument{\MakeHeader{\TheNumber}{\TheDueDate}{\TheDirections}}

\DeclareDocumentCommand{\Pr}{ m g }{\ensuremath{\textsf{Pr}\left[#1\IfNoValueF{#2}{\;|\;#2}\right]}}
\DeclareDocumentCommand{\E}{ m g }{\ensuremath{\mathbb{E}}\left[#1\IfNoValueF{#2}{\;|\;#2}\right]}
\DeclareDocumentCommand{\Var}{ m g }{\textsf{Var}\left[#1\IfNoValueF{#2}{\;|\;#2}\right]}

\newcommand{\RAM}{\textbf{Repeat After Me:}\normalfont\;}
\newcommand{\BT}{\textbf{Basic Technique:}\normalfont\;}
\newcommand{\MT}{\textbf{Moment's Thought:}\normalfont\;}

\newcommand{\fillin}[3][u]{
%% #1= the box (u=underlined, e=empty, b=boxed) #2= space for theanswer, #3= the correct answer
\space%
    \ifx#1u\let\fillin@Fmt=\underbar%%% by default underlined space
    \else\ifx#1b\let\fillin@Fmt=\fbox%%% box
    \else\ifx#1e\let\fillin@Fmt=\vbox%%% box
    \fi\fi\fi%
    \begin{minipage}{#2}
        \ifx#1u\vspace{0.9em}
        \fi
        \fillin@Fmt{\ifx#1e\hspace*{-0.2em}\fi\parbox[b][2\height][b]{#2}{%
        \strut\hfil\fill@ans@color{\hfill #3\hfill}\hfil}}%
        \ifx#1u
        \vspace{0.5em}$ $\fi
    \end{minipage}
}
\newcommand{\answerspace}{\vspace}
\newcommand{\solutionspace}[1]{}
\newcommand{\answerfill}{\vfill}

\newcommand{\nopagenumbers}{
    \thispagestyle{empty}
    \pagestyle{empty}
}

\newcommand{\NoPageNumbers}{\nopagenumbers}

% For Syllabus:
\newcommand{\AllDaysClass}{%
    \calday[Monday]{\classday}
    \calday[Tuesday]{\classday}
    \calday[Wednesday]{\classday}
    \calday[Thursday]{\classday}
    \calday[Friday]{\classday}
    \skipday\skipday % weekend (no class)
}

\usepackage{environ}
\NewEnviron{automaton}{%
  \begin{tikzpicture}[->,>=stealth',shorten >=1pt,auto,node distance=3cm,thick,initial text={},double=]
  \BODY
  \end{tikzpicture}
}

\usepackage{tcolorbox}
\newtcolorbox{mdef}[1]{colback=white,lefttitle=0.2em,leftlower=0.2em,leftupper=0.2em,
colbacktitle=gray!20,colframe=black,fonttitle=\codefont\normalsize\color{black},
top=0em,bottom=0em,title=#1}


\NewDocumentEnvironment{method}{ m m G{} }{\vspace{0.5em}
\begin{mdef}{#1 \textbf{#2}({#3})}}{\end{mdef}\vspace{0.5em}
}


\tcbuselibrary{fitting}
\tcbuselibrary{skins}
\newtcolorbox{lstbox}[1]{enhanced,colback=white,lefttitle=0.2em,leftlower=0.2em,leftupper=0.2em,
colbacktitle=gray!75!white,colframe=black,fonttitle=\scriptsize\bf\color{black},
top=-0.9em,bottom=-0.9em,left=-0.0em,title=#1,middle=0em,segmentation style={solid,inner ysep=0}}

\newtcolorbox{cproblem-internal}[1]{enhanced,colback=white,lefttitle=0.2em,leftlower=0.2em,leftupper=0.2em,
colbacktitle=gray!75!white,colframe=black,fonttitle=\scriptsize\bf\color{black},
top=-0.0em,bottom=-0.0em,left=-0.0em,title=#1,middle=0em,segmentation style={solid,inner ysep=0}}

\ProvideDocumentEnvironment{cproblem}{m O{1.0}} {
    \begin{center}
    \begin{minipage}{#2\textwidth}
    \begin{center}
    \begin{cproblem-internal}{\textbf{#1}}
    \hspace*{-0.5em}\begin{tabular}{ll}
}{
    \end{tabular}
    \end{cproblem-internal}
    \end{center}
    \end{minipage}
    \end{center}
}

\newcommand{\cinput}[1]{\textbf{Input(s)}:  & #1\\}
\newcommand{\coutput}[1]{\textbf{Output}:  & #1}

\newtcolorbox{identity-internal}[1]{enhanced,colback=white,lefttitle=0.2em,leftlower=0.2em,leftupper=0.2em,
colbacktitle=gray!15!white,colframe=black,fonttitle=\large\bf\color{black},
top=-0.0em,bottom=-0.0em,left=-0.0em,title=#1,middle=0em,segmentation style={solid,inner ysep=0}}


\ProvideDocumentEnvironment{identity}{m O{1.0}} {
    \begin{minipage}{#2\textwidth}
    \begin{center}
    \begin{identity-internal}{\textbf{\vphantom{AssociativityAbsorption}#1}}
    $$\hspace*{0.6em}\begin{aligned}
}{
    \end{aligned}$$
    \end{identity-internal}
    \end{center}
    \end{minipage}
}

\newtcboxfit{infer-internal}{}%colback=white,lefttitle=0.2em,leftlower=0.2em,leftupper=0.2em,
%colbacktitle=gray!15!white,colframe=black,fonttitle=\large\bf\color{black}}


\newcommand*{\minwidthbox}[2]{%
  \makebox[{\ifdim#1<\width\width\else#1\fi}]{#2}%
}

\newcommand{\inftherefore}{\mbox{\raisebox{0.1em}{\scalebox{0.9}{\therefore}}}\hspace*{0.5em}}

\newcommand{\infer}[4][1em]{\mbox{\ensuremath{%
\displaystyle {\frac{\phantom{\inftherefore}\minwidthbox{#1}{\ensuremath{\;#3\;}}\hphantom{\inftherefore}}{\inftherefore\minwidthbox{#1}{\ensuremath{#4}}\hphantom{\inftherefore}}}\;\;\textrm{\small #2}%
}}}

% FITTED BOX: \tcbox[title={\textrm{#2}}, center title, colback=white,leftlower=0.2em,leftupper=0.2em,colbacktitle=gray!15!white,colframe=black,fonttitle=\large\bf\color{black}]{%
\newcommand{\inferencerule}[4][6.5em]{\mbox{%
\begin{tcolorbox}[title={\textrm{#2}}, center title, colback=white,colbacktitle=gray!15!white,colframe=black,fonttitle=\large\bf\color{black}]%
\centering\infer[#1]{}{#3}{#4}\hspace*{-1.3em}%
\end{tcolorbox}
}}


%\tcbox[title={$a\;|\;b$ (``$a$ \textit{divides} $b$'')}, colback=white,lefttitle=0.2em,leftlower=0.2em,leftupper=0.2em,colbacktitle=gray!15!white,colframe=black,fonttitle=\large\bf\color{black}]{%

\newtcolorbox{definition-internal}[1]{enhanced,colback=white,righttitle=0.2em,lefttitle=0.2em,leftlower=0.2em,leftupper=0.2em,
colbacktitle=gray!15!white,colframe=black,fonttitle=\large\color{black},
top=-0.0em,bottom=-0.0em,left=-0.0em,title=#1,middle=0em,segmentation style={solid,inner ysep=0}}

\ProvideDocumentEnvironment{definition}{m O{1.0} D(){}} {
    \begin{minipage}{#2\textwidth}
    \begin{center}
    \begin{definition-internal}{#1 \hfill \textsc{\small #3}}
}{
    \end{definition-internal}
    \end{center}
    \end{minipage}
}


\NewDocumentCommand{\classdiagram}{O{}m}{%
\mbox{\begin{tikzpicture}[thick,draw=black]
\graph [tree layout,nodes={draw,rectangle,thick,}]{#2};#1
\end{tikzpicture}}}


\NewDocumentCommand{\binarytree}{O{font=\normalsize}O{5.0} m o o D(){}}{%
\mbox{\begin{tikzpicture}[thick,draw=\nodecol,node distance=0.6em and 1.5em, #1]
\makellhls{#5}%                      0-1=green,1-2,2-null=red,front,next=blue
\graph [binary tree layout, sibling distance=#2 em+0.5em, level distance=#2em, nodes={draw,circle,semithick,minimum height=2em, inner sep=0.2em}]{#3};
\IfNoValueF{#4}{\makellrefs{#4}}%    1=front,2=blah (this is the argument that makes pointers to nodes)
#6
\end{tikzpicture}
}}

\NewDocumentCommand{\triepicture}{m}{
\mbox{\begin{tikzpicture}[thick,draw=\nodecol,node distance=0.6em and 1.5em, font=\tiny]
\graph [tree layout, fresh nodes, edge quotes={fill=white, inner sep=1.5pt}, grow down, sibling distance=2em+0.5em, level distance=2.8em, edges={font=\small\tt}, nodes={draw,circle,semithick,minimum height=0.5em, inner sep=0.2em}]{root/"" -> {#1}};
\end{tikzpicture}}}


\newenvironment{code-demo}[2]{\vspace{0.3em}
\examheader{Example Output}
\renewcommand{\arraystretch}{1.2}
\begin{center}\begin{tabular}{@{}|>{\tt}l|>{\tt}c|}\hline
\multicolumn{1}{|c|}{\normalfont\bf #1} & {\normalfont\bf #2}\\\hline\hline}{
\end{tabular}\end{center}}
\newcommand{\codeex}[2]{#1 & #2\\\hline}

\newcommand{\codeanswerline}{\hline}
\newenvironment{code-answer}[1][|]{\vspace{0.3em}
\renewcommand{\arraystretch}{1.6}%
\begin{center}\begin{tabular}{@{}#1>{\tt}c|c|}\codeanswerline}{\end{tabular}\end{center}}

\newcommand{\codeq}[3][1em]{#2 & \fillin[e]{#1}{#3}\\\codeanswerline}

\newcommand{\examheader}[1]{\subsubquestion*{\underline{#1}}}

\begingroup
  \catcode `P=12  % digits and punct. catcode
  \catcode `T=12  % digits and punct. catcode
  \lowercase{%
  \def\x{\def\rem@pt##1.##2PT{##1\ifnum##2>\z@.##2\fi}}}
     \expandafter\endgroup\x%
\def\strippt{\expandafter\rem@pt\the}


\newlength{\rightsidex}
\newenvironment{class-reference}[1][0.3]{\vspace{0.3em}
\setlength{\rightsidex}{1pt - #1pt}

\renewcommand*{\arraystretch}{1.2}\begin{tabular}{@{}|>{\tt}p{#1\textwidth}|p{\strippt\rightsidex\textwidth}|}\hline}{\end{tabular}}
\newcommand{\svar}[1]{{\rmfamily\bf #1{}}}
\newcommand{\val}{\svar{value}}
\newcommand{\idx}{\svar{index}}
\newcommand{\lst}{\svar{list}}
\newcommand{\set}{\svar{set}}
\newcommand{\coll}{\svar{collection}}
\newcommand{\key}{\svar{key}}
\newcommand{\map}{\svar{map}}
\newcommand{\str}{\svar{str}}

\newcommand{\CHEATSHEET}{\begin{center}{\vspace{-2em}
\bf\color{colour}\LARGE Cheat Sheet}\end{center}}

\newcommand{\PROBLEMS}{\begin{center}{\bf\color{colour}\LARGE Problems}\end{center}}
\newcommand{\REVIEWPROBLEMS}{\begin{center}{\bf\color{colour}\LARGE Review Problems}\end{center}}


\renewcommand{\FancyVerbFormatLine}[1]{\makebox[1.5em][l]{\texttt{>}\texttt{>}}#1}
\DefineVerbatimEnvironment{console}{BVerbatim}{fontsize=\small, framesep=0em, commandchars=\\\{\}}

\newcommand{\instructionsheader}[1]{%
\vspace{-2.5em}
\begin{center}%
\bf\color{colour} #1%
\end{center}%
}
\newcommand{\practiceit}[2]{\item \href{http://practiceit.cs.washington.edu/problem.jsp?#2}{Practice-It Link: \texttt{#1}}}
\newcommand{\prompt}[1]{\texttt{>}\texttt{>} {\small #1}}

\newcounter{numcells}
\newcounter{numidx}
\newcounter{nummax}
\newcounter{numprt}
\newcounter{numcellsp1}

\setcounter{nummax}{-1}

\newcommand{\indx}[1]{\multicolumn{1}{c}{\tiny{#1}}}
\newcommand{\ai}[2]{\multicolumn{1}{c}{\tiny{\texttt{#1[}#2\texttt{]}}}}

\newcommand{\indxs}[3]{%
    #1{\ifnumequal{\arabic{nummax}}{-1}{\setcounter{nummax}{#2}}{}%
        \setcounter{numprt}{\arabic{nummax}-#2+#3}\arabic{numprt}\setcounter{numidx}{#2-1}}%
    \ifnumequal{\arabic{numidx}}{0}{\setcounter{nummax}{-1}}{&\indxs{#1}{\arabic{numidx}}{#3}}%
}

\ExplSyntaxOn
\cs_generate_variant:Nn \clist_map_inline:nn {o}
\clist_new:N\l_arr
\NewDocumentCommand{\ArrToTabular}{m}{\clist_map_inline:on{#1}{&##1}}
\NewDocumentCommand{\TestArrToTabular}{m}{\clist_map_inline:on{#1}{|##1}}

\newcounter{vertcount}
\setcounter{vertcount}{0}
\NewDocumentCommand{\ArrToVerticalTabular}{m}{\clist_map_inline:on{#1}{\\\cline{2-2}&##1&}}
%\indx{\hspace{-1.2em}\arabic{vertcount}}\setcounter{vertcount}{\arabic{vertcount} + 1}
\NewDocumentCommand{\ArrLength}{m}{\clist_count:n{#1}}
\NewDocumentCommand{\ListToLL}{m}{\clist_map_inline:on{#1}{\fbox{##1}$\vcenter{\hbox{$\longrightarrow$}}$}}
\ExplSyntaxOff

\pgfdeclareshape{subtree triangle}{
  % Copy some stuff from the isosecles triangle
  \inheritsavedanchors[from={isosceles triangle}]
  \inheritanchor[from={isosceles triangle}]{center}
  \inheritanchor[from={isosceles triangle}]{north}
  \inheritanchor[from={isosceles triangle}]{south}
  \inheritanchor[from={isosceles triangle}]{east}
  \inheritanchor[from={isosceles triangle}]{west}
  \inheritanchorborder[from={isosceles triangle}]

  \inheritbehindbackgroundpath[from=isosceles triangle]
  \inheritbackgroundpath[from=isosceles triangle]

  \anchor{apex}{\centerpoint}
}

\newcommand{\tikzmark}[1]{\tikz[overlay,remember picture] \node (#1) {};}

\tikzset{
    alphabeta/.style={rectangle,text=white,fill=black,inner sep=0.4em, rounded corners},
    subtree/.style={
        subtree triangle,
        minimum height=3.5em,
        isosceles triangle apex angle=45,
        draw,
        shape border rotate=90,
        minimum height=3.5em,
        anchor=apex,
    },
    database/.style={
        cylinder,
        shape border rotate=90,
        aspect=0.25,
        draw
    },
    database split/.style={
        cylinder,
        shape border rotate=90,
        aspect=0.25,
        draw
    },
    btreenode2/.style={rectangle split, rectangle split horizontal, rectangle split parts=5, rectangle split every empty part={}},
    btreenode3/.style={rectangle split, rectangle split horizontal, rectangle split parts=7, rectangle split every empty part={}},
    btreenode4/.style={rectangle split, rectangle split horizontal, rectangle split parts=9, rectangle split every empty part={}},
    btreenode5/.style={rectangle split, rectangle split horizontal, rectangle split parts=11, rectangle split every empty part={}},
    btreenode6/.style={rectangle split, rectangle split horizontal, rectangle split parts=13, rectangle split every empty part={}},
    btreenode7/.style={rectangle split, rectangle split horizontal, rectangle split parts=15, rectangle split every empty part={}},
    btreenode8/.style={rectangle split, rectangle split horizontal, rectangle split parts=17, rectangle split every empty part={}},
    btreeleaf2/.style={rectangle split, rectangle split horizontal=false, rectangle split parts=2, rectangle split empty part height=1.5ex},
    btreeleaf3/.style={rectangle split, rectangle split horizontal=false, rectangle split parts=3, rectangle split empty part height=1.5ex},
    btreeleaf4/.style={rectangle split, rectangle split horizontal=false, rectangle split parts=4, rectangle split empty part height=1.5ex},
    btreeleaf5/.style={rectangle split, rectangle split horizontal=false, rectangle split parts=5, rectangle split empty part height=1.5ex},
    btreeleaf6/.style={rectangle split, rectangle split horizontal=false, rectangle split parts=6, rectangle split empty part height=1.5ex},
    btreeleaf7/.style={rectangle split, rectangle split horizontal=false, rectangle split parts=7, rectangle split empty part height=1.5ex},
    btreeleaf8/.style={rectangle split, rectangle split horizontal=false, rectangle split parts=8, rectangle split empty part height=1.5ex},
}

\newdimen\XCoord
\newdimen\YCoord

\newcommand*{\ExtractCoordinate}[1]{\path (#1); \pgfgetlastxy{\XCoord}{\YCoord};}%
\newcommand*{\LabelCurrentCoordinate}[3][2pt]{\fill [#2] ($(\XCoord,\YCoord)$) circle (#1) node [right] {#3}}%


\usepackage{hhline}
\usepackage{luatexbase}
\usepackage{bm}
\usepackage{luacode}
\RequireLuaModule{lualibs}
\newcommand{\internalsize}{XX}

 \NewDocumentCommand{\btree}{O{font=\small}O{8.0} O{8.0} D(){4} D(){3} m m}{%
 \mbox{\begin{tikzpicture}[thick,draw=\nodecol,node distance=0.6em and 1.5em, #1]
 \renewcommand{\internalsize}{#4}
 \tikzset{leaf/.style={btreeleaf#5}}
 \tikzset{internal/.style={btreenode#4}}
 \graph [tree layout, sibling distance=#2 em+0.5em, level distance=#3em, edges={draw=none}, nodes={internal, draw,semithick,minimum height=1.5em, inner sep=0.2em}]{#6};
 #7
 \end{tikzpicture}
 }}

 \begin{luacode}
 function btreenode(list, nodesize)
     ordinals = {"two", "four", "six", "eight", "ten", "twelve", "fourteen", "sixteen", "eighteen", "twenty"}
     list = string.split(list, ",")
     nodesize = tonumber(nodesize)
     for i=1, nodesize do
         idx = tonumber(i)
         num = list[idx]

         if num and num ~= '' then
            num = string.gsub(list[idx],":", ",")
         end
         tex.sprint({"\\nodepart{", ordinals[idx], "}", num})
         if not num or num == '' then
             tex.sprint({"\\phantom{X}"})
         end
      end
 end
 function btreeleaf(list)
     ordinals = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"}
     list = string.split(list, ",")
     for i,v in ipairs(list) do
         idx = tonumber(i)
         num = v
         if num and num ~= '' then
            num = string.gsub(list[idx],":", ",")
         end
         tex.sprint({"\\nodepart{", ordinals[idx], "}", num})
      end
 end

 \end{luacode}

 \NewDocumentCommand{\btreenode}{m}{\directlua{btreenode("#1", \internalsize)}}
 \NewDocumentCommand{\btreeleaf}{m}{\directlua{btreeleaf("#1")}}


\newcommand{\NA}{{{\color{gray}0}}}

\newcommand{\arraypicture}[4][-1.55em]{
    \setcounter{numcells}{\ArrLength{#3}+1}
    \begin{tabular}{c|*{\value{numcells}}{c|}}
    \cline{2-\value{numcells}}
    #2\ArrToTabular{#3}%
    \\\cline{2-\value{numcells}}
    \multicolumn{1}{c}{} & \multicolumn{\arabic{numcells}}{c}{}\\[#1]
    \multicolumn{1}{c}{} & \indxs{\ai{#4}}{\ArrLength{#3}}{0}
    \end{tabular}
}

\newcommand{\bufpicture}[1]{
\setlength{\extrarowheight}{0pt}
\setcounter{numcells}{\ArrLength{#1}+1}
\begin{tabular}{c*{\value{numcells}}{|c}c}\cline{2-\value{numcells}}
\leftarrow \ArrToTabular{#1} & \leftarrow\\
\cline{2-\value{numcells}}\end{tabular}}

\newcommand{\subarraypicture}[5][-1.55em]{
    \setcounter{numcells}{\ArrLength{#3}+1}
    \begin{tabular}{c|*{\value{numcells}}{c|}}
    \cline{2-\value{numcells}}
    #2\ArrToTabular{#3}%
    \\\cline{2-\value{numcells}}
    \multicolumn{1}{c}{} & \multicolumn{\arabic{numcells}}{c}{}\\[#1]
    \multicolumn{1}{c}{} & \indxs{\ai{#4}}{\ArrLength{#3}}{#5}
    \end{tabular}
}

\newcommand{\arraylistpicture}[2]{
    \setcounter{numcells}{\ArrLength{#2}+1}
    \begin{tabular}{c|*{\value{numcells}}{c|}}
    \cline{2-\value{numcells}}
    #1\ArrToTabular{#2}&\multicolumn{1}{c}{$\cdots$}
    \\\cline{2-\value{numcells}}
    \multicolumn{1}{c}{} & \multicolumn{\arabic{numcells}}{c}{}\\[-1.55em]
    \multicolumn{1}{c}{} & \indxs{\indx}{\ArrLength{#2}}{0} & \multicolumn{1}{c}{}%
    \end{tabular}
}


\newcommand{\linkedlistpicture}[3][\Large]{
    \mbox{$\vcenter{\vspace*{-0.4em}\hbox{#2\;\;}}$#1\ListToLL{#3}}%
}

\newcommand{\queuepicture}[2]{
    \setcounter{numcells}{\ArrLength{#2}+2}
    \begin{tabular}{cc|*{\value{numcells}}{c|}}
    \cline{3-\value{numcells}}
    #1&$\xleftarrow{}\hspace{-0.5em}$\ArrToTabular{#2}&\multicolumn{1}{c}{\hspace{-0.5em}$\xleftarrow{}$}
    \\\cline{3-\value{numcells}}
    \multicolumn{2}{c}{} & \multicolumn{\arabic{numcells}}{c}{}\\[-1.55em]
    \end{tabular}
}

\newcommand{\stackpicture}[3][0]{
    \begin{tabular}{c|c|l}
    \multicolumn{3}{c}{#2}\\
    \multicolumn{1}{c}{}&\multicolumn{1}{c}{$\downarrow\uparrow$}&\multicolumn{1}{c}{}
    \setcounter{vertcount}{#1}\ArrToVerticalTabular{#3}\\\cline{2-2}
    \ifnumequal{\arabic{vertcount}}{0}{}{\multicolumn{3}{c}{\vspace{#1 em}}}
    \end{tabular}
}

\newcounter{sdiff}
\newcounter{bigs}
\NewDocumentCommand{\stackbeforeafter}{O{stack} m m m O{1.0}}{
\ifnumgreater{\ArrLength{#3}}{\ArrLength{#2}}{%
    \setcounter{bigs}{\ArrLength{#3}}%
    \setcounter{sdiff}{\ArrLength{#3} - \ArrLength{#2}}}{%
    \setcounter{bigs}{\ArrLength{#2}}%
    \setcounter{sdiff}{\ArrLength{#2} - \ArrLength{#3}}}%
\begin{center}
\scalebox{#5}{
\stackpicture[\ifnumgreater{\ArrLength{#2}}{\ArrLength{#3}}{0}{\arabic{sdiff}}]{\texttt{#1}}{#2}
\begin{tabular}{c}
$\xrightarrow{\texttt{#4}}$\\
\vspace{\arabic{bigs}em}
\end{tabular}
\stackpicture[\ifnumgreater{\ArrLength{#3}}{\ArrLength{#2}}{0}{\arabic{sdiff}}]{\texttt{#1}}{#3}
\vspace{-1em}}
\end{center}
}

\NewDocumentCommand{\stackqueuebeforeafter}{O{stack} m m m O{1.0}}{
\ifnumgreater{\ArrLength{#3}}{\ArrLength{#2}}{%
    \setcounter{bigs}{\ArrLength{#3}}%
    \setcounter{sdiff}{\ArrLength{#3} - \ArrLength{#2}}}{%
    \setcounter{bigs}{\ArrLength{#2}}%
    \setcounter{sdiff}{\ArrLength{#2} - \ArrLength{#3}}}%
\begin{center}
\scalebox{#5}{
\stackpicture[\ifnumgreater{\ArrLength{#2}}{\ArrLength{#3}}{0}{\arabic{sdiff}}]{\texttt{#1}}{#2}
\begin{tabular}{c}
$\xrightarrow{\texttt{#4}}$\\
\vspace{\arabic{bigs}em}
\end{tabular}
\queuepicture{\texttt{queue}}{#3}
\vfill}
\end{center}
}

\NewDocumentCommand{\queuebeforeafter}{O{queue} m m m O{0.5\textwidth}}{

\ifnumgreater{\ArrLength{#3}}{\ArrLength{#2}}{%
    \setcounter{bigs}{\ArrLength{#3}}%
    \setcounter{sdiff}{\ArrLength{#3} - \ArrLength{#2}}}{%
    \setcounter{bigs}{\ArrLength{#2}}%
    \setcounter{sdiff}{\ArrLength{#2} - \ArrLength{#3}}}%

\hfill\begin{minipage}{#5}
\queuepicture{\texttt{#1}}{#2}\\

$\hspace*{\arabic{bigs}em}\xrightarrow{\texttt{#4}}$\\\vspace{-1em}

\queuepicture{\texttt{#1}}{#3}
\end{minipage}\hfill
\vspace{1em}

}


\newenvironment{prog-restrict}{\examheader{Implementation Restrictions}
\begin{itemize}\setlength\itemsep{-0.1em}\setlength{\itemindent}{-1.5em}}{\end{itemize}}

\newcommand{\beforeafter}[3]{
\begin{minipage}{0.08\textwidth}
\vspace{2em}
\underline{Before}:
\end{minipage}
\begin{minipage}{0.9\textwidth}
#1
\end{minipage}

\begin{minipage}{0.095\textwidth}
\underline{Code}:
\end{minipage}
\begin{minipage}{0.9\textwidth}
\texttt{#2}
\end{minipage}

\begin{minipage}{0.08\textwidth}
\underline{After}:
\end{minipage}
\begin{minipage}{0.9\textwidth}
\vspace{-7em}
\fillin[e]{0em}{#3}
\end{minipage}
}

\newcommand{\llbeforeafter}[2]{
\begin{minipage}{0.16\textwidth}
\vspace{1em}
\underline{Before}:
\end{minipage}
\begin{minipage}{0.9\textwidth}
#1
\end{minipage}

\vspace{1em}

\begin{minipage}{0.16\textwidth}
\vspace{1em}
\underline{After}:
\end{minipage}
\begin{minipage}{0.9\textwidth}
#2
\end{minipage}
}

\newcommand{\convexpath}[2]{
  [
  create hullcoords/.code={
    \global\edef\namelist{#1}
    \foreach [count=\counter] \nodename in \namelist {
      \global\edef\numberofnodes{\counter}
      \coordinate (hullcoord\counter) at (\nodename);
    }
    \coordinate (hullcoord0) at (hullcoord\numberofnodes);
    \pgfmathtruncatemacro\lastnumber{\numberofnodes+1}
    \coordinate (hullcoord\lastnumber) at (hullcoord1);
  },
  create hullcoords
  ]
  ($(hullcoord1)!#2!-90:(hullcoord0)$)
  \foreach [
  evaluate=\currentnode as \previousnode using \currentnode-1,
  evaluate=\currentnode as \nextnode using \currentnode+1
  ] \currentnode in {1,...,\numberofnodes} {
    let \p1 = ($(hullcoord\currentnode) - (hullcoord\previousnode)$),
    \n1 = {atan2(\y1,\x1) + 90},
    \p2 = ($(hullcoord\nextnode) - (hullcoord\currentnode)$),
    \n2 = {atan2(\y2,\x2) + 90},
    \n{delta} = {Mod(\n2-\n1,360) - 360}
    in
    {arc [start angle=\n1, delta angle=\n{delta}, radius=#2]}
    -- ($(hullcoord\nextnode)!#2!-90:(hullcoord\currentnode)$)
  }
}
\tikzset {
    graphnode/.style={
        circle,fill=colour!30,draw,font=\sffamily\scriptsize\bfseries,inner sep=0.11cm, minimum width=1.5em
    },
    main node/.style={circle,fill=colour!30,draw,font=\sffamily\scriptsize\bfseries,inner sep=0.11cm},
    graphedge/.style={every edge quotes/.style={fill=white,font=\sffamily\scriptsize,inner sep=2pt, pos=0.45}}
}

\usetikzlibrary{quotes}

%\NewDocumentCommand{\drawgraph}{O{tree layout, breadth first spanning tree} O{1cm} m O{}}{
%    \mbox{\begin{tikzpicture}[-,>=stealth',auto,node/.style={graphnode}, node distance=#2,thick]
%        \graph[#1, nodes={graphnode}]{#3};#4
%    \end{tikzpicture}}
%}

\NewDocumentCommand{\drawgraph}{O{tree layout, breadth first spanning tree} O{1cm} m O{}}{
    \mbox{\begin{tikzpicture}[-,>=stealth',node/.style={graphnode}, level distance=#2, node distance=(#2 + 0.5cm),thick]
        \graph[nodes={graphnode}, edges={graphedge}, #1]{#3};#4
    \end{tikzpicture}}
}


\def\bigsout{\bgroup
 \markoverwith{\lower-0.35ex\hbox{\kern-.03em\vbox{\hrule height 1.5pt width.2em}\kern-.03em}}\ULon}
\MakeRobust\redsout

\usepackage{tabularx}
\usepackage{longtable}

% Slightly modified ltablex
\newif\ifTX@convertX@
\TX@convertX@true

\newcommand\keepXColumns{
  \TX@convertX@false
}

\newcommand\convertXColumns{
  \TX@convertX@true
}

\newcommand*\TX@cap@gobble[2][]{\\}% RN, 2014/08/13
\newcommand{\attabxend}{\end{tabularx}}

\usepackage{makecell}
\usepackage{cellspace}

\newcommand{\pfl}[2]{
    \parbox[c]{0.45\textwidth}{#1}&%
    \parbox[c]{0.45\textwidth}{\it #2}\\
}

\renewcommand\TX@endtabularx{%
  \expandafter\TX@newcol\expandafter{\tabularxcolumn{\TX@col@width}}%
  \let\verb\TX@verb
  \def\@elt##1{\global\value{##1}\the\value{##1}\relax}%
  \edef\TX@ckpt{\cl@@ckpt}%
  \let\@elt\relax
  \TX@old@table=\maxdimen
  \TX@col@width=\TX@target
  \global\TX@cols=\@ne
  \TX@typeout@
    {\@spaces Table Width\@spaces Column Width\@spaces X Columns}%

  %
  % define \endhead, etc. to be \\ so that in this part
  % of the process they are just rows
  %
  \let\savecaption\caption
  \def\caption{% RN, 2014/08/13
    \@ifstar\TX@cap@gobble\TX@cap@gobble
  }
  \let\saveendhead\endhead
  \def\endhead{\\}
  \let\saveendfirsthead\endfirsthead
  \def\endfirsthead{\\}
  \let\saveendfoot\endfoot
  \def\endfoot{\\}
  \let\saveendlastfoot\endlastfoot
  \def\endlastfoot{\\}
  %
  %
  \ifTX@convertX@
    \TX@trial{\def\NC@rewrite@X{\NC@find l}}
    \ifdim\wd\@tempboxa<\TX@target
      \TX@newcol{l}
    \else
      \TX@convertX@false
    \fi
  \fi

  \ifTX@convertX@
    \relax
  \else
    \TX@trial{\def\NC@rewrite@X{%
        \global\advance\TX@cols\@ne\NC@find p{\TX@col@width}}}%
    \loop
      \TX@arith
      \ifTX@
      \TX@trial{}%
    \repeat
  \fi
  {\let\@footnotetext\TX@ftntext\let\@xfootnotenext\TX@xftntext
    % we may as well set \LTchunksize to be \maxdimen as the whole
    % thing is already in memory anyway so we may as well do it in one
    % chunk. if it is too big for one chunk we are already dead..
    \LTchunksize\maxdimen
    %
    % restore \endhead, etc.
    %
    \let\caption\savecaption
    \let\endhead\saveendhead
    \let\endfirsthead\saveendfirsthead
    \let\endfoot\saveendfoot
    \let\endlastfoot\saveendlastfoot
    %
    \expandafter\longtable
      \the\toks@
    \endlongtable
    }%
  \global\TX@ftn\expandafter{\expandafter}\the\TX@ftn
  \ifnum0=`{\fi}%
   \attabxend
}
\let\savedtx\TX@endtabularx%

\NewDocumentEnvironment{annotated-proof}{}{%

    \setlength\cellspacetoplimit{0.6em}
    \setlength\cellspacebottomlimit{0.6em}

    \renewcommand{\attabxend}{\endtabularx\end{annotated-proof}}%
    \def\TX@endtabularx{\toks@\expandafter{\the\toks@\hline}\savedtx}%
    \noindent\tabularx{\textwidth}{|*{2}{S{X}|}}
    \multicolumn{1}{c}{\bf Proof} & \multicolumn{1}{c}{\bf Commentary \& Scratch Work}\\\hline
}{
    \endtabularx
    \let\endtabularx\savedtx
    \renewcommand{\attabxend}{\end{tabularx}}
}

\newcommand{\modequiv}[3][m]{\ensuremath{#2 \equiv #3\;(\text{mod } #1)}}
\renewcommand{\mod}[2][m]{\ensuremath{#2\text{ mod } #1}}

\newcommand{\tfpart}[1]{
\def\arraystretch{1.5}%
\begin{tabular}{|ccc|p{0.8\linewidth}|}\hline
True & \textbf{or} & False & #1\\\hline
\end{tabular}}


\renewcommand{\documentclass}{}
