SELECT count(*) FROM sales.transactions;

SELECT count(*) FROM sales.customers;

select * from sales.transactions limit 5;

select * from sales.transactions where market_code="Mark001";

SELECT count(*) from sales.transactions where market_code="Mark001";

SELECT  * from sales.transactions where currency="USD";

SELECT  sales.transactions.*, sales.date.* from sales.transaction inner join sales.date ON sales.transactions.order_date=sales.date.date;

SELECT  sales.transactions.*, sales.date.* from sales.transaction inner join sales.date ON sales.transactions.order_date=sales.date.date where sales.date.year=2020;

SELECT  sum(sales.transactions.sales_amount) from sales.transaction inner join sales.date ON sales.transactions.order_date=sales.date.date where sales.date.year=2020;

SELECT  sum(sales.transactions.sales_amount)from sales.transaction inner join sales.date ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2020 and sales.transaction.market_code="Mark001";