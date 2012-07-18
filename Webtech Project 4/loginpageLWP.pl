#!/usr/bin/perl
use LWP;
sub  requested_data{
    my ($stock_name)=@_;
    my $url="http://finance.yahoo.com/q?s=$stock_name";
    if(eval{require LWP::Simple;}){
    }else{
    print "You need to install the Perl LWP module!<br>";
     exit;
    } 
    # Retrieve the content of an URL
    $data = LWP::Simple::get($url);
    return $data; 
}
1;
