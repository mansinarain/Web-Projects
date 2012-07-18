#!/usr/usc/bin/perl
use CGI qw/:standard/;
use CGI::Carp qw( fatalsToBrowser );

require "loginpageLWP.pl";
my $username = param(USERNAME);
my $password = param(PASSWORD);

print header;
open(FILE, "../htdocs/data.txt") || die "The database cannot be accessed";

while (<FILE>)
{
        @data = split(/\n/);
        foreach $dataentry (@data)
          {
              ($fname,$mname,$lname,$addr,$city,$state,$zipcode,$loginnm,$loginpwd,$confpwd,$stck1,$stck2,$stck3) = split( /,/, $dataentry);

               if ($loginnm eq "$username")

                  {

                           $userverified =1;

                           if($loginpwd eq "$password")
                             {
                                       $passwordverified = 1;
					last;
                             }


                  }
           }
	if($userverified && $passwordverified)
	  {
		 last;
	  }
}

close(FILE);

 if($userverified && $passwordverified)
  {
         &access;
  }
elsif( $userverified && !$passwordverified)
   {
         &wrongpwd;
   }
else
  {
         &accessdenied;
  }

sub access
{
print "<html><body>";
print "<title> Welcome to $fname 's Page<title>";
print "<CENTER><B>Welcome Back $fname !</B></CENTER>";
print "<BR />";
print "<CENTER>You are from $addr,$city,$state $zipcode</CENTER>";
print "<BR />";
print "<CENTER><B><h1>Latest Quotes for your favourite Stock</h1></B></CENTER>";
print "<table align='center' width=\"650\" border=\"2\">";

    @stocksarr=($stck1,$stck2,$stck3);
    print "<tr><td><b>Symbol</b></td><td><b>Price</b></td><td><b>Open</b></td><td><b>Bid</b></td><td><b>Ask</b></td><td><b>Trend Chart</b></td></tr>";
    foreach $stock (@stocksarr)
   {
    $data=requested_data($stock); 
    $data=~/(<img src=\"http:\/\/chart.finance.yahoo.com\/t[^>]+>)/g;
    $Img=$1;

    $data=~s/<[^>]+>//g;

    $data=~/Open:(\d*\.?\d+|n\/a)/;
    $Open=$1;

    $data=~/Ask:(\d*\.?\d+|n\/a)/;
    $Ask=$1;

    $data=~/Bid:(\d*\.?\d+|n\/a)/;
    $Bid=$1;

    $data=~/Last Trade:(\d*\.?\d+|n\/a)/;
    $Price=$1;

    print "<tr><td>$stock</td><td>$Price</td><td>$Open</td><td>$Bid</td><td>$Ask</td><td>$Img</td></tr>";
    }
    print "</table>";
    print "<br>";
    print "<br>";
    print "<a href=\"../homework6.html\">Click here to exit</a>";
    print "<noscript></body></html>";
    exit;
}


sub wrongpwd
{
print "<html><body>";
print "<B>You have entered a wrong password. Please try again<B>";
print "<br>";
print "<a href=\"../loginpage.html\"> Go Back To Login Page</a>";
print "<noscript></body></html>";
exit;
}


sub accessdenied
{
print "<html><body>";
print "<b>You have not entered the correct username and password.Acess is denied.<b>";
print "<br>";
print "<a href=\"../loginpage.html\"> Go Back To Login Page</a>";
print "<noscript></body></html>";
exit;
}
