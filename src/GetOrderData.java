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
 * Servlet implementation class addInventory
 */
@WebServlet("/GetOrderData")
public class GetOrderData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetOrderData() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        String customer_id = request.getParameter("customer_id"); 
		String query = "SELECT * from rms_orders inner join rms_order_items on `rms_orders`.order_id = `rms_order_items`.order_id inner join rms_customer on rms_customer.Customer_Id = rms_orders.customer_id left join rms_order_payments on rms_order_payments.customer_id = rms_customer.Customer_id where `rms_orders`.customer_id = " + customer_id;
	    
		try{
			Connection conn = DB.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			
			
			if(rs.next() == false) {
				PrintWriter write = response.getWriter();
				write.print("<div class='fade in' style='text-align:center'>NO DATA</div>");
			} else {
				
				Double grandTotal=0.00;// = rs.getDouble("total_cost");
				Double totalPayment = 0.00;
				Double looseChange =0.00;
				
				String view = "";
				
				do {
					grandTotal += rs.getDouble("total_cost");
					totalPayment = rs.getDouble("payment");
					looseChange = rs.getDouble("loose_change");
	                view += "<tr>";
	                view +=	"<td class=''>"+rs.getString("dish_name")+"</td>";
	                view += "<td class='' style='text-align:right'>"+rs.getString("quantity")+"</td>";
	                view += "<td class='' style='text-align:right'>Php "+ String.format("%.0f", rs.getDouble("total_cost")) +"</td>";
	                view += "</tr>";
			    }while (rs.next());

			    view += "<tr>";
			    		view += "<td class='text-right' colspan='2'>";
			    		view += "<p><strong></strong></p>";
			    		view += "<p><strong>Sub Total: </strong></p>";
			    		view += "</td>";
							
			    view += "<td>";
			    	view += "<p><strong></strong><p>";
			    	view += "<p><strong>Php "+String.format("%.0f", grandTotal)+"</strong><p>";
			    	view += "</td>";
			    view += "</tr>";
			    view += "<tr>";
		    	view += "<td class='text-right' colspan='2'><h3><strong>Grand Total: </strong></h3></td>";
		    	view += "<td class='text-left text-danger'><h3>PHP <span id='grandTotal'> "+String.format("%.0f", grandTotal)+" </span></h3></td>";
            view += "</tr>";
		    view += "<tr>";
	    		view += "<td class='text-right' colspan='2'><h4>Total Payment:<br/>Change:</h4></td>";
	    		view += "<td class='text-left text-danger'><h4>PHP <span id='totalPayment'> "+String.format("%.0f", totalPayment)+" </span><br/>PHP  <span id='looseChange'>"+String.format("%.0f", looseChange)+"</span></h4></td>";
	    	view += "</tr>";
	            

	            
	            String sql4 = "update `rms_customer` set `total_pay` = '"+grandTotal+"' where customer_id = '"+customer_id+"' ";
					stmt.execute(sql4);

	            
			    PrintWriter write = response.getWriter();
				write.print(view);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch blockPrintWriter write = response.getWriter();
			PrintWriter write = response.getWriter();
			write.print("<tr><td colspan='3' style='text-align:center'>NO DATA</td></tr>");

			e.printStackTrace();
		}
		

	}

	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


	}

}

