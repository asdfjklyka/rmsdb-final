
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetCapacity
 */
@WebServlet("/GetCapacity")
public class GetCapacity extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetCapacity() {
        super();
        // TODO Auto-generated constructor stub
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String headcount = request.getParameter("headcount");
		
		
		try{
			Connection conn = DB.getConnection();
			String query = "SELECT * FROM `rms_area` WHERE capacity >= '"+headcount+"' and area_status='Available'";			
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			
			if(rs.next() == false) {
				PrintWriter write = response.getWriter();
				write.print("<div class='fade in' style='text-align:center'>NO DATA</div>");
			} else {
				String view = " <ul id='categories' style='padding-left:15px'>";
				int count = 0;
			    do {
			    	view += "<input type='hidden' id='area-"+count+"' value='"+ rs.getString("area_id") +"'>";
			    	view += "<li class='btn btn-default col-md-3' style='width:24%; height: 48%; margin-left: 1%; margin-top: 1%'>" ;
						view += "<div style='background-color: #98fb98'>"+rs.getString("area_name")+"</div>";
					    view += "<h6 style=''>"+rs.getString("area_desc")+"</h6>";
					    view += "<div class='col-md-12'><button class='btn btn-warning col-md-5' style='margin-left: 6%; margin-right: 2%'>Details</button><button class='btn btn-success col-md-5'>Reserve</button></div>";
					    view += "<div class='col-md-10' style='margin-top: 2%; margin-left: 6%' data-toggle='modal' data-target='.bs-example-modal-lg-3'><button class='btn btn-primary col-md-12' onclick='setIndex("+count+")'>Place Customer</button></div>";
				    view += "</li>";
				    count++;
			    } while (rs.next());
			    view += "</ul>";
			    
			    PrintWriter write = response.getWriter();
				write.print(view);
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch blockPrintWriter write = response.getWriter();
			PrintWriter write = response.getWriter();
			write.print("<div class='fade in' style='text-align:center'>NO DATA</div>");
			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
