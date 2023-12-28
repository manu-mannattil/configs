(* = Charu Plot Theme = *)
(*  Based on Academic Plot theme by Everett You.
    Upstream: https://mathematica.stackexchange.com/a/111439
    GitHub: https://github.com/EverettYou/Mathematica-for-physics/blob/master/Themes/Academic.m  *)
Begin["System`PlotThemeDump`"];
Themes`ThemeRules; (* preload Theme system *)

(* Define the base theme *)
resolvePlotTheme["Charu",def:_String]:=
  Themes`SetWeight[Join[
    resolvePlotTheme["CharuFrame",def],        (* Axes feature *)
    resolvePlotTheme["Figure",def],            (* Size feature *)
    resolvePlotTheme["HeavyLines",def],        (* Curve thickness feature *)
    resolvePlotTheme["CharuColor",def],        (* Color feature *)
    resolvePlotTheme["SmallOpenMarkers",def]], (* Point marker feature *)
   Themes`$DesignWeight];

(* == Axes feature == *)
(* === 2D Plots === *)
resolvePlotTheme["CharuFrame",def:_String]:=
  Themes`SetWeight[Join[
    {Axes->False,Frame->True}, (* Charu figures are framed by default *)
    resolvePlotTheme["CharuFrame2D",def]],
   $ComponentWeight];

resolvePlotTheme["CharuFrame",def:"PairedBarChart"|"PairedHistogram"]:=
  Themes`SetWeight[Join[
    {Axes->True,Frame->True}, (* Cases with axes also *)
    resolvePlotTheme["CharuFrame2D",def]],
   $ComponentWeight];

resolvePlotTheme["CharuFrame",def:"ArrayPlot"|"MatrixPlot"]:=
  Themes`SetWeight[Join[
    (* Frame not specified but MeshStyle specified to be thin and light *)
    {MeshStyle->Directive[AbsoluteThickness[0.5],Opacity[0.25]]},
    resolvePlotTheme["CharuFrame2D",def]],
   $ComponentWeight];

resolvePlotTheme["CharuFrame",
   def:"BarChart"|"PieChart"|"RectangleChart"|"SectorChart"|
     "CandlestickChart"|"KagiChart"|"LineBreakChart"|
     "PointFigureChart"|"RenkoChart"|"InteractiveTradingChart"|
     "TradingChart"|"NumberLinePlot"|"TimelinePlot"]:=
  resolvePlotTheme["CharuFrame2D",def]; (* Charts not framed *)

(* === 3D Plots === *)
resolvePlotTheme["CharuFrame",
   def:_String/;StringMatchQ[def,___~~"3D"]]:=
  Themes`SetWeight[Join[
    {Axes->True,AxesEdge->{{-1,-1},{1,-1},{-1,-1}},
     Boxed->{Left,Bottom,Back}}, (* Front axes back box *)
    resolvePlotTheme["CharuFrame3D",def]],
   $ComponentWeight];

resolvePlotTheme["CharuFrame","ChromaticityPlot3D"]:=
  Themes`SetWeight[Join[
    {Axes->True,AxesEdge->{{-1,-1},{-1,-1},{-1,1}},
     Boxed->{Left,Top,Front}}, (* Front box back axes *)
    resolvePlotTheme["CharuFrame3D","ChromaticityPlot3D"]],
   $ComponentWeight];

resolvePlotTheme["CharuFrame",
   def:"BarChart3D"|"PieChart3D"|"RectangleChart3D"|"SectorChart3D"]:=
  resolvePlotTheme["CharuFrame3D",def]; (* Chart3Ds not boxed *)

(* === Common features of axes/frame === *)
(* Mathematica's working theme: axes and frames too thin, terribly grayish,
   and tick/label font too small, but grids too thick. The new theme will fix these. *)
resolvePlotTheme["CharuFrame2D",_]:=
  Themes`SetWeight[
   {AxesStyle->Directive[AbsoluteThickness[0.8],monoColor,FontSize->10],
    BaseStyle->{Directive[FontFamily->"Nimbus Sans L"],SingleLetterItalics->True},
    PlotStyle->{Directive[Thickness[0.006]]},
    FrameStyle->Directive[AbsoluteThickness[0.8],monoColor,FontSize->10],
    TicksStyle->Directive[monoColor,FontSize->10],
    FrameTicksStyle->Directive[monoColor,FontSize->10],
    GridLinesStyle->Directive[AbsoluteThickness[0.5],Opacity[0.5]]},
   $ComponentWeight];

resolvePlotTheme["CharuFrame3D",_]:=
  Themes`SetWeight[
   {AxesStyle->Directive[AbsoluteThickness[0.8],monoColor,FontSize->10],
    BaseStyle->{Directive[FontFamily->"Nimbus Sans L"],SingleLetterItalics->True},
    PlotStyle->{Directive[Thickness[0.006]]},
    TicksStyle->Directive[monoColor,FontSize->10],
    BoxStyle->monoColor},
   $ComponentWeight];

(* == Size definitions == *)
resolvePlotTheme["Figure",def:_String]:=
  Themes`SetWeight[
   {ImageSizeRaw->{{260},{160}}, (* 2D plots 260x160 pts *)
    LabelStyle->Directive[monoColor,FontSize->10]},
   Themes`$SizeWeight];

resolvePlotTheme["Figure","ArrayPlot"|"MatrixPlot"]:=
  Themes`SetWeight[
   {ImageSizeRaw->{{220},{220}}, (* Array/matrix 220 pts *)
    LabelStyle->Directive[monoColor,FontSize->10]},
   Themes`$SizeWeight];

