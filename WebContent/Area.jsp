<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="ThemeBucket">
    <link rel="shortcut icon" href="images/ribrage.png" type="image/png">

    <title>Customer | RMS</title>

    <link rel="stylesheet" href="css/style.default.css" />

    <link rel="stylesheet" href="css/bootstrap-timepicker.min.css" />
    <link rel="stylesheet" href="css/jquery.tagsinput.css" />
    <link rel="stylesheet" href="css/colorpicker.css" />
    <link rel="stylesheet" href="css/dropzone.css" />
    <link rel="stylesheet" href="css/jquery.datatables.css" />
    <!--dynamic table-->
	<link href="js/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <!-- Custom styles for this template -->
	<style>
		body.modal-open {
		    overflow: hidden !important;
		}
	</style>
</head>

<body style="background: #040404;">

<!-- Preloader -->
<div id="preloader">
    <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
</div>

<sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/rmsdb"
                           user="root"  password=""/>
                           
  <sql:query dataSource="${db}" var="area">
            SELECT * from rms_area;
        </sql:query>


<section>

  <div class="mainpanel" style="margin:0 auto; min-height:500px">

    <div class="headerbar">

      <div class="header-right">
        <ul class="headermenu">
          <li>
            <div class="btn-group">
              <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                <img src="images/photos/loggeduser.png" alt="" />
                <%=session.getAttribute("fullname")%> 
              </button>
              
              <ul class="dropdown-menu dropdown-menu-usermenu pull-right">
                <li><a href="Logoutservlet"><i class="glyphicon glyphicon-log-out"></i> Log Out</a></li>
              </ul>
             
            </div>
          </li>
         
        </ul>
      </div><!-- header-right -->

    </div><!-- headerbar -->

    <div class="pageheader">
      <h2><i class="fa fa-list"></i>Accommodation</h2>
      <div class="breadcrumb-wrapper">
        <span class="label"></span>
        <ol class="breadcrumb">
          <li class="active">Accommodation</li>
        </ol>
      </div>
    </div>

 

 	<div class="contentpanel">
	 	<div class="col-sm-12">
	       <div class="panel panel-default">
	        <div class="panel-body" >
	       	 <!-- Panel Body starts here -->
				<section id="main-content">
	            	<section class="wrapper" style="padding-left:2%; padding-right:2%">
	                	<!-- page start-->
	                		<div class="col-md-12" style="margin-bottom: 1%"> <div class="col-lg-12">
                                Guest Count<input type="text" class="form-control" name="headcount"  id="headcount">
                                <button class="btn btn-primary pull-right" id="getCapacity" onclick="getCapacity()" type="button" style="margin-top: 2%; margin-bottom: 2%;">Search</button>
                            </div>
                            
                <div class="col-md-12" style="background-color: grey; height: 2px; margin-bottom: 2%"></div>
	                <div class="row">
		                <div class="col-md-12" id="available_area">
						    <ul id="Categories" style="padding-left:15px">
								<c:forEach var="row" items="${area.rows}">
								<input type="hidden" id="area-${count}" value="${row.area_id}">
									<c:if test="${row.area_status == 'Available'}">
										<li class="btn btn-default col-md-3" style="width:24%; height: 48%; margin-left: 1%; margin-top: 1%">
										<div style="background-color: #98fb98">${row.area_name}</div><h6 style="">${row.area_desc}</h6>
										<div class="col-md-12"><button class="btn btn-warning col-md-5" name="${row.area_name}" style="margin-left: 6%; margin-right: 2%"
										 data-toggle="modal" data-target=".bs-example-modal-lg-3">Details</button><button class="btn btn-success col-md-5">Reserve</button></div>
										<div class="col-md-12" style="margin-top: 2%; margin-left: 6%">
												<a class="btn btn-primary col-md-10" id="available-${count}" data-toggle="modal" data-target=".bs-example-modal-lg-3" onclick="setIndex(${count});"><i class="">Place Customer</i></a>					                                     	
									            <a class="btn btn-warning"  id="order-${count}" style="width:48px; display:none; margin-right: 1%" href="Category.jsp" onclick="saveToLocalStorage(${row.customer_id})"><i class="fa fa-plus"  ></i></a>
												<a class="btn btn-success " id="print-${count}" style="width:48px; display:none; margin-right: 1%" target="_blank" href="Official_receipt.jsp" onclick="saveToLocalStorage(${row.customer_id})"><i class="fa fa-eye"></i></a>
									            <a class="btn btn-default " id="billout-${count}" style="width:48px;  display:none; margin-right: 1%" target="_blank" href="javascript:;" data-toggle="modal" data-target=".bs-example-modal-lg-3-1" onclick="getOrderData(${row.customer_id})"><i class="fa fa-usd"></i></a>
									            <a class="btn btn-black " id="cancel-${count}"  style="width:48px; display:none; margin-right: 1%" onclick="cancel(${row.customer_id});"><i class="fa fa-times"></i></a>
									     </div>
										</li>
							        </c:if>  

							        <c:if test="${row.area_status == 'Unavailable'}">
							        	<li class="btn btn-default col-md-3" style="width:24%; height: 48%; margin-left: 1%; margin-top: 1%">
										<div style="background-color: #fa867e">${row.area_name}</div><h6 style="">${row.area_desc}</h6>
										<div class="col-md-12"><button class="btn btn-warning col-md-5" style="margin-left: 6%; margin-right: 2%">Details</button><button class="btn btn-success col-md-5">Reserve</button></div>
										<div class="col-md-12" style="margin-top: 2%;">
												<a class="btn btn-primary col-md-10" id="available-${count}" style=" display:none" data-toggle="modal" data-target=".bs-example-modal-lg-3" onclick="setIndex(${count});"><i class="fa fa-glass"></i></a>					                                     	
									            <a class="btn btn-warning"  id="order-${count}" style="width:48px; margin-right: 1%" href="Category.jsp" onclick="saveToLocalStorage(${row.customer_id})"><i class="fa fa-plus"  ></i></a>
												<a class="btn btn-success " id="print-${count}" style="width:48px; display:none; margin-right: 1%" target="_blank" href="Official_receipt.jsp" onclick="saveToLocalStorage(${row.customer_id})"><i class="fa fa-eye"></i></a>
									            <a class="btn btn-default " id="billout-${count}" style="width:48px; display:none; margin-right: 1%" target="_blank" href="javascript:;" data-toggle="modal" data-target=".bs-example-modal-lg-3-1" onclick="getOrderData(${row.customer_id})"><i class="fa fa-usd"></i></a>
									            <a class="btn btn-black " id="cancel-${count}"  style="width:48px; margin-right: 1%" onclick="cancel(${row.customer_id});"><i class="fa fa-times"></i></a>                         	
										</div>
										</li>
							        </c:if>

							        <c:if test="${row.area_status == 'Ordered'}">
										<li class="btn btn-default col-md-3" style="width:24%; height: 48%; margin-left: 1%; margin-top: 1%">
											<div style="background-color:  #ADD8E6">${row.area_name}</div><h6 style="">${row.area_desc}</h6>
											<div class="col-md-12"><button class="btn btn-warning col-md-5" style="margin-left: 6%; margin-right: 2%" data-toggle="modal" data-target=".bs-example-modal-lg-3">Details</button><button class="btn btn-success col-md-5">Reserve</button></div>
											<div class="col-md-12" style="margin-top: 2%;">					                                     	
										            <a class="btn btn-primary col-md-10" id="available-${count}" style=" display:none" data-toggle="modal" data-target=".bs-example-modal-lg-3" onclick="setIndex(${count});"><i class="fa fa-glass"></i></a>					                                     	
										            <a class="btn btn-warning"  id="order-${count}" style="width:48px; margin-right: 1%" href="Category.jsp" onclick="saveToLocalStorage(${row.customer_id})"><i class="fa fa-plus"  ></i></a>
													<a class="btn btn-success" id="print-${count}" style="width:48px;  margin-right: 1%" target="_blank" href="Official_receipt.jsp" onclick="saveToLocalStorage(${row.customer_id})"><i class="fa fa-eye"></i></a>
										            <a class="btn btn-default " id="billout-${count}" style="width:48px; margin-right: 1%" target="_blank" href="javascript:;" data-toggle="modal" data-target=".bs-example-modal-lg-3-1" onclick="getOrderData(${row.customer_id})"><i class="fa fa-usd"></i></a>
										            <a class="btn btn-black " id="cancel-${count}"  style="width:48px; display:none; margin-right: 1%" onclick="cancel(${row.customer_id});"><i class="fa fa-times"></i></a>
									       </div>
										</li>
									</c:if>
								  <c:set var="count" value="${count + 1 }" scope="page" />
								</c:forEach>
							</ul>	
						  </div>
					 </div>
				</div>
			</section>
		</section>
	</div>
	</div>
	</div>
	</div>
	</div>
