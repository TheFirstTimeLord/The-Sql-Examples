/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
Oracle
*/
select distinct (select max(months*salary) from employee), emp_id from (select (select sum(emp_id) as emp_id from
(select count(employee_id) emp_id, employee_id from employee where (months*salary) >= (select max(months*salary) from employee) group by employee_id) x) emp_id, count(employee_id), employee_id from employee where (months*salary) >= (select max(months*salary) from employee) group by employee_id) y;