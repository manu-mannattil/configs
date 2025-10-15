#!/bin/sh

# Run ctags first.
ctags --tag-relative -R --languages=tex2,Tex,bib

# Bail out if there's no evidence of a git repo.
test -d ".git" && git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

# This is an NIH hack to avoid using the gitinfo2 package.
# Use \input{.git/gitInfo.in} to read the git metadata
# within the LaTeX source.
git --no-pager log -1 --date="format:%B %d, %Y" --decorate=short --pretty=format:'
  \def\gitHash{%H}
  \def\gitShortHash{%h}
  \def\gitRefName{%D}
  \def\gitAuthorName{%an}
  \def\gitAuthorEmail{%ae}
  \def\gitAuthorDate{%ai}
  \def\gitAuthorAltDate{%aD}
  \def\gitCommitterName{%cn}
  \def\gitCommitterEmail{%ce}
  \def\gitCommitterDate{%ci}
  \def\gitCommitterAltDate{%cD}
  \def\gitCommitterDateHuman{%cd}
' HEAD >.git/gitInfo.in