</section>
	   			
 <form method="post" id="form-data">
        <div class="modal fade bs-example-modal-lg-3" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="margin-top: 10%">
            <div class="modal-dialog modal-lg">
                <div class="modal-content" id="sad">
                    <div class="modal-header" style="background-color: #941822">
                        <button aria-hidden="true" data-dismiss="modal" class="close fa fa-times" type="button" style="color: white"></button>
                        <h4 class="modal-title" style="color: white">Customer Details</h4>
                    </div>
                    <div class="modal-body">
                        <div class="input-group">
                            <span class="input-group-addon"><i style="height: 57%"/></i></span>
                            <input type="number" class="form-control" placeholder="Guest Count" name="guestcount" id="guestcount"/>
                        </div><br/>
                         <div class="input-group">
                            <span class="input-group-addon"><i class=""><img src="" alt=""  style="height: 57%"/></i></span>
                            <input type="text" class="form-control" placeholder="Remarks" name="remarks" id="remarks" />
                        </div><br/>
                        <div>
                            <button class="btn btn-primary pull-right" id="submit" type="button" data-dismiss="modal">Add Customer</button></div><br><br>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <form method="post" id="form-data">
        <div class="modal fade bs-example-modal-lg-3-1" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="">
            <div class="modal-dialog modal-lg">
                <div class="modal-content" id="sads">
                    <div class="modal-header" style="background-color: #941822">
                        <button aria-hidden="true" data-dismiss="modal" class="close fa fa-times" type="button" style="color: white"></button>
                        <h4 class="modal-title" style="color: white">Payment</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
	                        <table class="table table-bordered">
			                    <thead>
			                        <tr>
			                            <th>Name</th>
			                            <th>Quantity</th>
			                            <th>Amount</th>
			                        </tr>
			                    </thead>
			                    <tbody id="contents">
			                    </tbody>
              			  </table>
              			  	<div class="form-group" id="cash-tendered">
	                            <label>CASH TENDERED: </label><input type="number" class="form-control" placeholder="Enter Bill" name="payment" id="payment" /><br/>
	                            <small id="payment-has-error" style="color:red;display:none">*Payment is Less than the Grand total please double check payment amount</small>
              			  	</div>
                            <label>CHANGE: </label><input type="text" name="loose_change" id="loose_change" class="form-control" disabled>
                        </div><br/>
                        <div>
                            <button class="btn btn-primary pull-right" onclick="paid()" type="button" id="btn-pay" data-dismiss="modal">Add Payment</button></div><br><br>
                    </div>
                </div>
            </div>
        </div>
    </form>
  <script src="js/jquery-1.11.1.min.js"></script>
    <script src="js/jquery-migrate-1.2.1.min.js"></script>
    <script src="js/jquery-ui-1.10.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/modernizr.min.js"></script>
    <script src="js/jquery.sparkline.min.js"></script>
    <script src="js/toggles.min.js"></script>
    <script src="js/retina.min.js"></script>
    <script src="js/jquery.cookies.js"></script>

    <script src="js/jquery.autogrow-textarea.js"></script>
    <script src="js/bootstrap-timepicker.min.js"></script>
    <script src="js/jquery.maskedinput.min.js"></script>
    <script src="js/jquery.tagsinput.min.js"></script>
    <script src="js/jquery.mousewheel.js"></script>
    <script src="js/select2.min.js"></script>
    <script src="js/dropzone.min.js"></script>
    <script src="js/colorpicker.js"></script>

    <script src="js/custom.js"></script>
    <script src="js/select2.min.js"></script>
    <!--Validation-->
    <script src="js/jquery.validate.min.js"></script>
    <!--Tables-->
    
    <script src="js/jquery.datatables.min.js"></script>
    <script src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript"></script>
    
    
    <script>
    
			var idIndex = 0;
			var grandTotal = 0;
			var payment = 0;
			
		    function setIndex(id){
		    	idIndex = id;
		    }
		    
		    
		    function saveToLocalStorage(customer_id)
		    {
		    	localStorage.setItem("customer_id", customer_id);
		    }
 
		    
		    function getCapacity()
			{
		    	var headcount = $("#headcount").val();
				
				
				$.ajax({
					type:'GET',
					data:{
				    	headcount: headcount
					},
					url:'GetCapacity',
					
					success: function(data) {
						//console.log(data);
					    $("#available_area").html(data);
					}
				});
			}
	
	        $("#submit").click(function(){
	        	   
	        	swal({
	        		  title: "Are you sure you want to add customer?",
	        		  text: "This will make the area unavailable.",
	        		  type: "warning",
	        		  showCancelButton: true,
	        		  confirmButtonColor: '#dd6855',
	        		  confirmButtonText: 'Yes',
	        		  cancelButtonText: 'No',
	        		  closeOnConfirm: false,
	        		  closeOnCancel: false,
	        		  
	        		}, function(isConfirm){
	        			if(isConfirm){
		                    var guestcount = $("#guestcount").val();
		            		var remarks = $("#remarks").val();
		            		var area_id = $("#area-"+idIndex).val();
		            		
		            		console.log(area_id);
		
		            		if (guestcount != "") 
		            	    {
		            					$.ajax({
		            						type:'POST',
		            						data:{
		            							guestcount: guestcount,
		            							remarks: remarks,
		            							area_id: area_id
		            							},
		            						url:'AddCustomer',
		            						success: function(data){
		            							//console.log(data);
		            							
		            							$("#area-status-"+idIndex).html("Unavailable");
		            							swal("Successfully Added!","", "success");
		            							// 	alert(data2); 
		            	                    setTimeout(function() 
		            	                    {
		            	                        window.location=window.location;
		            	                    },1000);
		            						}
		            					});
		            	    }
		            		
		            		var guestcount = $("#guestcount").val("");
		             		var remarks = $("#remarks").val("");
	        			}
	        			else{
	          				swal("Cancelled", "", "error");
	          			}
	        		});
	    		
	    	});	
	        
	    	
            function cancel(customer_id)
            {
            	swal({
          		  title: "Are you sure you want to open the area?",
          		  text: "This will mark the area as available",
          		  type: "warning",
          		  showCancelButton: true,
          		  confirmButtonColor: '#dd6855',
          		  confirmButtonText: 'Yes',
          		  cancelButtonText: 'No',
          		  closeOnConfirm: false,
          		  closeOnCancel: false,
          		  
          		}, function(isConfirm){
          			if(isConfirm){
      	          	$.ajax({
	          				type:'POST',
	          				data:{
	          					customer_id: customer_id,
	          					
	          				},
	          				url:'Cancel',
	          				success: function(data){
	          					//console.log(data);
	          					swal("Area is now available!", "", "success");
    	                        setTimeout(function() 
    	                        {
    	                            window.location=window.location;
    	                        },1000);
	          				}
	          			});
          			}
          			else{
          				swal("Cancelled", "", "error");
          			}
          			
          		});
            }
	        
	        function getOrderData(customer_id){
	    		saveToLocalStorage(customer_id);
	    		$.ajax({
	    			type:'GET',
	    			data:{
	    				customer_id: customer_id
	    			},
	    			url:'GetOrderData',
	    			success: function(data) {
	    			    $("#contents").html(data);
	    			}
	    		}).then(function(){
	    			grandTotal = $("#grandTotal").text();
	    		});
	    	}
	        
	        
	        $("#payment").keyup(function() {
	        
	        	payment = parseFloat(this.value);
	        	$("#totalPayment").text( payment );
	        	if( parseFloat(this.value) >= parseFloat(grandTotal)){
	            	loose_change = Math.abs(parseFloat(grandTotal) - parseFloat(this.value));
	            	$("#loose_change").val( loose_change );
	            	$("#looseChange").text( loose_change );
	            	$("#cash-tendered").removeClass("has-error");
	            	$("#btn-pay").attr("disabled", false);
	            	$("#payment-has-error").hide();
	        	}else{
	        		$("#cash-tendered").addClass("has-error");
	        		$("#payment-has-error").show();
	        		$("#btn-pay").attr("disabled", true);
	        		loose_change = 0;
	            	$("#loose_change").val(0.00);        		        		
	            	$("#looseChange").text(0.00);        		        		
	        	}
	        });
	    
			
	        
	        function paid()
	        {
	        	if(payment >= grandTotal){
	            	swal({
	            		
	            		title: "Customer Paid.",
	            		  text: "This will mark the order as paid, and will set the area as available.",
	            		  type: "warning",
	            		  showCancelButton: true,
	            		  confirmButtonColor: '#dd6855',
	            		  confirmButtonText: 'Yes',
	            		  cancelButtonText: 'No',
	            		  closeOnConfirm: false,
	            		  closeOnCancel: false,
	          		}, function(isConfirm){
	          			if(isConfirm) {

	      	          		var customer_id = localStorage.getItem("customer_id") 
	      	          		//console.log(customer_id);
	      	          		
	      	          		
	      	          		var payment_id = 0;
	      	          		$.ajax({
	      	          				type:'POST',
	      	          				data:{
	      	          					customer_id: customer_id,
	      	          					payment: payment,
	      	          					loose_change: loose_change,
		      	          				payment_id: payment_id,
	      	          					
	      	          				},
	      	          				url:'AddPayment',
	      	          				success: function(data){
		      	      	          		window.open('Official_receipt.jsp','_blank');
		      	      	          		
		      	      	          		setTimeout(function() 
			      	                    {
			      	                       window.location=window.location;
			      	                    },1000);
		      	          		
	      	          				}
	      	          			});

	          			}
	          			
	          			else{
	          				swal("Cancelled", "", "error");
	          			}
	          			
	          		}); //end swal

	        	}//end if
	        	else{
	        		$("#cash-tendered").addClass("has-error");
	        		//swal("Payment is Less than the Grand total please double check payment amount", "", "error");
	        	}
	        }// end function
	        
	        
		

    </script>

</body>
 </html>
