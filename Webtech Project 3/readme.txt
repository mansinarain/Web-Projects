

                     -------------------------------------------------------
                                         READ -ME FILE
                     -------------------------------------------------------

-----------------------
  Name : Mansi Narain
  Course: CSCI571
-----------------------  

--------------
  HOMEWORK 6
--------------

NOTE : Please place the perl files in the cgi-bin directory and the html files and data.txt in the htdocs directory

DESCRIPTION OF HOMEWORK
--------------------------

In this exercise, we are required to create a guestbook where visitors record personal
information and their favorite stocks. When a visitor returns and logs in, the system
will display their information and the latest data for the stocks they have provided.


DESCRIPTION OF CODE
---------------------

In order to provide the given functionality, i used HTML/Javascipt/Perl. I made 3 perl files and 3 html files: 

homework6.html -- contains two links labeled as follows:Establish Your Account and  Login

loginpage.html -- When a user returns to the site and clicks on the “Login” link, the program will prompt for the login name and password. 
If the information provided matches a login/password that is on file, return a page with user's stock information. 
For this i have used loginpage.pl for verification of the user information and displaying the result.

establishacc.html -- Visitors will be instructed to fill out the form and click on “Submit Your AccountInformation” button. 
Here validate.pl will be used to do all serverside validations, and for the client side i have used javascript in this file to validate user input.

validate.pl -- validates the user form data for the specifications provided.

loginpage.pl -- validates username and passwrd of the user and accordingly displays the result.

loginpageLWP.pl -- To retrieve a web page , and to show special characters.
data.txt -- to store user input data.

-------------------------------------------------------------------------------------------------------------------------------------------------------- 