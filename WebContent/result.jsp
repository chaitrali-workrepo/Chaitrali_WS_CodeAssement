<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.zip.GZIPInputStream" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-App="myApp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.2.26/angular.min.js">
    </script>       
    <script>
    myApp=angular.module('myApp',[]);
    myApp.controller('myController',function($scope,$http){
        $http.get('data.json').success(function(response){
            $scope.myData = response;
        });
        $scope.removeName = function(row) {
            $scope.myData.splice($scope.myData.indexOf(row),1);
        }
    });
    </script>
</head>
<body ng-controller="myController">
        Search : <input type="text" value="" ng-model="search" />
        <table border=1>
            <tr ng-repeat="data in myData | filter : search">
                <td>{{data.Name}}</td>
                <td>{{data.Company}}</td>
                <td><a href="" ng-click="removeName(data)">Remove</a></td>
            </tr>
        </table>
<%

   String inputStartDate= session.getAttribute( "startDate" ).toString();
   System.out.println("ABC"+inputStartDate);
   String inputEndDate= session.getAttribute( "endDate" ).toString();
   System.out.println("ABr"+inputEndDate);
    String INPUT_GZIP_FILE = "C:/Chaitrali_Work/JSON_Files/"+inputStartDate+"-12.json.gz";
    String OUTPUT_FILE = "C:/Chaitrali_Work/JSON_Files/"+inputStartDate+"-12.json";
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
</body>
</html>