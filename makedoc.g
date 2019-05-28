###########################################################################
##
#W buildman.g                Based on the buildman.g from the SCSCP package
##
###########################################################################

ExtractMyManualExamples:=function( pkgname, main, files )
local path, tst, i, s, name, output, ch, a;
path:=Directory( 
        Concatenation(PackageInfo(pkgname)[1].InstallationPath, "/doc") );
Print("Extracting manual examples for ", pkgname, " package ...\n" );
tst:=ExtractExamples( path, main, files, "Chapter" );
Print(Length(tst), " chapters detected\n");
for i in [ 1 .. Length(tst) ] do 
  Print( "Chapter ", i, " : \c" );
  if Length( tst[i] ) > 0 then
    s := String(i);
    if Length(s)=1 then 
      # works for <100 chapters
      s:=Concatenation("0",s); 
    fi;
    name := Filename( 
              Directory( 
                Concatenation( PackageInfo(pkgname)[1].InstallationPath, 
                               "/tst" ) ), 
                Concatenation( LowercaseString(pkgname), s, ".tst" ) );
    output := OutputTextFile( name, false ); # to empty the file first
    SetPrintFormattingStatus( output, false ); # to avoid line breaks
    ch := tst[i];
    AppendTo(output, "# ", pkgname, ", chapter ",i,"\n");
    for a in ch do
      AppendTo(output, "\n# ",a[2], a[1]);
    od;
    Print("extracted ", Length(ch), " examples \n");
  else
    Print("no examples \n" );    
  fi;  
od;
end;

###########################################################################

FSRMANUALFILES:=[
"../PackageInfo.g",
"../lib/fsr.gd",
"../lib/lfsr.gd",
"../lib/nlfsr.gd",
"../lib/filfun.gd",
"../lib/outfsr.gd",
"../lib/outputs.gd",
"../lib/misc.gd",
"../lib/drawlfsr.gd",
"../lib/drawnlfsr.gd",
];
Print(FSRMANUALFILES,"\n");

###########################################################################
##
##  FSRBuildManual()
##
FSRBuildManual := function()
local path, main, files, bookname;
path:="doc";
main:="manual";
bookname:="fsr";
MakeGAPDocDoc( path, main, FSRMANUALFILES, bookname, "../../..", "MathJax" );  
#MakeGAPDocDoc( path, main, FSRMANUALFILES, bookname ); 
CopyHTMLStyleFiles( path );
GAPDocManualLab( "fsr" );; 
#ExtractMyManualExamples( "fsr", main, FSRMANUALFILES);
end;


###########################################################################

FSRBuildManual();

###########################################################################
##
#E
##