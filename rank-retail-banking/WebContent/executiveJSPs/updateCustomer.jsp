<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Update Customer</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<link rel="icon" type="image/png"
	href="CSS and JS/images/icons/favicon.ico" />
<link rel="stylesheet" type="text/css"
	href="CSS and JS/vendor/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="CSS and JS/fonts/font-awesome-4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" type="text/css"
	href="CSS and JS/fonts/iconic/css/material-design-iconic-font.min.css" />
<link rel="stylesheet" type="text/css" href="CSS and JS/css/util.css" />
<link rel="stylesheet" type="text/css" href="CSS and JS/css/main.css" />
<script type="text/javascript" src="CSS and JS/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="CSS and JS/js/sweetalert.min.js"></script>
<script type="text/javascript" src="CSS and JS/js/validation.js"></script>
<script>

$(document).ready(function() {
	
	
	$('#Form').keydown(function (e) {
	    if (e.keyCode == 13) {
	        e.preventDefault();
	        $("#customerId").click();
	    }
	});
	
		$("#reset1").click(function(){
			$("#id").val("");
		});
			
		
		$("#reset").click(function(){
			location.reload(true);
		});
		"use strict";
		//   [ Focus input ]
		$('.input100').each(function() {
			$(this).on('blur', function() {
				if ($(this).val().trim() != "") {
					$(this).addClass('has-val');
				} else {
					$(this).removeClass('has-val');
				}
			})
		})
		//   [ Validate ]
		
		$("#customerId").click(function(){
			if (validate($("#id")) == false) {
				showValidate($("#id"));				
			}else{
				var customerId="";
				customerId=$("#id").val();
				var action= 'updateCustomer';
				var actionType= 'fetch';
				var obj={customerId,
		            	action,
		            	actionType
		            	};
				//alert(JSON.stringify(obj));
				$.ajax({
		            url:'ExecutiveController',
		            data:obj,
		            type:'post',
		            cache:false,
		            async: false,
		            success:function(data){	
		            	if(data.hasOwnProperty("id"))
		            		{
		            	$('#id').attr('readonly', true); 
		            	$('#ssno').val(data.ssn);
		            	$('#name').val(data.name);
		            	$('#address').val(data.address);
		            	$('#dob').val(data.dob);
		            	$(".after-id").css("display", "none");
		            	$(".before-id").css("display", "block");
		            	$('#ssno').attr('readonly', true); 
		            		}else{
		            			swal({
				            		  title: "Failed",
				            		  text: "Customer ID Not found",
				            		  icon: "error",
				            		  button: "Okay",
				            		});
		            		}
		            },
		            error:function(){
		            	swal({
		            		  title: "Failed",
		            		  text: "No Response from the server! Try Again",
		            		  icon: "error",
		            		  button: "Okay",
		            		});
			            }
		         }
		    );
			}
		   
		  });
		
		var input = $('.validate-input .input100');

		$('#submitForm').click( function(e) {
			var check = true;

			for (var i = 0; i < input.length; i++) {
				if (validate(input[i]) == false) {
					showValidate(input[i]);
					check = false;
				}
			}
			
			if(check){
				var id="";
			var name = "";
			var dob = "";
			var address = "";
			var action = "updateCustomer";
			var actionType="update";
			e.preventDefault();
			name = $("#name").val();
			dob = $("#dob").val();
			address = $("#address").val();
			id=$("#id").val();
			var obj={name,dob,address,actionType,action,id };		
			$.ajax({
	            url:'ExecutiveController',
	            data:obj,
	            type:'post',
	            cache:false,
	            async: false,
	            success:function(data){
	            	if(data==="success"){
	            	swal({
	            		  title: "Success",
	            		  text: "Customer Updated Successfully!",
	            		  icon: "success",
	            		  button: "Okay",
	            		}).then((value) => {
	            			window.location.reload();
	            		});	
	            	}else{
	            		swal({
		            		  title: "Failed",
		            		  text: "Customer Not Updated! Try Again",
		            		  icon: "error",
		            		  button: "Okay",
		            		});	            		
	            	}
	            },
	            error:function(){
	            	swal({
	            		  title: "Failed",
	            		  text: "No Response from the server! Try Again",
	            		  icon: "error",
	            		  button: "Okay",
	            		});
		            }
	            
	         }
	    );
			}
			return false;
		});

		$('.validate-form .input100').each(function() {
			$(this).focus(function() {
				hideValidate(this);
			});
		});

		function validate(input) {
			if ($(input).val().trim() == '')
				return false;
			switch ($(input).attr("name")) {
		    case "name":
		      return validate_name($(input).val().trim());
		    case "ssn":
		      return validate_ssno($(input).val().trim());
		    case "dob":
		      return validate_dob($(input).val().trim());
		    case "address":
		      return validate_address($(input).val().trim());
		    case "customerId":
		      return validate_customer_id($(input).val().trim());
		    case "accountId":
		      return validate_account_number($(input).val().trim());
		    case "transactionId":
		      return validate_transaction_id($(input).val().trim());
		    case "depositAmount":
		      return validate_depositAmount($(input).val().trim());
			default:
			  return;
		  }
		}

		function showValidate(input) {
			var thisAlert = $(input).parent();

			$(thisAlert).addClass('alert-validate');
		}

		function hideValidate(input) {
			var thisAlert = $(input).parent();

			$(thisAlert).removeClass('alert-validate');
		}

		function Validate() {
			var thisAlert = this.parent();

			$(thisAlert).addClass('alert-validate');
		}
	});
