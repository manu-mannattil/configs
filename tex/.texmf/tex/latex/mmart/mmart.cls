% mmart.cls -- a custom article class

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mmart}[2019/01/25 v0.2]

\LoadClass[11pt,twoside]{article}
\RequirePackage[utf8]{inputenc}
\RequirePackage[hmargin=1in,vmargin=1.2in]{geometry}
\RequirePackage{graphicx}
\RequirePackage{mathtools}
\RequirePackage{microtype}
\RequirePackage[svgnames]{xcolor}
\RequirePackage[
  colorlinks,
  linkcolor=DarkRed,
  anchorcolor=Black,
  citecolor=DarkGreen,
  filecolor=DarkOliveGreen,
  menucolor=Black,
  urlcolor=DarkBlue,
]{hyperref}
\newcommand{\email}[1]{\href{mailto:#1}{\texttt{#1}}}

% Section heading formatting.
\usepackage{titlesec}
\titleformat{\section}{\bfseries\sffamily}{\thesection. }{0pt}{\MakeUppercase}
\titleformat{\subsection}{\bfseries\sffamily}{\thesubsection. }{0pt}{}
\titleformat{\subsubsection}{\itshape\sffamily}{\thesubsubsection. }{0pt}{}
% \renewcommand{\thesection}{\Roman{section}}
% \renewcommand{\thesubsection}{\Roman{subsection}}
% \renewcommand{\thesubsubsection}{\Roman{subsubsection}}


\RequirePackage[numbers,sort&compress]{natbib}
\let\cite\citet

% \RequirePackage[charter]{mathdesign}
% \RequirePackage{sourcesanspro,inconsolata}
\RequirePackage{mathtime}

\DeclareOption{numbers}{%
 \AtBeginDocument{%
  \RequirePackage{lineno}
  \renewcommand\linenumberfont{\color{darkgray}\normalfont\normalsize}
  \renewcommand\linenumbersep{1.2em}
  \linenumbers\relax
 }%
}%

\ProcessOptions\relax

% Make the font in the `quote' environment smaller.
\renewenvironment{quote}{%
  \small%
  \list{}{\rightmargin\leftmargin}\item[]
}{%
  \endlist
}

% % Make the font in the `quotation' environment smaller.
% \renewenvironment{quotation}{\list{}{%
%   \small%
%   \leftmargin3pc\listparindent\normalparindent%
%   \itemindent\z@%
%   \rightmargin\leftmargin \parsep\z@ \@plus\p@}%
%   \item[]
% }{%
%   \endlist
% }

% \newenvironment{minabstract}{%
%   \vspace{\parskip}%
%   \begin{quote}
% }{%
%   \end{quote}%
%   \vspace{\parskip}
% }

% \bibliographystyle must be executed at the end of the document.
% Otherwise, the document won't compile.
\AtEndDocument{\bibliographystyle{apsrmp4-1}}

\allowdisplaybreaks
\widowpenalty10000
\clubpenalty10000

\endinput
