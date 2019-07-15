-- Write a procedure which will accept employee Id and prints ticket details raised by that employee. Do not show resolved tickets raised by the employee. 
-- If the employee Id does not exist raise a user defined exception as "Invalid Employee number::" <Employee Id>.

-- Raise report in following format:
-- Ticket ID | Employee ID | Function | Category | Desc | Status | Raised Date
-- Write an anonymous block to invoke the procedure

CREATE or REPLACE PROCEDURE findTicketDetails(enum IN employee_details.EmpCode%type) as
	CURSOR ticketCur is SELECT  t.TicketCode, t.EmpCode, t.Functions, t.Category, t.Description, t.Status, t.RaisedDate FROM Ticket_details t, Employee_Details e 
	WHERE e.EmpCode=t.EmpCode
	AND Status != 'Solved'
	AND t.EmpCode=enum;  
	ticketDetail ticketCur%ROWTYPE;
	ecode_invalid EXCEPTION;
	BEGIN
		OPEN ticketCur;
			FETCH ticketCur INTO ticketDetail;
				IF ticketCur%NOTFOUND OR enum IS NULL THEN
					RAISE ecode_invalid;
				END IF;
			DBMS_OUTPUT.PUT_LINE('Ticket Id ' || ' | ' || 'Employee Id ' || ' | ' || 'Function ' || ' | ' || 'Category ' || ' | ' || 'Status ' || ' | ' || 'Raised Date');
			WHILE ticketCur%FOUND
				LOOP
					DBMS_OUTPUT.PUT_LINE(ticketDetail.ticketCode || ' | ' || ticketDetail.empCode || ' | ' || ticketDetail.functions || ' | ' || ticketDetail.description || ' | ' || ticketDetail.status || ' | ' || ticketDetail.RaisedDate);
						FETCH ticketCur INTO ticketDetail;
				END LOOP;
		CLOSE ticketCur;
	EXCEPTION
		WHEN ecode_invalid THEN
			DBMS_OUTPUT.PUT_LINE('Employee code is invalid::' || enum);
	END findTicketDetails;
/

-- Anonymous block to execute procedure with correct employee Id
BEGIN
findTicketDetails(824184);
END;
/

-- Anonymous block to execute procedure with null employee Id
BEGIN
findTicketDetails(null);
END;
/

-- Anonymous block to execute procedure with in-correct employee Id
BEGIN
findTicketDetails(912348);
END;
/
  
-- Write a sql query to update the status of tickets raised by a particular employee to "In Progress" if current status is 'Pending'. Accept the employee Id from user
-- Assuming 824184 is existing employee in Employee_Details table.
UPDATE ticket_details SET STATUS='In Progress'
WHERE EmpCode=&enum
AND STATUS='Pending';

-- Attempting any 2 queries out of 3
-- 1. Write a sql query to display details of employees whose tickets are resolved
SELECT t.EmpCode, e.EmpName, e.ContactNumber FROM Employee_Details e, Ticket_Details t
WHERE e.EmpCode=t.EmpCode
AND t.Status='Solved';

-- 2. Write a sql query to make changes in table structure such that ticket status column can take only Pending, In Progress or Solved Values.
ALTER TABLE Ticket_Details ADD CONSTRAINT CHK_Status CHECK (STATUS IN ('Pending','In Progress','Solved'));

-- 3. Write a sql query to display details of employees who have raised tickets in current month (e.g. November 2015) which are not yet resolved.
SELECT t.EmpCode, e.EmpName, e.ContactNumber FROM Employee_Details e, Ticket_Details t
WHERE e.EmpCode=t.EmpCode
AND t.RaisedDate BETWEEN '01-Nov-2015' AND '30-Nov-2015'
AND t.Status !='Solved';

