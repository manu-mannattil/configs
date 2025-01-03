#!/bin/sed -nf

# HTML codes -> ASCII
s/&nbsp;/ /g
s/&amp;/\&/g
s/&lt;/\</g
s/&gt;/\>/g
s/&quot;/\"/g
s/&#39;/'/g
s/&ldquo;/\"/g
s/&rdquo;/\"/g

s|^<DT><A HREF="\([^"]*\)" SHORTCUTURL="\([^"]*\)">\([^<]*\)<\/A>$|\2: \1 \3|p
