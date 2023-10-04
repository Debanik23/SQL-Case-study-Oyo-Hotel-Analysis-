create database OYO;
use OYO;
create table oyo_hotel(
booking_id integer not null,
customer_id int,
status text,
check_in text,
check_out text,
no_of_room integer,
hotel_id integer,
amount float,
discount float,
date_of_booking text
);
create table city_hotel(
Hotel_id int not null,
City char);
select * from oyo_hotel;
select * from city_hotel;

ALTER TABLE city_hotel
CHANGE `ï»¿Hotel_id` Hotel_id INT;

/* Distinct number of hotel_ids in table city__hotel*/
select count(distinct(Hotel_id)) as Total_City_Hotels from city_hotel;  /*357*/

/*Distinct city counts*/
select count(distinct(City)) as Total_City_Count from city_hotel;    /*10*/

Select City, count(distinct(Hotel_id)) as Total_City_Hotels
from city_hotel
group by City
order by  Total_City_Hotels desc; /* Delhi have highest number of hotels(85), Kolkata have least number of hotels(11)*/

/* Adding a new column "Price" after deducting discount from amount.*/
ALTER TABLE oyo_hotel
ADD COLUMN Price DECIMAL(10, 2); 
SET SQL_SAFE_UPDATES = 0;
UPDATE oyo_hotel
SET Price = amount - discount;

/* Adding columns new_checkin, new_checkout and new_dateOfbook
*/
Alter table oyo_hotel
add column new_checkin date;
Alter table oyo_hotel
add column new_checkout date;
Alter table oyo_hotel
add column new_dateOfbook date;

Update oyo_hotel
set new_checkin= str_to_date(substr(check_in,1,10),'%d-%m-%Y');
Update oyo_hotel
set new_checkout= str_to_date(substr(check_out,1,10),'%d-%m-%Y');
Update oyo_hotel
set new_dateOfbook= str_to_date(substr(date_of_booking,1,10),'%d-%m-%Y');

/*Adding number of night stay for each hotels*/
ALTER TABLE oyo_hotel
ADD COLUMN number_of_nights INT;
UPDATE oyo_hotel
SET number_of_nights = DATEDIFF(new_checkout, new_checkin);

/*Adding rate column*/
Alter table oyo_hotel
add column rate float;
update oyo_hotel
set rate=round(if(number_of_nights=1,(Price/no_of_room),(Price/no_of_room)/number_of_nights),2);
/*If no if night is 1 then it will price divided by no of rooms taken else the 
same will be divided by no of nights*/

select c.city,avg(rate) as avg_rate from oyo_hotel o, city_hotel c 
where o.hotel_id=c.hotel_id group by c.City order by avg_rate desc;
/* It is observed that, the average rate of hotel in Mumbai is highest compared to Gurgaon which is least among all the city.*/

SELECT c.City,o.Status, count(o.Status) as Count
FROM city_hotel c
JOIN oyo_hotel o ON c.hotel_id = o.hotel_id
where o.Status="Cancelled"
GROUP BY c.City, o.Status
order by count(o.Status) desc ;

SELECT c.City,o.Status, count(o.Status) as Count
FROM city_hotel c
JOIN oyo_hotel o ON c.hotel_id = o.hotel_id
GROUP BY c.City, o.Status;
/* As we can see that Gurgaon has the most number of cancellation*/

/*Distribution of booking for each city for every month*/
WITH MonthlyCounts AS (
    SELECT c.City, MONTH(o.new_dateOfbook) AS Month, COUNT(MONTH(o.new_dateOfbook)) AS Count_Month
    FROM oyo_hotel o
    JOIN city_hotel c ON o.hotel_id = c.hotel_id
    GROUP BY c.city, MONTH(o.new_dateOfbook)
)

SELECT City, Month, Count_Month,
    RANK() OVER (PARTITION BY Month ORDER BY Count_Month DESC) AS MonthRank
FROM MonthlyCounts
ORDER BY Month, MonthRank;
/* As we can see that highest number of bookings are done in Gurgaon in month of Jan, Feb and march.*/

 
select * from city_hotel;

/* No of night stay for each bookings*/
SELECT number_of_nights, COUNT(number_of_nights) AS Night_Counts
FROM oyo_hotel
GROUP BY number_of_nights;
/* Most of the booking are made for 1 night only*/

/*Difference between booking were made*/
select count(*) No_of_Bookings, datediff(new_checkin, new_dateofbook) as date_diff from oyo_hotel 
where status="Stayed" group by datediff(new_checkin, new_dateofbook) order by datediff(new_checkin, new_dateofbook) asc;
/* As we can see most of the booking and check ins were made at the same date. As we can say most of the customer avoided prior bookings*/

/*display Gross and Net Revenew for Oyo Hotel*/
SELECT City,
SUM(amount) AS Gross_Revenue,
SUM(amount - discount) AS Net_Revenue
FROM oyo_hotel o
JOIN city_hotel c ON o.hotel_id = c.hotel_id
Group by City;

/* Ranking based on Gross and Net Revenew of each city*/
WITH RevenueByCity AS (
SELECT City,
SUM(amount) AS Gross_Revenue,
SUM(amount - discount) AS Net_Revenue
FROM oyo_hotel o
JOIN city_hotel c ON o.hotel_id = c.hotel_id
Group by City
)
SELECT City,
Gross_Revenue,
Net_Revenue,
RANK() OVER (ORDER BY Gross_Revenue DESC) AS Gross_Rank,
RANK() OVER (ORDER BY Net_Revenue DESC) AS Net_Rank
FROM RevenueByCity;
/* From the table we can see that Delhi have the highest Gross and Net revenew income, and Kolkata having the least*/

/*Group by month to reflect the new and gross income*/
SELECT c.City,
MONTH(o.new_dateOfbook) AS Booking_Month,
SUM(o.amount) AS Gross_Revenue,
SUM(o.amount - o.discount) AS Net_Revenue
FROM oyo_hotel o
JOIN city_hotel c ON o.hotel_id = c.hotel_id
GROUP BY c.City,Booking_Month
ORDER BY Gross_Revenue DESC, Net_Revenue DESC;
/* From the table we can see that Delhi have the highest Gross and Net revenew income, and Kolkata having the least*/

/* CONCLUSTION DERIVED
1. More discount shoud be offered in cities with lesser demand
2. Oyo should consider increasing their footprint in Kolkata as there is less hotel 
but Gross and net income difference is not that much.
3.Cancellation rates should go down as it effects the revenew growth.
4. Most bookings are of single nights only.
5. To increase the revenew more oyo can increase hotels in Mumbai as it showed have highest average rates for hotels.
6. Advanced booking services should be more advertised by giving out more discount for the same.
*/