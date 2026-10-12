CREATE TABLE IF NOT EXISTS ldl_dig_transfer.t_agg_lec_sales_daily_1 (
cal_dt DATE NOT NULL OPTIONS(description='The calendar_1 date'),
weekday STRING(100) OPTIONS(description='The day of the week'),
bus_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The business year (starting in March, ending in February of the following calendar_1 year)'),
month_of_bus_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The month of business year, indicated by a number (1 = March, 2 = April, ... 12 = February)'),
wshop_cd STRING(5) NOT NULL OPTIONS(description='The unique code for the Lidl webshop'),
gmv_gross_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Gross Merchandise Value = gross order revenue (including shipping fees and additional services) before cancellations and returns'),
app_gmv_gross_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Gross Merchandise Value generated from the mobile apps (iOS & Android ; old app versions & new OneApp)'),
order_revenue_gross_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Gross Sales_1 Revenue before cancellations and before returns'),
order_cnt BIGNUMERIC(38,5) OPTIONS(description='Number of customer orders'),
avg_basket_gross_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Average order basket gross euro value, before cancellations and before returns'),
cust_cnt BIGNUMERIC(38,5) OPTIONS(description='Number of unique customers who ordered on the online shop'),
gmv_per_customer_gross_eur_val BIGNUMERIC(38,5)
OPTIONS(description='The Gross Merchandise Value generated per unique customer'),
gmv_per_order_gross_eur_val BIGNUMERIC(38,5)
OPTIONS(description='The Gross Merchandise Value generated per customer order'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded'),
PRIMARY KEY (cal_dt, wshop_cd) NOT ENFORCED
)
OPTIONS(description='This table is used for the daily reporting of aggregated sales_1 KPIs (before cancellations and before returns) from LEC business operations');