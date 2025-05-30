--Total Revenue Calculation
SELECT SUM(total_price) AS Total_Revenue 
FROM pizza_sales_clean;

--Average Order Value Calculation
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM pizza_sales_clean;

--Total Pizzas Sold Calculation
SELECT SUM(quantity) AS Total_Pizza_Sold 
FROM pizza_sales_clean;

--Total Orders Calculation
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales_clean;

--Average Pizzas Per Order Calculation
SELECT CAST(CAST(SUM(quantity) AS DECIMAL (10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL (10,2)) AS DECIMAL (10,2)) AS Avg_Pizzas_Per_Order
FROM pizza_sales_clean;

--Daily Trend for Total Orders Calculation
SELECT DATENAME(DW, order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales_clean
GROUP BY DATENAME (DW,order_date);

--Monthly Trend for Total Orders Calculation
SELECT DATENAME(MONTH, order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales_clean
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC; 

--Percentage of Sales by Pizza Category Calculation
SELECT pizza_category, SUM(total_price) AS Total_Sales, SUM(total_price) * 100 /
(SELECT SUM(total_price) FROM pizza_sales_clean WHERE MONTH(order_date) = 1) AS PCT 
FROM pizza_sales_clean
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

--Percentage of Sales by Pizza Size Calculation
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, CAST(SUM(total_price) * 100 /
(SELECT SUM(total_price) FROM pizza_sales_clean WHERE DATEPART(QUARTER, order_date)=1) AS DECIMAL (10,2)) AS PCT
FROM pizza_sales_clean
WHERE DATEPART(QUARTER, order_date)=1
GROUP BY pizza_size
ORDER BY PCT DESC;

--Total Pizzas Sold by Pizza Category Calculation
SELECT pizza_category, SUM (quantity) AS Total_Quantity_Sold
FROM pizza_sales_clean
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

-- Top 5 Best Sellers by Revenue Calculation
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue 
FROM pizza_sales_clean
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

-- Bottom 5 Worst Sellers by Revenue Calculation
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales_clean
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;

-- Top 5 Best Sellers by Total Revenue Calculation
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity 
FROM pizza_sales_clean
GROUP BY pizza_name
ORDER BY Total_Quantity DESC;

-- Bottom 5 Worst Sellers by Total Quantity Calculation
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity 
FROM pizza_sales_clean
GROUP BY pizza_name
ORDER BY Total_Quantity ASC;

-- Top 5 Best Sellers by Total Orders Calculation
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales_clean
GROUP BY pizza_name
ORDER BY Total_Orders DESC;

-- Bottom 5 Worst Sellers by Total Orders Calculation
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales_clean
GROUP BY pizza_name
ORDER BY Total_Orders ASC;