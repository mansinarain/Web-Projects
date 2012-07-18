#!/usr/bin/perl
##
## Validate.pl is to validate the form input data.
##

use CGI qw/:standard/;

$firstname = param(FIRSTNAME);
$middleinit = param(MIDDLEINIT);
$lastname = param(LASTNAME);
$addr = param(ADDR);
$city = param(CITY);
$state = param(STATE);
$zipcode = param(ZIPCODE);
$loginnm = param(LOGINNM);
$loginpwd = param(LOGINPWD);
$loginconfpwd = param(LOGINCONFPWD);
$stock1 = param(STOCK1);
$stock2 = param(STOCK2);
$stock3 = param(STOCK3);
$flagvalueset = 1;

print header;
print "<html><body>";
print "<BASEFONT FACE =\"ARIAL,SANS-SERIF\" SIZE=3>";

# Checking if any field is empty

if ( ($firstname eq '') ||  ($lastname eq '') || ($addr eq '') || ($city eq '') ||($zipcode eq '') || ($state eq '') || ($zipcode eq '') || ($loginnm eq '') ||  ($loginpwd eq '') || ($loginconfpwd eq '') || ($stock1 eq '') || ($stock2 eq '') || ($stock3 eq '') )  
{
#print "<FONT COLOR=RED SIZE=+2>";
#print "You have not entered a value for one of your fields</FONT><BR>";
#print "Please Click Back, enter a valid value and resubmit. <BR>";
#print "Thank You ";
}

else {
       # Checking if zipcode is 5 digits.
       if ( $zipcode =~ /^[1-9][0-9]{4}$/x)
         {
             if ( ($stock1 =~ /^[a-zA-Z]{1,4}$/x) && ($stock2 =~ /^[a-zA-Z]{1,4}$/x) && ($stock3 =~ /^[a-zA-Z]{1,4}$/x) )  
               {
                     # Checking if password and confirmation password are the same .
	
		     if ( $loginpwd eq $loginconfpwd )	
			{

			
                              open(FILE, "../htdocs/data.txt") || die "The database cannot be accessed";

                               while (<FILE>)
                                {
                                  @data = split(/\n/);
                                  foreach $dataentry (@data)
                                   {
                                      ($fname1,$mname1,$lname1,$addr1,$city1,$state1,$zipcode1,$loginname,$pwd,$confpwd1,$stck11,$stck12,$stck13) = split( /,/, $dataentry);

                                     if($loginnm eq $loginname)
					{
				             $flagvalueset = 0;		
						last;
					}
                                    }
				}

				     if ($flagvalueset == 0)	
                                     {
                                             print "<FONT COLOR=RED SIZE=+2>";
                                             print "Login name already exists. Sorry</FONT><BR>";
                                             print "Please Click Back, enter a valid value and resubmit. <BR>";
                                             print "Thank You ";
                                     }
				     else 	
                                     {
                       $usrInputData=$firstname.",".$middleinit.",".$lastname.",".$addr.",".$city.",".$state.",".$zipcode.",".$loginnm.",".$loginpwd.",".$loginconfpwd.",".$stock1.",".$stock2.",".$stock3;

                                          open (FILE, ">>", "../htdocs/data.txt") || die "Cannot open data file for write!!";
                                          print FILE $usrInputData;
                                          print FILE "\n";
                                          print "<FONT COLOR=RED SIZE=+2>";
                                          print "You have been Successfully registered in the system $firstname</FONT><BR>";
                                          print "Thank You ";
						print "<br>";
						print "<a href=\"../homework6.html\"> Go Back To Login Page</a>";

                                     }

                                  close(FILE);
				print "<noscript></body></html>";

			}
		     else	
			{
				#print "Password and confirmation password are different!!!!!!!";
			}
               }
             else
               {
	          #  print "<FONT COLOR=RED SIZE=+2>";
                  #  print "You have not entered an valid stock code</FONT><BR>";
                  #  print "Please Click Back, enter a valid value and resubmit. <BR>";
                  #  print "Thank You ";
               }
         }
       else
        {
#	print "<FONT COLOR=RED SIZE=+2>";
#	print "You have not entered an valid zipcode</FONT><BR>";
#	print "Please Click Back, enter a valid value and resubmit. <BR>";
#	print "Thank You ";
        }
     }  
