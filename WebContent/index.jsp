<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.zip.GZIPInputStream" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
    String INPUT_GZIP_FILE = "C:/Chaitrali_Work/JSON_Files/2015-01-01-12.json.gz";
    String OUTPUT_FILE = "C:/Chaitrali_Work/JSON_Files/2015-01-01-12.json";
    byte[] buffer = new byte[1024];
 
     try{
    	 GZIPInputStream gzis = 
    		new GZIPInputStream(new FileInputStream(INPUT_GZIP_FILE));
 
    	 FileOutputStream outFile = 
            new FileOutputStream(OUTPUT_FILE);
 
        int len;
        while ((len = gzis.read(buffer)) > 0) {
        	outFile.write(buffer, 0, len);
        }
 
        gzis.close();
    	outFile.close();
 
    	System.out.println("Done");
    	
    }catch(IOException ex){
       ex.printStackTrace();   
    }
   


 %>


<script type="text/javascript" language="javascript" src="C:/Chaitrali_Work/JSON_Files/jquery-1.8.2.min.js">    </script> 
<script type="text/javascript">
           $(document).ready(function(e) {

           });
alert("123");
           function jsonCallback(jsonObject){
           alert("12356");
           	   for(var i=0;i<10;i++){
               alert(jsonObject.event);
               }
           }
        </script>

 <script type="text/javascript" language="javascript" src="C:/Chaitrali_Work/JSON_Files/2015-01-01-12.json"></script> 



<h1>Hello world1</h1>
	<form name="myForm" action="BigDataAnalyticServlet" method="POST">
		<table border="0">
			<tbody>
			<tr>
				<td>Start Date:</td>
				<td><input type="text" name ="startDate" value="" size="50"/></td>
				
				
			</tr>
			<tr>
			<td>*Please enter in YYYY-MM-DD format</td>
			</tr>
			<tr>
				<td>End Date:</td>
				<td><input type="text" name ="endDate" value="" size="50"/></td>
				
			</tr>
			<tr>
			<td>*Please enter in YYYY-MM-DD format</td>
			</tr>
			<tr>
				<td>User Id:</td>
				<td><input type="text" name ="userId" value="" size="50"/></td>
			</tr>
			</tbody>
		</table>
		<input type="reset" name="Clear" value="clear">
		<input type="submit" name="Submit" value="submit">
	</form>
</body>
</html>