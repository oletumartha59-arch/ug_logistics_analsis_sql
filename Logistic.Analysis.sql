Create Database Logistic_db;
Use Logistic_db;

-- Retrive the the customer_names and email that their payment_status is not paid and their amount. NOTE: on the on statement, both common relationship which is c_id /*
select customer.c_name, customer.c_email_id, payment_details.payment_status, payment_details.amount
from customer
left join payment_details
on customer.c_id = payment_details.c_id
where payment_details.payment_status = "not paid";

-- retrive the customer name, email, contact and their shipping domain /*
select customer.C_Name, customer.C_Email_ID,customer.C_Cont_No, shipment_details.Sh_Domain
from customer
join shipment_details
on customer.c_id = shipment_details.c_id
order by customer.c_name asc;

-- Retrive the current status & delivery date of the e_designation "deelivery boy" /*
select status.current_status,  status.delivery_date, employee_details.e_designation
from status
join employee_manages_shipment
on status.sh_id = employee_manages_shipment.status_sh_id
join employee_details
on employee_details.e_id = employee_manages_shipment.employee_e_id
where employee_details.e_designation = "delivery boy";

-- Find the membership start and end dates for customers whose 'Current Status' is 'Not Delivered' /*
select membership.start_date, membership.end_date
from membership
join customer
on membership.m_id =customer.m_id
join shipment_details
on shipment_details.c_id = customer.c_id
join status
on status.sh_id = shipment_details.sh_id
where status.current_status = 'not delivered';


-- Display customer name, shipment ID, payment amount, payment status, and payment mode for all shipments that have been paid. /*
select customer.c_name, shipment_details.sh_id, payment_details.amount, payment_details.payment_status, payment_details.payment_mode
from customer
join shipment_details
on customer.c_id = shipment_details.c_id
join payment_details
on payment_details.sh_id = shipment_details.sh_id
where payment_details.payment_status ='paid';

-- Display employee name, designation, shipment ID, and current shipment status for all shipments managed by employees. /*
Select Employee_details.e_name, employee_details.e_designation, shipment_details.sh_id, Status.current_status
from Employee_details
join Employee_manages_shipment
on Employee_details.E_id = Employee_manages_shipment.Employee_E_id
join Shipment_details
on Shipment_details.sh_id = Employee_manages_shipment.shipment_sh_id
join Status
on Status.sh_id = Employee_manages_shipment.status_sh_id;

-- Show employee name, branch, shipment ID, and shipment content for shipments handled by employees in a specific branch (e.g., 'Lagos Branch'). /*
Select Employee_details.e_name, employee_details.e_branch, shipment_details.sh_id, Shipment_details.Sh_content
from Employee_details
join Employee_manages_shipment
on Employee_details.E_id = Employee_manages_shipment.Employee_E_id
join Shipment_details
on Shipment_details.sh_id = Employee_manages_shipment.shipment_sh_id 
where employee_details.e_branch = 'NY';

-- Retrieve customer name, shipment ID, shipment weight, shipment charges, and payment amount for shipments where shipment charges are greater than 1,300. /*
Select customer.c_name, Shipment_details.sh_id, shipment_details.sh_weight, shipment_details.sh_charges, payment_details.Amount
from customer
join shipment_details
on customer.c_id = shipment_details.c_id
join payment_details
on payment_details.sh_id = shipment_details.sh_id
where shipment_details.sh_charges > 1300;

-- Retrieve the customer name, email, shipment ID, shipment content, shipment weight, and shipment charges for all shipments./*
Select customer.c_name, customer.c_email_id, Shipment_details.sh_id, Shipment_details.sh_content, shipment_details.sh_weight, shipment_details.sh_charges
from customer
join shipment_details
on customer.c_id = shipment_details.c_id;

-- Create a comprehensive report showing: Customer Name, Shipment ID, Shipment Content, Shipment Charges, Payment Status, Current Shipment Status, and Employee Handling the Shipment. /*
SELECT CUSTOMER.C_NAME, SHIPMENT_DETAILS.SH_ID,SHIPMENT_DETAILS.SH_CONTENT, SHIPMENT_DETAILS.SH_CHARGES, PAYMENT_DETAILS.PAYMENT_STATUS, STATUS.CURRENT_STATUS, EMPLOYEE_DETAILS.E_NAME
FROM CUSTOMER
JOIN SHIPMENT_DETAILS
ON CUSTOMER.C_ID = SHIPMENT_DETAILS.C_ID
JOIN EMPLOYEE_MANAGES_SHIPMENT
ON EMPLOYEE_MANAGES_SHIPMENT.SHIPMENT_SH_ID = SHIPMENT_DETAILS.SH_ID
JOIN EMPLOYEE_DETAILS
ON EMPLOYEE_DETAILS.E_ID = EMPLOYEE_MANAGES_SHIPMENT.EMPLOYEE_E_ID
JOIN PAYMENT_DETAILS
ON PAYMENT_DETAILS.SH_ID = SHIPMENT_DETAILS.SH_ID 
JOIN STATUS
ON STATUS.SH_ID = SHIPMENT_DETAILS.SH_ID;

-- Display customer name, membership end date, shipment ID, and shipment domain for customers whose membership is expiring soon. /*
SELECT CUSTOMER.C_NAME, MEMBERSHIP.END_DATE,SHIPMENT_DETAILS.SH_ID, SHIPMENT_DETAILS.SH_DOMAIN
FROM CUSTOMER
JOIN MEMBERSHIP
ON CUSTOMER.M_ID = MEMBERSHIP.M_ID
JOIN SHIPMENT_DETAILS
ON SHIPMENT_DETAILS.C_ID = CUSTOMER.C_ID
WHERE str_to_date(MEMBERSHIP.END_DATE, '%Y-%m-%d')
between curdate()AND date_add(curdate(), INTERVAL 90 day);

SELECT CUSTOMER.C_NAME, MEMBERSHIP.END_DATE,SHIPMENT_DETAILS.SH_ID, SHIPMENT_DETAILS.SH_DOMAIN
FROM CUSTOMER
JOIN MEMBERSHIP
ON CUSTOMER.M_ID = MEMBERSHIP.M_ID
JOIN SHIPMENT_DETAILS
ON SHIPMENT_DETAILS.C_ID = CUSTOMER.C_ID
WHERE str_to_date(MEMBERSHIP.END_DATE, '%Y-%m-%d')
between curdate()AND date_add(curdate(), INTERVAL 10 month);

-- Those that have expire before the current present date /*
SELECT CUSTOMER.C_NAME, MEMBERSHIP.END_DATE,SHIPMENT_DETAILS.SH_ID, SHIPMENT_DETAILS.SH_DOMAIN
FROM CUSTOMER
JOIN MEMBERSHIP
ON CUSTOMER.M_ID = MEMBERSHIP.M_ID
JOIN SHIPMENT_DETAILS
ON SHIPMENT_DETAILS.C_ID = CUSTOMER.C_ID
WHERE str_to_date(MEMBERSHIP.END_DATE, '%Y-%m-%d') < curdate(); 

select *
From customer;

select *
From employee_manages_shipment;

select *
From employee_details;

select *
From status;

select *
From shipment_details;

select *
From payment_details;

select *
From membership;

alter table membership
add column	TENURE int (4);


SELECT CUSTOMER.C_ID, MEMBERSHIP.M_ID,
TIMESTAMPDIFF (YEAR, MEMBERSHIP.START_DATE, MEMBERSHIP.END_DATE) AS  TENURE
FROM CUSTOMER
JOIN MEMBERSHIP ON CUSTOMER.M_ID = MEMBERSHIP.M_ID
WHERE timestampdiff(YEAR, MEMBERSHIP.START_DATE, MEMBERSHIP.END_DATE) >  10;

 
-- Descriptive Statistic sql statement /*
SELECT COUNT(*) AS TOTAL_TRANSACTIONS,
ROUND(AVG(AMOUNT), 2) AS MEAN_AMOUNT,
ROUND(STDDEV(AMOUNT), 2) AS STD_DEVIATION,
ROUND(VARIANCE(AMOUNT), 2) AS VARIANCE,
MIN(AMOUNT) AS MIN_AMOUNT,
MAX(AMOUNT) AS MAX_AMOUNT,
MAX(AMOUNT) - MIN(AMOUNT) AS RANGE_AMOUNT
FROM PAYMENT_DETAILS;

SELECT *
FROM payment_details
WHERE AMOUNT = (SELECT MAX(AMOUNT) FROM payment_details);

-- Display customer name and number of shipments. /*
SELECT c.C_ID, c.C_NAME, COUNT(distinct s.SH_ID) AS TOTAL_SHIPMENTS
FROM customer c
JOIN shipment_details s
ON c.C_ID = s.C_ID
GROUP BY c.C_ID, c.C_NAME
ORDER BY c.C_NAME ASC;

SELECT SH_ID, SH_CHARGES,
RANK() OVER (ORDER BY SH_CHARGES DESC) AS Charge_Rank
FROM shipment_details;

SELECT *
FROM (
    SELECT SH_ID, SH_CHARGES,
    RANK() OVER (ORDER BY SH_CHARGES DESC) AS rnk
    FROM shipment_details
) t
WHERE rnk <= 3;

SELECT C_ID, Payment_Date, AMOUNT,
SUM(AMOUNT) OVER (PARTITION BY C_ID ORDER BY Payment_Date) AS Running_Total
FROM payment_details;

SELECT E_NAME, Shipment_Count,
RANK() OVER (ORDER BY Shipment_Count DESC) AS Employee_Rank
FROM (
    SELECT e.E_NAME, COUNT(Employee_manages_shipment.Shipment_Sh_ID) AS Shipment_Count
    FROM Employee_details e
    JOIN Employee_manages_shipment 
    ON e.E_ID = Employee_manages_shipment.Employee_E_ID
    GROUP BY e.E_NAME
    order by Shipment_Count desc
    limit 5
) t;

SELECT 
AVG(DATEDIFF(Delivery_date, Sent_date)) AS Avg_Delivery_Days
FROM Status
WHERE Delivery_date IS NOT NULL;

SELECT SH_ID,
DATEDIFF(Delivery_date, Sent_date) AS Delivery_Days
FROM Status
WHERE DATEDIFF(Delivery_date, Sent_date) > 7;

SELECT Payment_Mode,
SUM(AMOUNT) AS Total_Revenue
FROM payment_details
GROUP BY Payment_Mode
ORDER BY Total_Revenue DESC;

-- ON SAFE MODE /*
SET SQL_SAFE_UPDATES = 1;

-- OFF SAFE MODE /*
SET SQL_SAFE_UPDATES = 0;	

-- Changing the date formate from 'm/d/Y' to 'Y-m-d' in the Sent_date cloumn in Status Table /*
UPDATE STATUS	
		SET SENT_DATE = CASE
        WHEN SENT_DATE LIKE '%/%'THEN DATE_FORMAT(STR_TO_DATE(SENT_DATE,'%m/%d/%Y'), '%Y-%m-%d')
        WHEN SENT_DATE LIKE '%-%'THEN DATE_FORMAT(STR_TO_DATE(SENT_DATE,'%m-%d-%Y'), '%Y-%m-%d')
        ELSE NULL
        END;
 
 -- Changing the date formate from 'm/d/Y' to 'Y-m-d' in the delivery_date cloumn in Status Table /*
  UPDATE STATUS	
		SET DELIVERY_DATE = CASE
        WHEN DELIVERY_DATE LIKE '%/%'THEN DATE_FORMAT(STR_TO_DATE(DELIVERY_DATE,'%m/%d/%Y'), '%Y-%m-%d')
        WHEN DELIVERY_DATE LIKE '%-%'THEN DATE_FORMAT(STR_TO_DATE(DELIVERY_DATE,'%m-%d-%Y'), '%Y-%m-%d')
        ELSE NULL
        END;      
        
 -- input date into delivery date 2026-03-13 where it saying Null in sh_id 722 ( 634,870,261,982) /* 
 update status
 set delivery_date ='2026-03-13'
 where sh_id =722;
 
 -- droping a delivery_date in status  482 /*
update status
set delivery_date = null
where sh_id = 482; 
 
drop table status;

-- Grt the Age of Each customer using Status(Sent_date)
Alter table Status
Add Column Age int(4);

-- to know the Age of the Customer in Years /*
update Status
set Age = timestampdiff(Year, Sent_date, curdate())
where Age is null;
 
 -- to know the Age of the Customer in Months /*
 update Status
set Age = timestampdiff(Month, Sent_date, curdate());
 
 -- changing the column name to sg_charges_amount  with int /*
 Alter table shipment_details
 change column Sh_charges Sh_Charges_Amount int (10);
 
 -- changing the column name to sg_charges_amount  with decimal /*
 Alter table shipment_details
 change column Sh_charges Sh_Charges_Amount decimal(10,3);
 
 -- The total amount made from Sh_charges_amount /*
 select sum(sh_charges_amount) as total_Shipment_Charges
 from Shipment_details;
 
 -- The Total sh_charges_Amount made from each domain /*
 select sh_domain, sum(Sh_charges_amount) as Total_Domain_Charges
 from shipment_details
 group by sh_domain
 order by Total_Domain_Charges DESC;
 
 -- The Total sh_charges_Amount made from each domain and ser_types /*
 select sh_domain, ser_type, sum(Sh_charges_amount) as Total_Domain_set_type_Charges
 from shipment_details
 group by sh_domain, ser_type
 order by Total_Domain_Charges DESC;
 
 -- the highest amount pade for shipment_charges /*
 select sh_domain, ser_type, max(Sh_charges_amount) as Total_Domain_set_type_Charges
 from shipment_details
 group by sh_domain, ser_type;
 
 -- the Least amount pade for shipment_charges /*
 select sh_domain, ser_type, min(Sh_charges_amount) as Total_Domain_set_type_Charges
 from shipment_details
 group by sh_domain, ser_type;
 
 -- the Average amount pade for shipment_charges /*
 select sh_domain, ser_type, Avg(Sh_charges_amount) as Total_Domain_set_type_Charges
 from shipment_details
 group by sh_domain, ser_type
 order by Total_Domain_set_type_Charges;
 
update Shipment_details
set ser_type = upper(ser_type);

-- the total sh_charges_amount made by each e_designation 
select e_designation, sum(sh_charges_amount) as total_designation_charges
from shipment_details
join employee_manages_shipment
on employee_manages_shipment.shipment_sh_id = shipment_details.sh_id
join employee_details
on employee_manages_shipment.employee_e_id = employee_details.e_id
group by employee_details.e_designation
order by total_designation_charges desc
limit 5 ;

select customer.c_name, customer.c_type, payment_details.payment_status, payment_details.payment_date
from customer 
full join payment_details
on customer.c_id = payment_details.c_id
where payment_details.payment_status = 'PAID';


update Shipment_details
set ser_type = lower(ser_type);