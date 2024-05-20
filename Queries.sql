#1
select count(*) as good_prospect from prospects where credit_score>620


#2
select count(*) as leads from prospects where staff_id=' '



#3
SELECT
	CONCAT(s.First_Name, ' ', s.Last_Name) AS Staff_Name, COALESCE(t.count, 0) AS assigned_prospects
FROM
	staff s
LEFT JOIN (
	SELECT
		CASE
			WHEN p.Staff_ID = ' ' THEN 'To be Assigned'
			ELSE p.Staff_ID
		END AS id,
		COUNT(*) AS count
	FROM
		prospects p
	GROUP BY
		1
) t ON t.id = s.Staff_ID
ORDER BY
	assigned_prospects desc





#4
SELECT
    CONCAT(s.First_Name, ' ', s.Last_Name) AS Staff_Name,
    COUNT(c.Prospect_ID) AS Customer_Count
FROM
    staff s
LEFT JOIN
    customer c ON s.Staff_ID = c.Staff_ID
GROUP BY
    Staff_Name
order by customer_count desc
limit 3



#5
SELECT
    CASE WHEN Stock_Number REGEXP '[a-zA-Z]' THEN 'Traded In' ELSE 'Regular Retail' END AS Stock_Category,
    COUNT(*) AS Count
FROM car_inventory
GROUP BY Stock_Category;





#6
SELECT
    Make, COUNT(*) AS Total_Sold
FROM
    car_inventory
GROUP BY
    Make ORDER BY Total_Sold DESC
LIMIT 1;

	
	
#7
SELECT
    (COUNT(*) / (SELECT COUNT(*) FROM car_inventory)) * 100 AS Percentage_In_Body_Shop,AVG(cs.Repair_Cost) AS Average_Repair_Cost
FROM
    car_inventory ci
JOIN
    (SELECT DISTINCT Stock_Number, Repair_Cost FROM bodyshop) cs
ON
    ci.Stock_Number = cs.Stock_Number
WHERE
    ci.Location = 'Body Shop';



#8
SELECT
    CONCAT(s.First_Name, ' ', s.Last_Name) AS Staff_Name, COUNT(ci.Stock_Number) AS No_of_Cars_Sold, COUNT(ci.Stock_Number) * 350 AS Commission
FROM
    car_inventory AS ci
JOIN
    customer AS c ON ci.Stock_Number = c.Stock_No
JOIN
    staff AS s ON s.Staff_ID = c.Staff_ID
GROUP BY
    s.First_Name;
	
	
	
	
#9
SELECT
    CASE WHEN Location='' THEN 'TBD' else location end as Location, COUNT(*) AS Total_Cars, (COUNT(*) / (SELECT COUNT(*) FROM car_inventory)) * 10 AS Percentage
FROM
    car_inventory
GROUP BY
    Location
order by location;

#10
SELECT
    (COUNT(DISTINCT c.Prospect_ID) / (SELECT COUNT(DISTINCT Prospect_ID) FROM prospects)) * 100 AS Conversion_Percentage
FROM
    customer c;

