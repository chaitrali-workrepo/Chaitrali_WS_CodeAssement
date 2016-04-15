package com.lunatech.webapp;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
//STEP 1. Import required packages
import java.sql.*;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
public class LunatechDBConnectService {

	String startDate,endDate;
	public LunatechDBConnectService(String inputStartDate,String inputEndDate)
	{
	 
	this.startDate=inputStartDate;
	this.endDate=inputEndDate;
	
	 
	}
	   // JDBC driver name and database URL
	   static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	   static final String DB_URL = "jdbc:mysql://localhost:3307/testdb";

	   //  Database credentials
	   static final String USER = "root";
	   static final String PASS = "root";
	   
	   public  ArrayList<Events> readFromJsonFile(String fileName, String month, String dayOfMonth){
		    ArrayList<Events> result = new ArrayList<Events>();

		    
		    	JSONParser parser = new JSONParser();

		        try {
		        	/*String part1OfJSON=  "http://data.githubarchive.org/2015-";
		        	String part2OfJSON= String.valueOf(month);
		        	String part3OfJSON= String.valueOf(dayOfMonth);*/
		        	
		        	
		            //JSONArray arr = (JSONArray) parser.parse(new FileReader(part1OfJSON+part2OfJSON+"-"+part3OfJSON+".json"));
		        	JSONArray arr = (JSONArray) parser.parse(new FileReader("http://data.githubarchive.org/2015-01-01-15.json.gz"));
		        

		        for(Object i : arr){
		        	 JSONObject eventsObj = (JSONObject) i;
		            String eventId = (String) eventsObj.get(new String("id"));
		            String eventType = (String) eventsObj.get(new String("type"));
		           
		                result.add(new Events(eventId,eventType));
		           
		        }           
		    }
		    catch(Exception ex){
		        System.out.println(ex.toString());
		    }
		    return result;
		}
	   
	   public void insertDataInDB(String startDate ,String endDate, String userId) {
	   Connection conn = null;
	   Statement stmt = null;
	   try{
	      //STEP 2: Register JDBC driver
	      Class.forName("com.mysql.jdbc.Driver");
	      PreparedStatement pstmt = null;
	      //STEP 3: Open a connection
	      System.out.println("Connecting to database...");
	      conn = DriverManager.getConnection(DB_URL,USER,PASS);

	      //STEP 4: Execute a query
	      
	      String query = "INSERT INTO EVENTS_USER_LOG(STARTDATE,ENDDATE,USERID) VALUES( ?, ?, ?)";
	      
	      pstmt = conn.prepareStatement(query); // create a statement
	     
	      pstmt.setString(1, startDate); // set input parameter 2
	      pstmt.setString(2, endDate); // set input parameter 3
	      pstmt.setString(3, userId); // set input parameter 4
	      pstmt.executeUpdate(); // execute insert statement
	      
	      	System.out.println("INSERT COMPLETE");      
	      //STEP 5.1 : Once you persist the data fetch it to be displayed on screen for the user.
	      //fetchDataFromDB();
	      //STEP 6: Clean-up environment
	      
	      pstmt.close();
	      conn.close();
	   }catch(SQLException se){
	      //Handle errors for JDBC
	      se.printStackTrace();
	   }catch(Exception e){
	      //Handle errors for Class.forName
	      e.printStackTrace();
	   }finally{
	      //finally block used to close resources
	      try{
	         if(stmt!=null)
	            stmt.close();
	      }catch(SQLException se2){
	      }// nothing we can do
	      try{
	         if(conn!=null)
	            conn.close();
	      }catch(SQLException se){
	         se.printStackTrace();
	      }//end finally try
	   }//end try
	   System.out.println("Goodbye!");
	   }
	   
	   private void fetchDataFromDB() {
		   Connection conn = null;
		   Statement stmt = null;
		   try{
		     

		      //STEP 4: Execute a query
		      System.out.println("Creating statement...");
		      stmt = conn.createStatement();
		      String sql;
		      sql = "SELECT Event_Id,Event_Type FROM EVENTS";
		      ResultSet rs = stmt.executeQuery(sql);

		      //STEP 5: Extract data from result set
		      while(rs.next()){
		         //Retrieve by column name
		         
		         String first = rs.getString("Event_Id");
		         String last = rs.getString("Event_Type");

		         //Display values
		         
		         System.out.print(", First: " + first);
		         System.out.println(", Last: " + last);
		      }
		      //STEP 6: Clean-up environment
		      rs.close();
		      stmt.close();
		      conn.close();
		   }catch(SQLException se){
		      //Handle errors for JDBC
		      se.printStackTrace();
		   }catch(Exception e){
		      //Handle errors for Class.forName
		      e.printStackTrace();
		   }finally{
		      //finally block used to close resources
		      try{
		         if(stmt!=null)
		            stmt.close();
		      }catch(SQLException se2){
		      }// nothing we can do
		      try{
		         if(conn!=null)
		            conn.close();
		      }catch(SQLException se){
		         se.printStackTrace();
		      }//end finally try
		   }//end try
		   
		}//end main
		
	   public void downloadZipFile() {
           String saveTo = "C:/Chaitrali_Work/JSON_FIles/";
           try {
               URL url = new URL("http://data.githubarchive.org/2015-01-01-15.json.gz");
               URLConnection conn = url.openConnection();
               InputStream in = conn.getInputStream();
               FileOutputStream out = new FileOutputStream(saveTo + "test.zip");
               byte[] b = new byte[1024];
               int count;
               while ((count = in.read(b)) >= 0) {
                   out.write(b, 0, count);
               }
               out.flush(); out.close(); in.close();                   
    
           } catch (IOException e) {
               e.printStackTrace();
           }
       }
	}//end fetchDataFromDB



