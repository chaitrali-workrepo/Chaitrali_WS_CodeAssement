package com.lunatech.webapp;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class BigDataAnalyticServlet
 */
@WebServlet("/BigDataAnalyticServlet")
public class BigDataAnalyticServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BigDataAnalyticServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String inputStartDate=request.getParameter("startDate"); 
		String inputEndDate=request.getParameter("endDate");
		request.getSession().setAttribute("startDate", inputStartDate);
		request.getSession().setAttribute("endDate", inputEndDate);
		String userId=request.getParameter("userId");
		LunatechDBConnectService dbConnectInstance= new LunatechDBConnectService(inputStartDate, inputEndDate);
		dbConnectInstance.insertDataInDB( inputStartDate, inputEndDate , userId);
		response.sendRedirect("resultJSON.jsp");
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
