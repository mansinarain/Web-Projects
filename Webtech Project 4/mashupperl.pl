#!/usr/usc/bin/perl
use CGI qw/:standard/;

require "loginpageLWP.pl";
print "Content-type: text/xml \n\n";
print "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n";
print "<rsp stat=\"ok\">\n";

my $counter = 0;

$queryData = param("searchstockval");  
@formData = split(/ /, $queryData);

foreach $count (@formData) {
$counter = $counter+1;
}


print "<stocks total=\"$counter\">";

foreach $valuestck (@formData) {

    $data=requested_data($valuestck);
   # $data=~/(http:\/\/chart.finance.yahoo.com\/t[^>]+)/g;
   #$Img=$1;

    $data=~s/<[^>]+>//g;

    $data=~/Open:(\d*\.?\d+|n\/a)/;
    $Open=$1;

    $data=~/Ask:(\d*\.?\d+|n\/a)/;
    $Ask=$1;

    $data=~/Bid:(\d*\.?\d+|n\/a)/;
    $Bid=$1;

    $data=~/Last Trade:(\d*\.?\d+|n\/a)/;
    $Price=$1;

    print "<stock symbol=\"$valuestck\" price=\"$Price\" open=\"$Open\" bid=\"$Bid\" ask=\"$Ask\" chart=\"http://ichart.finance.yahoo.com/t?s=$valuestck&amp;lang=en-
US&amp;region=US\">";
    print "</stock>";
}
print "</stocks>";
print "</rsp>";
