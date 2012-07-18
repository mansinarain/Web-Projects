

                     -------------------------------------------------------
                                         READ -ME FILE
                     -------------------------------------------------------

-----------------------
  Name : Mansi Narain
  Course: CSCI571
-----------------------  
http://cs-server.usc.edu:13676/examples/servlets/homework8.html

--------------
  HOMEWORK 8
--------------

NOTE : Please place the perl files in the cgi-bin directory and the html file in the 
/Tomcat/jakarta-tomcat-4.1.27/webapps/examples/servlets/ path and place the ajax_finance.class and .java files in the 
webapps/examples/WEB-INF/classes path.
Also please place the web.xml in the WEB-INF path.


DESCRIPTION OF HOMEWORK
--------------------------

In this excercise,we were required to use Homework 6 and populate the stock values in a tabular form.
Next, the user is allowed to “select” one of the stock quotes by selecting a radio button,
and once this is done, the “Select a stock and click here to upload to Facebook” button
becomes enabled. When the button is pressed, the web application does the following:
a) authorizes the user to facebook (i.e. logs him/her in) using the application and
user credentials if the user is not already logged in to Facebook;
b) posts the text “Current stock quote for XXX is $YY.ZZ” to the user’s News Feed.


DESCRIPTION OF CODE
---------------------

In order to provide the given functionality, i used HTML/CSS/XML/Java Servlets/AJAX/Javascipt/Perl. I made 2 perl files and 1 html file and 1 java servlet file: 

homework8.html -- contains the AJAX functionality and contains the javascript code to call the AJAX and pass the query to the Java Servlet.

mashupperl.pl -- converts the query provided by  Java Servlet and xml is returned.

ajax_finance.java -calls the perl function .after xml is obtained .. converts it into json format and returns it to the javascript.

loginpageLWP.pl -- To retrieve a web page , and to show special characters.
data.txt -- to store user input data.

-------------------------------------------------------------------------------------------------------------------------------------------------------- 