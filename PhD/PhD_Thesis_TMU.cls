%
%
%فایل "cls"
%
%
%با تشکر از "وفا خلیقی" و "وحید دامن‌افشان".
% 
% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{PhD_Thesis_TMU}
              [2013/03/17 v1.1 Tanin/thesis/dissertations Class]
\newif\if@bscthesis
\@bscthesisfalse
\newif\if@mscthesis
\@mscthesisfalse
\DeclareOption{bsc}{\@bscthesistrue}
\DeclareOption{msc}{\@mscthesistrue}
\DeclareOption{phd}{\@bscthesisfalse\@mscthesisfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[a4paper,11pt,twoside,openany]{book}
%
%
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage[top=40mm, bottom=40mm, left=25mm, right=35mm]{geometry}
\RequirePackage{graphicx}
\RequirePackage{framed} 
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\setlength{\headheight}{15pt}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage{makeidx}
\makeindex
\RequirePackage{hyperref}
%
%
\def\university#1{\gdef\@university{#1}}
\def\department#1{\gdef\@department{#1}}
\def\degree#1{\gdef\@degree{#1}}
\def\thesisdate#1{\gdef\@thesisdate{#1}}
\newcommand{\firstsupervisor}[1]{\def\@firstsupervisor{#1}}
\newcommand{\secondsupervisor}[1]{\def\@secondsupervisor{#1}}
\newcommand{\firstadvisor}[1]{\def\@firstadvisor{#1}}
\newcommand{\secondadvisor}[1]{\def\@secondadvisor{#1}}
\def\name#1{\gdef\@name{#1}}
\def\surname#1{\gdef\@surname{#1}}
\long\def\keywords#1{\gdef\@keywords{#1}}
\long\def\fa-abstract#1{\gdef\@fa-abstract{#1}}
\def\faculty#1{\gdef\@faculty{#1}}
\def\subject#1{\gdef\@subject{#1}}
\def\field#1{\gdef\@field{#1}}
\def\department#1{\gdef\@department{#1}}
%
%
\def\latintitle#1{\gdef\@latintitle{#1}}
\def\latinauthor#1{\gdef\@latinauthor{#1}}
\def\latindegree#1{\gdef\@latindegree{#1}}
\def\latinfaculty#1{\gdef\@latinfaculty{#1}}
\def\latinthesisdate#1{\gdef\@latinthesisdate{#1}}
\def\latinsubject#1{\gdef\@latinsubject{#1}}
\def\latinfield#1{\gdef\@latinfield{#1}}
\def\firstlatinsupervisor#1{\gdef\@firstlatinsupervisor{#1}}
\def\secondlatinsupervisor#1{\gdef\@secondlatinsupervisor{#1}}
\def\firstlatinadvisor#1{\gdef\@firstlatinadvisor{#1}}
\def\secondlatinadvisor#1{\gdef\@secondlatinadvisor{#1}}
\def\latinname#1{\gdef\@latinname{#1}}
\def\latinsurname#1{\gdef\@latinsurname{#1}}
\long\def\en-abstract#1{\gdef\@en-abstract{#1}}
\long\def\latinkeywords#1{\gdef\@latinkeywords{#1}}
\def\latinuniversity#1{\gdef\@latinuniversity{#1}}
%
%
%
%
\newcommand{\vtitle}{
\begin{titlepage}
\vspace{-10ex}\centerline{{
\includegraphics[scale=0.1]{Fa_logo}
}}
\vspace{-2.65cm}
{\large\@faculty\par
\vspace{-3ex}\@department}\par
\vspace{-2ex}
 \if@mscthesis
{\large\bfseries پایان‌نامه}
\else
 \if@bscthesis
 {\large\bfseries پروژه }
 \else
%{\large\bfseries رساله}
\fi\fi
%\vskip 2ex
{\large\bfseries\writtenfor
\if@mscthesis
کارشناسی ارشد
\else
\if@bscthesis
کارشناسی
\else
\Fathesisfield
\fi\fi
}
\vskip 4ex
%\baselineskip=.750cm
\centerline{\large \bfseries\onvan}
\vskip -.5cm
 {\huge\bfseries {\baselineskip=1cm \@title}}\baselineskip=1.5cm\par
\vskip 1ex
 \baselineskip=.7cm
{\large%
  \by}\par
\vspace{-2ex}
{\Large\bfseries{ \@name }}\par
\large
{\ifx\@firstsupervisor\undefined%
\ifx\@secondsupervisor\undefined%
\else\fi
\else
\ifx\@secondsupervisor\undefined%
استاد راهنما 
\vspace{-2ex}
{\Large\bfseries\par
\@firstsupervisor}
\else
\large
استادان راهنما
\par
{\Large\bfseries \@firstsupervisor{} و \@secondsupervisor}
\fi\fi}
\par\large
{\ifx\@firstadvisor\undefined%
\ifx\@secondadvisor\undefined%
\else\fi
\else
\ifx\@secondadvisor\undefined%
استاد مشاور 
\vspace{-2ex}
{\Large\bfseries\par
\@firstadvisor}
\else

\large
استادان مشاور
\par
\vspace{-2ex}
{\Large\bfseries\@firstadvisor{} و \@secondadvisor}
\fi\fi}

{\large \@thesisdate}
%\vfill
\end{titlepage}}
%
%
\def\acknowledgementpage{\newpage
\thispagestyle{empty}

\vspace{1cm}
\par\noindent}
\def\endacknowledgementpage{\newpage}

\def\titlepage{\newpage\centering
  \thispagestyle{empty}
  \parindent 0pt \parskip 10pt plus 1fil minus 1fil
  \def\baselinestretch{1}\@normalsize\vbox to \vsize\bgroup\vbox to 9in\bgroup}
\def\endtitlepage{\par\kern 0pt\egroup\vss\egroup\newpage}

\def\signature{\vspace{1cm}
\begin{flushleft}
{\nastaliq \scriptsize \@name\ \@surname \\
\@thesisdate}
\end{flushleft}}

\def\abstract{\subsection*{\abstractname}\small
\@normalsize}
\def\endabstract{\par}

\newcommand{\latinvtitle}{%
\if@bscthesis \relax
\else
%
% 
\begin{titlepage}
\vspace{-10ex}{\includegraphics[scale=0.1]{En_logo}}
\vspace{-1.75cm}
\large\centerline{\bf \@latinfaculty}
\bfseries {\bf \@latinuniversity}\space 
\vspace{1cm}
\vskip 9mm
%{
 \if@mscthesis
Dissertation Submitted in Partial 
\\[.2cm]
Fulfillment of The Requirements For The
\\[.2cm]
Degree of Master of Science in
\else
Doctoral Thesis Submitted in Partial 
\\[.2cm]
Fulfillment of the  Requirements for the
\\[.2cm]
\Enthesisfield
\fi
\\[.7cm]
Title
\vskip 1cm
\baselineskip=.750cm
{\huge\bfseries\@latintitle}
\baselineskip=1cm \par
%\addtolength{\baselineskip}{-5mm}
\vskip 1.5cm
\vskip 5mm
{\bfseries\latinby}\par
\vskip 5mm
{\Large \@latinname }\par
\vskip 1cm
\large
{\ifx\@firstlatinsupervisor\undefined%
\ifx\@secondlatinsupervisor\undefined%
\else\fi
\else
\ifx\@secondlatinsupervisor\undefined%
Supervisor
\vskip 6mm
{\Large\bfseries\par
\@firstlatinsupervisor}\vskip5mm
\else
\large
Supervisors
\par
{\Large\bfseries \@firstlatinsupervisor{} and \@secondlatinsupervisor}\vskip3mm
\fi\fi}
\par
\vskip 5mm
\large
{\ifx\@firstlatinadvisor\undefined%
\ifx\@secondlatinadvisor\undefined%
\else\fi
\else
\ifx\@secondlatinadvisor\undefined%
Advisor
\vskip 6mm
{\Large\bfseries\par
\@firstlatinadvisor}\vskip5mm
\else

\large
Advisors
\par
{\Large\bfseries\@firstlatinadvisor{} and \@secondlatinadvisor}\vskip3mm
\fi\fi}

\vskip 5mm

\par
\vskip 2cm

{\@latinthesisdate}
\par
\vskip 1cm

\par

\vfill
%
\end{titlepage}

\fi}

\def\onvan{عنوان}
\def\writtenfor{رساله }
\def\by{دانشجو}
\def\latinby{By}
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
\hbox{}
\thispagestyle{empty}
\newpage
\if@twocolumn\hbox{}\newpage\fi\fi\fi}
%
%
\renewcommand{\bibname}{مراجع}
\newcommand\persiangloss[2]{\noindent\lr{#2}\dotfill\rl{#1}\par}
\newcommand\englishgloss[2]{\noindent\rl{#2}\dotfill\lr{#1}\par}
\newcommand{\پ}{پروژه/پایان‌نامه/رساله }
%
%
\pagestyle{fancy}
\fancyhf{} 
\fancyhead[OL,EL]{\thepage}
\fancyhead[OR]{\small\rightmark}
\fancyhead[ER]{\small\leftmark}
\renewcommand{\chaptermark}[1]{%
\markboth{\thechapter.\ #1}{}}
