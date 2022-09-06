(*  Delete the "Wolfram Mathematica" directory that's
    automatically created in ~/documents.  *)

With[{dir = $UserDocumentsDirectory <> "/Wolfram Mathematica"},
  If[DirectoryQ[dir], DeleteDirectory[dir]]
];
