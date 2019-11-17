#############################################################################
##
##  PackageInfo.g for the package `FSR'
#
SetPackageInfo( rec(
PackageName := "FSR",
Subtitle := "Feedback Shift Register Package",
Version := "1.2.2",
Date := "17/11/2019",
##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY VERSION "1.2.2">
##  <!ENTITY RELEASEDATE "17 November 2019">
##  <!ENTITY RELEASEYEAR "2019">
##  <#/GAPDoc>

Persons := [
  rec(
    LastName      := "Zidaric",
    FirstNames    := "Nusa",
    IsAuthor      := true,
    IsMaintainer  := true,
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


SourceRepository := rec(
    Type := "git",
    URL := Concatenation( "https://github.com/nzidaric/", ~.PackageName ),
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := Concatenation( "https://nzidaric.github.io/", ~.PackageName ),
README_URL      := Concatenation( ~.PackageWWWHome, "/README.md" ),
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

AbstractHTML := "",



PackageDoc := rec(
  BookName  := "FSR",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Feedback Shift Register Package",
  Autoload := true
),

Dependencies := rec(
  GAP := "4.7",
  NeededOtherPackages := [["GAPDoc", "1.5"]],
  SuggestedOtherPackages := [],
  ExternalConditions := []

),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

Keywords := ["package FSR", "LFSR" , "finite fields", "sequences"]

));