resolvePlotTheme["Figure",def:_String/;StringMatchQ[def,___~~"3D"]]:=
  Themes`SetWeight[
   {ImageSizeRaw->{{200},{200}}, (*3D plots 200 pts*)
    LabelStyle->Directive[monoColor,FontSize->10]},
   Themes`$SizeWeight];

(* Size not specified for LinePlots (because they are wide) *)
resolvePlotTheme["Figure","NumberLinePlot"|"TimelinePlot"]:={};

(* == Color feature == *)
(* Color scheme based on VibrantColor, which is bright and vivid *)
resolvePlotTheme["CharuColor",def:_String]:=
  Module[{},
    (* Based on Matplotlib default colors *)
    $ThemeColorIndexed={
      RGBColor[214/255, 39/255, 40/255],
      RGBColor[31/255, 119/255, 180/255],
      RGBColor[76/255, 86/255, 106/255],
      RGBColor[255/255, 127/255, 14/255],
      RGBColor[44/255, 160/255, 44/255],
      RGBColor[148/255, 103/255, 189/255],
      RGBColor[140/255, 86/255, 75/255],
      RGBColor[227/255, 119/255, 194/255],
      RGBColor[127/255, 127/255, 127/255],
      RGBColor[188/255, 189/255, 34/255],
      RGBColor[23/255, 190/255, 207/255]
    };
    $ThemeColorDensity="ThermometerColors"; (* Thermometer for density *)
    $ThemeColorArrayPlot={GrayLevel[0],GrayLevel[1]}; (* Grayscale for Array *)
    $ThemeColorDensity3D="ThermometerColors"; (* Thermometer for density *)
    $ThemeColorVectorDensity="VibrantColorVectorDensityGradient";
    (* Green and red *)
    $ThemeColorFinancial={
      RGBColor[0., 0.596078, 0.109804],
      RGBColor[0.790588, 0.201176, 0.]
    };
    $ThemeColorGradient={
      RGBColor[0.790588, 0.201176, 0.],
      RGBColor[0.567426, 0.32317, 0.729831],
      RGBColor[0.192157, 0.388235, 0.807843],
      RGBColor[0., 0.596078, 0.109804],
      RGBColor[1., 0.607843, 0.]
    };
    $ThemeColorMatrix= (* Red-blue split *)
      {{0,RGBColor[0.128105, 0.25882, 0.538562]},
      {0.1,RGBColor[0.192157, 0.388235, 0.807843]},
      {0.499999,RGBColor[0.8384314, 0.877647, 0.9615686]},
      {0.5,RGBColor[{1, 1, 1}]},
      {0.500001,RGBColor[0.9581176, 0.8402352, 0.8]},
      {0.9,RGBColor[0.790588, 0.201176, 0.]},
      {1,RGBColor[0.527059, 0.134117, 0.]}};
    $ThemeColorFractal="VibrantColorFractalGradient";
    $ThemeColorWavelet={RGBColor[0.0621178, 0.273882, 0.727059],
      RGBColor[0.790588, 0.201176, 0.],RGBColor[1., 0.607843, 0.],
      RGBColor[1., 1., 1.]};
    resolvePlotTheme["ColorStyle",def]];

