% mmnotes.cls -- a LaTeX class for note taking
%
% mmnotes.cls is a LaTeX class built on top of amsart.cls intended for
% note taking.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mmnotes}[2018/01/01 v0.1]

\LoadClass{amsart}

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{graphicx}
\RequirePackage[allcolors=Blue4,colorlinks]{hyperref}
\RequirePackage{microtype}
\RequirePackage{mathtime}
\RequirePackage[sort&compress,authoryear]{natbib}
\RequirePackage[x11names]{xcolor}

% We use the author-year citation style by default.
\let\cite\citet

% Make the font in the `quote' environment smaller.
\renewenvironment{quote}{%
  \small%
  \list{}{\rightmargin\leftmargin}\item[]
}{%
  \endlist
}

% Make the font in the `quotation' environment smaller.
\renewenvironment{quotation}{\list{}{%
  \small%
  \leftmargin3pc\listparindent\normalparindent%
  \itemindent\z@%
  \rightmargin\leftmargin \parsep\z@ \@plus\p@}%
  \item[]
}{%
  \endlist
}

\newenvironment{minabstract}{%
  \vspace{\parskip}%
  \begin{quote}
}{%
  \end{quote}%
  \vspace{\parskip}
}

% \bibliographystyle must be executed at the end of the document.
% Otherwise, the document won't compile.
\AtEndDocument{\bibliographystyle{apsrmp4-1}}

\allowdisplaybreaks
\widowpenalty10000
\clubpenalty10000

\endinput
