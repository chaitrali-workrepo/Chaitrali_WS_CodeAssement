<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.zip.GZIPInputStream" %>  
<%@ page import="java.net.URL" %>;
<%@ page import="java.net.URLConnection" %>;
<!DOCTYPE html>
<html>
<head>
<script>
function ajax_get_json(startDate){
	var results = document.getElementById("results");
    var hr = new XMLHttpRequest();
    
    var fileName = "C:/Chaitrali_Work/workspace/Lunatech_Proj/WebContent/"+startDate+"-12.json";
    alert(fileName);
    hr.open("GET", startDate+"-12.json", true);
    alert("1");
    hr.setRequestHeader("Content-type", "application/json", true);
    
    hr.onreadystatechange = function() {
    alert("abc");
	    if(hr.readyState == 4 && hr.status == 200) {
	    //alert("inside if");
		    var data = JSON.parse(hr.responseText);
			results.innerHTML = "";
			//alert(data.type);
			//for(var obj in data){
			
				results.innerHTML += data.type+" is "+"<hr />";
				//results.innerHTML  =data.actor.;
			//}
	    }
    }
    hr.send(null);
    results.innerHTML = "requesting...";
}
</script>
</head>
<body>
<%

   String inputStartDate= session.getAttribute( "startDate" ).toString();
   
   String inputEndDate= session.getAttribute( "endDate" ).toString();
   
    //String INPUT_GZIP_FILE = "http://data.githubarchive.org/"+inputStartDate+"-12.json.gz";
   // String OUTPUT_FILE = "C:/Chaitrali_Work/workspace/Lunatech_Proj/src/com/lunatech/JSONFiles/"+inputStartDate+"-12.json";
   String OUTPUT_FILE = "C:/Chaitrali_Work/workspace/Lunatech_Proj/WebContent/"+inputStartDate+"-12.json";
   
    byte[] buffer = new byte[1024];
    
    URL url = new URL("http://data.githubarchive.org/"+inputStartDate+"-12.json.gz");
    URLConnection con = url.openConnection();
     try{
    	 GZIPInputStream gzis = 
    		new GZIPInputStream(con.getInputStream());
 
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
<div id="results"></div>

<script>ajax_get_json('<%=session.getAttribute( "startDate" ).toString()%>');</script>

</body>
</html>