(* == Point marker feature ==*)
(* No markers by default *)
resolvePlotTheme["SmallOpenMarkers",def:_String]:={};

(* Set markers for ListPlots
resolvePlotTheme["SmallOpenMarkers",
    "DateListLogPlot"|"DateListPlot"|"DiscretePlot"|"ListCurvePathPlot"|
    "ListLinePlot"|"ListLogLinearPlot"|"ListLogLogPlot"|
    "ListLogPlot"|"ListPlot"]:=
  Themes`SetWeight[
   {PlotMarkers->Module[{s1 = 2., s2 = 1.8, s3 = 2.5, s4 = 1.3, thickness = 1.5},
      {Graphics[{{White, Disk[{0, 0}, Offset[{s1, s1}]]}, {AbsoluteThickness[thickness], Dashing[{}], Circle[{0, 0}, Offset[{s1, s1}]]}}],
       Graphics[{{White, Polygon[{Offset[{0, 2*s4}], Offset[s4*{-Sqrt[3], -1}], Offset[s4*{Sqrt[3], -1}]}]}, {AbsoluteThickness[thickness], Dashing[{}], JoinedCurve[Line[{Offset[{0, 2*s4}], Offset[s4*{-Sqrt[3], -1}], Offset[s4*{Sqrt[3], -1}], Offset[{0, 2*s4}]}], CurveClosed -> True]}}],
       Graphics[{{White, Polygon[{Offset[{0, s3}], Offset[{s3, 0}], Offset[{0, -s3}], Offset[{-s3, 0}]}]}, {AbsoluteThickness[thickness], Dashing[{}], Line[{Offset[{0, s3}], Offset[{s3, 0}], Offset[{0, -s3}], Offset[{-s3, 0}], Offset[{0, s3}]}]}}],
       Graphics[{{White, Polygon[{Offset[{-s2, -s2}], Offset[{s2, -s2}], Offset[{s2, s2}], Offset[{-s2, s2}], Offset[{-s2, -s2}]}]}, {AbsoluteThickness[thickness], Dashing[{}], Line[{Offset[{-s2, -s2}], Offset[{s2, -s2}], Offset[{s2, s2}], Offset[{-s2, s2}], Offset[{-s2, -s2}]}]}}],
       Graphics[{{White, Polygon[{Offset[{0, -2*s4}], Offset[s4*{-Sqrt[3], 1}], Offset[s4*{Sqrt[3], 1}]}]}, {AbsoluteThickness[thickness], Dashing[{}], JoinedCurve[Line[{Offset[{0, -2*s4}], Offset[s4*{-Sqrt[3], 1}], Offset[s4*{Sqrt[3], 1}], Offset[{0, -2*s4}]}], CurveClosed -> True]}}]}]},
   $ComponentWeight];*)
End[];

(* $PlotTheme="Charu"; (* Set to default plot theme *) *)
