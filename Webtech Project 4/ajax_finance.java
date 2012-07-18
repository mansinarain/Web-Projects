import java.io.*;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import java.net.*;
import java.text.*;
import org.jdom.*;
import org.jdom.input.*;
import java.util.*;
import java.lang.*;
import org.json.*;

public class ajax_finance extends HttpServlet 
{
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
    {
    	String searchstockval = request.getParameter("searchstockval");
    	URL  urlString = new URL("http://cs-server.usc.edu:13675/cgi-bin/mashupperl.pl?searchstockval="+searchstockval); 
    	
       	PrintWriter out = response.getWriter();
       	//BufferedReader xmlDoc = getXMLResult(urlString);
        //String jsonresult = getJSONResult(xmlDoc);
       	//out.println(jsonresult);
	try
    	{
    		int noOfStocks = 0;
    		int size = 0;
    		JSONArray jsonArray = new JSONArray();

		SAXBuilder sax = new SAXBuilder();  //The SAXBuilder class represents the underlying XML parser.

		Document document = sax.build(urlString);
		Element root = document.getRootElement();

		List stockschildren = root.getChild("stocks").getChildren("stock");
		if(stockschildren.size()==0)
			throw new Exception("No stocks Available");
		else
			noOfStocks=stockschildren.size();

		JSONObject jsonObj ;
		Element elemstock;
		JSONObject jsonObjStock= new JSONObject();
		JSONObject jsonObjStock1= new JSONObject();


		for(int i=0;i<noOfStocks;i++)
		{
			jsonObj = new JSONObject();
			elemstock = (Element) stockschildren.get(i);
			jsonObj.put("symbol", elemstock.getAttribute("symbol").getValue());
			jsonObj.put("Price",elemstock.getAttribute("price").getValue());
			jsonObj.put("Open",elemstock.getAttribute("open").getValue());
			jsonObj.put("Bid", elemstock.getAttribute("bid").getValue());
			jsonObj.put("Ask", elemstock.getAttribute("ask").getValue());
			jsonObj.put("Chart", elemstock.getAttribute("chart").getValue());
			jsonArray.put(i, jsonObj);
		}
		
		jsonObjStock.put("stock", jsonArray);
		jsonObjStock1.put("stocks",jsonObjStock);
		out.println(jsonObjStock1.toString());

	   }
        catch (MalformedURLException e)
        {
                JSONObject errorJSON = new JSONObject();
                errorJSON.put("errormsg", " A MalformedURLException has occured");
                out.println(errorJSON.toString());
        }

	catch (IOException e)
	{
		JSONObject errorJSON = new JSONObject();
		errorJSON.put("errormsg","A IO Exception has occured");
		out.println(errorJSON.toString());
	}		
	catch (Exception e)
	{
		JSONObject errorJSON = new JSONObject();
		errorJSON.put("errormsg", "An exception has occured");
		out.println(errorJSON.toString());
	}		
    
       	out.close();
    }

}
