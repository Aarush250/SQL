create database sql_project_p2;
create table retail_sales 
   (
    transactions_id int primary key,
	sale_date date,
	sale_time time,	
    customer_id	int,
    gender varchar(15),
    age	int,
    category varchar(15),	
    quantiy	int,
    price_per_unit float,	
    cogs float,	
    total_sale float
    );
select * from retail_sales
where sale_date = '2022-11-05';
select * from retail_sales 
where category = "Clothing" and
quantiy >= 4 and
month(sale_date) = 11 and 
year(sale_date) = 2022;

select category , sum(total_sale) as sales
from retail_sales
group by category;

select category , avg(age) as average_age
from retail_sales 
where category = "Beauty"
group by category;

select *
from retail_sales
where total_sale > 1000;

select
year(sale_date) as sales_year,
month(sale_date) as sales_month,
avg(total_sale) as total_sales,
RANK() over( partition by year(sale_date) order by year(sale_date)) as rank_holders
from retail_sales,
group by sales_year, sales_month;
SELECT 
    YEAR(sale_date) AS sales_year,
    MONTH(sale_date) AS sales_month,
    AVG(total_sale) AS total_sales,
    RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank_holders
FROM retail_sales
GROUP BY 1, 2;

select customer_id,
sum(total_sale) as sale_amount
from retail_sales
group by customer_id 
order by sale_amount desc
limit 5;

select
category, 
customer_id 
from 
retail_sales
group by category, customer_id
order by category;

with hourly_shift as
(select
sale_time,
case
    when hour(sale_time) < 12 then "morning"
    when hour(sale_time) between 12 and 17 then "afternoon"
    else "evening"
    end as shift
    from retail_sales
)
select 
shift,
count(*) 
from 
hourly_shift
group by shift



