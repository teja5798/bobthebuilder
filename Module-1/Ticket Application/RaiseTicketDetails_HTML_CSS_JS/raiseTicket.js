/*********************************************************************
 * File                 		: raiseTicket.js
 * Author Name    		: IGATE
 * Desc                		: External javascript file for validations.
 * Version              		: 1.0
 * Last Modified Date   : 20-Nov-2015
 * Change Description  : Description about the changes implemented
 *********************************************************************/

function populateCategories() {
	var functionIndex = frm.txtFunctionNames.selectedIndex;
	if(functionIndex==0) {
		alert("Select Proper Function to raise ticket");
	}
	switch(functionIndex) {
		case 1: document.getElementById("txtCategories").options[0]=new Option("Please select Category","");
					document.getElementById("txtCategories").options[1]=new Option("Audio/Video/Web Presentation","Audio/Video/Web Presentation");
					document.getElementById("txtCategories").options[2]=new Option("Access Rights","Access Rights");
					document.getElementById("txtCategories").options[3]=new Option("Asset Allocation","Asset Allocation");
					document.getElementById("txtCategories").options[4]=new Option("Network","Network");
					document.getElementById("txtCategories").options[5]=new Option("Printer","Printer");	
					break;
		case 2: document.getElementById("txtCategories").options[0]=new Option("Please select Category","");
					document.getElementById("txtCategories").options[1]=new Option("Access Control","Access Control");
					document.getElementById("txtCategories").options[2]=new Option("Air Conditioning","Air Conditioning");
					document.getElementById("txtCategories").options[3]=new Option("Food and Cafeteria","Food and Cafeteria");
					document.getElementById("txtCategories").options[4]=new Option("CCTV and Fire Alarm","CCTV and Fire Alarm");
					document.getElementById("txtCategories").options[5]=new Option("House Keeping","House Keeping");	
					break;
		case 3:document.getElementById("txtCategories").options[0]=new Option("Please select Category","");
					document.getElementById("txtCategories").options[1]=new Option("Bus Transport","Bus Transport");
					document.getElementById("txtCategories").options[2]=new Option("Cab Transport","Cab Transport");
					document.getElementById("txtCategories").options[3]=new Option("Domestic Travel","Domestic Travel");
					document.getElementById("txtCategories").options[4]=new Option("International Travel","International Travel");
					document.getElementById("txtCategories").options[5]=new Option("","");
					break;
	}
    	
	return true;
}
function validate() {
	var categories = frm.txtCategories.value;
	
	if(categories==""||categories==null) {
		alert("Select category!!!");
		return false;
	}
	var raisedDate = frm.txtRaisedDate.value;
	
	// getting current date object
	var currentDate = new Date();
	
	// converting ticket raised date to date object 
	var convertDate = new Date(raisedDate);
	
	// extracting year, month and date from current date object and storing in string neglecting time part
	var sysDate = currentDate.getFullYear() + "-" + (currentDate.getMonth() + 1) + "-" + currentDate.getDate();
	
	// extracting year, month and date from converted raised date object and storing in string neglecting time part
	var convertInputDate = convertDate.getFullYear() + "-" + (convertDate.getMonth() + 1) + "-" + convertDate.getDate();
		
	// checking if raised date is current date
	if(convertInputDate!=sysDate){
		alert("Ticket Raised date should be system date!!!");
		frm.txtRaisedDate.focus();
		return false;
	}
	
	// calling javascript function to generate ticket id (combination of 1st 2 digits of employee id and then using random function)
	var ticketId = generateTicketID();
	// calling javascript function to open a new pop up window and dispalying ticket details and ticketId in pop up window
	generatePopup(ticketId);
	
}

function generateTicketID() {
	var empCode = frm.txtEmpCode.value;
	// extracting 1st two numbers of employee code
	var extract = empCode.substring(0,3);
	// making use of Math random function
	var rand = Math.random() * 100; // to generate whole numbers
	// rounding up the whole number generated
	var ticketId = Math.round(extract+rand);
	return ticketId;
}

function generatePopup(ticketId) {
	// declaring a boolean varaible to be used for validity with checkboxes
	var flag = false;
	
	// checking whether check box is selected or not.
	if(document.getElementById("remember").checked){
		flag=true;
	}
	
	var newWindow = window.open('','','width=300,height=200,left=150');
	// populating ticket details along with ticketId in new window.
	newWindow.document.write("Ticket Code::" + ticketId + "<br>");
	newWindow.document.write("Employee Id::" + frm.txtEmpCode.value + "<br>");
	newWindow.document.write("Employee Name::" + frm.txtEmpName.value + "<br>");
	newWindow.document.write("Function selected::" + frm.txtFunctionNames.value + "<br>");
	newWindow.document.write("Categories::" + frm.txtCategories.value + "<br>");
	newWindow.document.write("Priority::" + frm.txtPriority.value + "<br>");
	newWindow.document.write("Description::" + frm.txtDesc.value + "<br>");
	newWindow.document.write("Ticket Rasied Date::" + frm.txtRaisedDate.value + "<br>");
	newWindow.document.write("Contact Number::" + frm.txtMobileNum.value + "<br>");
	if(flag==true) {
		newWindow.document.write("Multiple users / Systems Impacted<br>");
	}
}