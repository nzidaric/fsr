#############################################################################
##  
##  PackageInfo.g for the package `FSR'                  
#
SetPackageInfo( rec(
PackageName := "FSR",
Subtitle := "FSR - Feedback Shift Register Package",
Version := "1.0.3",
Date := "16/01/2017",
##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY VERSION "1.0.3">
##  <!ENTITY RELEASEDATE "16 January 2017">
##  <!ENTITY RELEASEYEAR "2017">
##  <#/GAPDoc>

Persons := [
  rec( 
    LastName      := "Zidaric",
    FirstNames    := "Nusa",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "nzidaric@uwaterloo.ca",
    WWWHome       := "http://comsec.uwaterloo.ca/",
    PostalAddress := Concatenation( [
                       "200 University Ave W",
                       "Waterloo",
                       "Canada",
                       "ON N2L 3G1" ] ),
    Place         := "Waterloo",
    Institution   := "UW-ComSec Lab"
  ),
 
  rec( 
    LastName      := "Aagaard",
    FirstNames    := "Mark",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "maagaard@uwaterloo.ca",
    WWWHome       := "http://comsec.uwaterloo.ca/",
    PostalAddress := Concatenation( [
                       "200 University Ave W",
                       "Waterloo",
                       "Canada",
                       "ON N2L 3G1" ] ),
    Place         := "Waterloo",
    Institution   := "UW-ComSec Lab"
  ),  
   rec( 
      LastName      := "Gong",
      FirstNames    := "Guang",
      IsAuthor      := true,
      IsMaintainer  := false,
      Email         := "ggong@uwaterloo.ca",
      WWWHome       := "http://comsec.uwaterloo.ca/",
      PostalAddress := Concatenation( [
                         "200 University Ave W",
                         "Waterloo",
                         "Canada",
                         "ON N2L 3G1" ] ),
      Place         := "Waterloo",
      Institution   := "UW-ComSec Lab"
  ),  
],

Status := "other",


PackageDoc := rec(    
  BookName  := "FSR",
  PDFFile   := "doc/fsr.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "FSR - Feedback Shift Register Package",
  Autoload := true
),

Dependencies := rec(
  GAP := "4.8",
  NeededOtherPackages := [["GAPDoc", "1.5"]],
  SuggestedOtherPackages := [],
  ExternalConditions := []
                      
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.tst",

Keywords := ["package FSR", "LFSR" , "finite fields", "sequences"]

));

