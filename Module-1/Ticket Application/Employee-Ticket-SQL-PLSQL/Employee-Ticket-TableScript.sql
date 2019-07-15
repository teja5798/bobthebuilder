--Table Scripts

--Employee_Details
DROP TABLE Employee_Details CASCADE CONSTRAINTS;
CREATE TABLE Employee_Details(
EmpCode NUMBER(6) PRIMARY KEY,
EmpName VARCHAR2(20) NOT NULL,
ContactNumber NUMBER(10));

-- Inserting records in Employee_Details table
INSERT INTO Employee_Details VALUES(824177,'Jack Dickson',9876543256);
INSERT INTO Employee_Details VALUES(824178,'Samantha Mathew',8876593256);
INSERT INTO Employee_Details VALUES(824179,'Emma Clifton',3456781234);
INSERT INTO Employee_Details VALUES(824180,'Harry Davidson',9393943243);
INSERT INTO Employee_Details VALUES(824181,'Alex Parisha',3423543453);
INSERT INTO Employee_Details VALUES(824182,'Simone Clark',9944954543);
INSERT INTO Employee_Details VALUES(824183,'Joe Hardy',7876876867);
INSERT INTO Employee_Details VALUES(824184,'Marie Timberlake',9348484834);


--Ticket_Details
DROP TABLE Ticket_Details CASCADE CONSTRAINTS;
CREATE TABLE Ticket_Details(
TicketCode NUMBER(5) PRIMARY KEY,
EmpCode NUMBER(6) REFERENCES Employee_Details(EmpCode),
Functions VARCHAR2(25) NOT NULL,
Category VARCHAR2(30) NOT NULL,
Description VARCHAR2(100) NOT NULL,
RaisedDate DATE DEFAULT SYSDATE,
Status VARCHAR2(15));

-- Creating a sequence ticketSeq
CREATE Sequence ticketSeq START WITH 1000;

-- Inserting records in Ticket_Details table
INSERT INTO Ticket_Details VALUES(ticketSeq.NEXTVAL,824177,'IT Infrastructure Mgmt','Access Rights','Ticket raised for access rights reqd on trg machine',SYSDATE,'Pending');
INSERT INTO Ticket_Details VALUES(ticketSeq.NEXTVAL,824177,'Admin','Access Control','Ticket raised for access control for Sipcot, Chennai',SYSDATE,'In Progress');
INSERT INTO Ticket_Details VALUES(ticketSeq.NEXTVAL,824179,'IT Infrastructure Mgmt','Asset Allocation','Need allocation for a new Mac machine',SYSDATE,'Pending');
INSERT INTO Ticket_Details VALUES(ticketSeq.NEXTVAL,824179,'Travel and Transport','Bus Transport','Complaint regarding harsh driving of driver of Bus Num MH-15 CQ 5678',SYSDATE,'Solved');
INSERT INTO Ticket_Details VALUES(ticketSeq.NEXTVAL,824179,'Admin','House Keeping','Work place is not kept clean',SYSDATE,'Pending');
INSERT INTO Ticket_Details VALUES(ticketSeq.NEXTVAL,824183,'IT Infrastructure Mgmt','Printer','Ticket raised as paper gets jammed in printer',SYSDATE,'Solved');
INSERT INTO Ticket_Details VALUES(ticketSeq.NEXTVAL,824183,'Travel and Transport','International Travel','Arrange for local transport within San Diego city',SYSDATE,'Pending');
INSERT INTO Ticket_Details VALUES(ticketSeq.NEXTVAL,824184,'IT Infrastructure Mgmt','Asset Allocation','Need allocation for a new machine for new Joinee',SYSDATE,'Pending');
INSERT INTO Ticket_Details VALUES(ticketSeq.NEXTVAL,824184,'Travel and Transport','Bus Travel','Arrange for bus pass for new joinee',SYSDATE,'Pending');
INSERT INTO Ticket_Details VALUES(ticketSeq.NEXTVAL,824184,'Admin','Access Control','Ticket raised for access control for Pune HWD, as new joinee',SYSDATE,'Pending');

COMMIT;
