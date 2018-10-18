import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class addInventory
 */
@WebServlet("/AddOrders")
public class AddOrders extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddOrders() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		response.setContentType("text/plain");
        String order_number = request.getParameter("order_number"); 
        String subtotal = request.getParameter("total_cost");
        String currency = request.getParameter("currency");
        String customer_id = request.getParameter("customer_id");

        
		Connection conn = DB.getConnection();
		
		Statement stmnt = null;
		try {
			stmnt = conn.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		try {
			String sql = "insert into rms_orders(order_number, currency, customer_id, subtotal)"
					+ "values('"+order_number+"', '"+currency+"', '"+customer_id+"', '"+subtotal+"')";
			
			stmnt.execute(sql);
			
			// get the id of the created order
			ResultSet rs = stmnt.executeQuery("select order_id from rms_orders where status = 'Unpaid' order by order_id desc limit 1");
			rs.next();
			String order_id = rs.getString("order_id");
			
			// set the status of area to ordered
			String sql2 = "UPDATE `rms_area` SET `Area_Status` = 'Ordered' WHERE `rms_area`.`customer_id` = '"+customer_id+"' ";
			stmnt.execute(sql2);

			
			PrintWriter out = response.getWriter();	
			out.print(order_id);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		



	}

}
