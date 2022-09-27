(*  Delete the "Wolfram Mathematica" directory that's
    automatically created in ~/documents.  *)

With[{dir = $UserDocumentsDirectory <> "/Wolfram Mathematica"},
  If[DirectoryQ[dir], DeleteDirectory[dir]]
];

(*  To make variables and functions unique to a notebook, I prefer
    setting CellContext->Notebook.  But this also means that definitions
    in init.m will be ignored by Mathematica.  The trick, therefore, is
    to define things in the "System" context.  But take care to ensure
    that the definitions start with a small letter to avoid conflicts.

    See: https://mathematica.stackexchange.com/a/13296  *)

(*  Custom color palettes.  *)

System`cMatplotlib = {
  RGBColor[31/255, 119/255, 180/255],
  RGBColor[255/255, 127/255, 14/255],
  RGBColor[44/255, 160/255, 44/255],
  RGBColor[214/255, 39/255, 40/255],
  RGBColor[148/255, 103/255, 189/255],
  RGBColor[140/255, 86/255, 75/255],
  RGBColor[227/255, 119/255, 194/255],
  RGBColor[127/255, 127/255, 127/255],
  RGBColor[188/255, 189/255, 34/255],
  RGBColor[23/255, 190/255, 207/255]
};

System`cNord = {
  RGBColor[46/255, 52/255, 64/255],
  RGBColor[59/255, 66/255, 82/255],
  RGBColor[67/255, 76/255, 94/255],
  RGBColor[76/255, 86/255, 106/255],
  RGBColor[216/255, 222/255, 233/255],
  RGBColor[229/255, 233/255, 240/255],
  RGBColor[236/255, 239/255, 244/255],
  RGBColor[143/255, 188/255, 187/255],
  RGBColor[136/255, 192/255, 208/255],
  RGBColor[129/255, 161/255, 193/255],
  RGBColor[94/255, 129/255, 172/255],
  RGBColor[191/255, 97/255, 106/255],
  RGBColor[208/255, 135/255, 112/255],
  RGBColor[235/255, 203/255, 139/255],
  RGBColor[163/255, 190/255, 140/255],
  RGBColor[180/255, 142/255, 173/255]
};

System`cBluesmoke = {
  RGBColor[47/255, 93/255, 140/255],
  RGBColor[53/255, 106/255, 159/255],
  RGBColor[60/255, 119/255, 178/255],
  RGBColor[70/255, 132/255, 193/255],
  RGBColor[89/255, 144/255, 200/255],
  RGBColor[108/255, 157/255, 206/255],
  RGBColor[128/255, 170/255, 212/255],
  RGBColor[147/255, 183/255, 219/255],
  RGBColor[166/255, 195/255, 225/255],
  RGBColor[204/255, 221/255, 238/255],
  RGBColor[223/255, 234/255, 244/255],
  RGBColor[242/255, 246/255, 251/255]
};