</script>
</head>
<body>
	<%@ include file="../executiveHeader.jsp"%>
	<div class="container-login100"
		style="background-image: url('CSS and JS/images/other.jpg'); background-repeat: no-repeat; background-size: cover;">
		<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
			<span class="login100-form-title"
				style="font-size: 30px; color: crimson;">Update Customer</span><br />
			<form autocomplete="off" class="login100-form validate-form "
				id="Form">
				<div class="wrap-input100 validate-input m-b-23"
					data-validate="Enter a Valid Customer Id">
					<span class="label-input100">Customer ID</span> <input
						autocomplete="off" class="input100 form-control" type="text"
						id="id" maxLength="9" name="customerId"
						placeholder="Enter the ID..." /> <span class="focus-input100"></span>
				</div>
			</form>
			<div class="col-md-12 text-center after-id">
				<button type="reset" class="btn btn-primary active" id="reset1">Reset</button>
				&ensp;
				<button class="btn btn-primary active" id="customerId">Find
					Customer</button>
			</div>


			<form autocomplete="off" class="login100-form validate-form "
				id="customerForm">
				<div style="display: none;"
					class="wrap-input100 validate-input m-b-23 before-id"
					data-validate="Enter a Valid Name">
					<span class="label-input100">Name</span> <input
						class="input100 form-control" type="text" id="name" name="name"
						placeholder="Enter the name..." /> <span class="focus-input100"></span>
				</div>

				<div style="display: none;"
					class="wrap-input100 validate-input m-b-23 before-id"
					data-validate="Enter a Valid SSN">
					<span class="label-input100" id="ssn">Social Security Number</span>
					<input class="input100 form-inline form-control" type="text"
						id="ssno" name="ssn" maxLength="9" placeholder="Enter the ssn..." />
					<span class="focus-input100"></span>
				</div>
				<div style="display: none;"
					class="wrap-input100 validate-input m-b-23 before-id"
					data-validate="Enter a Valid DOB">
					<span class="label-input100 ">Date of Birth</span> <input
						class="input100 form-control" type="date" id="dob" name="dob" />
					<span class="focus-input100"></span>
				</div>

				<div style="display: none;"
					class="wrap-input100 validate-input m-b-23 before-id"
					data-validate="Enter a Valid Address">
					<span class="label-input100">Address</span> <input
						class="input100 form-control" type="text"
						placeholder="Enter the address..." id="address" name="address" />
					<span class="focus-input100"></span>
				</div>
				<div style="display: none;" class="col-md-12 text-center before-id">
					<input type="reset" class="btn btn-primary active" id="reset"
						value="Cancel"> &ensp;
					<button class="btn btn-primary active" id="submitForm">Update</button>
				</div>

			</form>
		</div>
	</div>

	<%@ include file="../footer.jsp"%>
	<script type="text/javascript"
		src="../CSS and JS/js/jquery-3.5.1.min.js"></script>
	<script type="text/javascript" src="../CSS and JS/js/validation.js"></script>
</body>
</html>