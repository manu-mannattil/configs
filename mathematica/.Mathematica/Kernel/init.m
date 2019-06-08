(* Delete the "Wolfram Mathematica" folder that's automatically created
   in ~/documents. *)

With[{dir = $UserDocumentsDirectory <> "/Wolfram Mathematica"},
  If[DirectoryQ[dir], DeleteDirectory[dir]]
]
