create or replace view SZD_PRODUCTION.FE_MSTR_HGA.V_F_LIFECYCLE_HGA_SALES_PER_DAY(
	HGA_SID,
	SALE_DT,
	PAYMENT_TYPE_ID,
	HGA_PRODUCT_CAT_ID,
	SALE_TM,
	PRODUCT_SALE_CNT,
	SALE_PRICE
) as
SELECT
 core.t_fact_hga_sales_per_day.hga_sid             
,core.t_fact_hga_sales_per_day.sale_dt             
,core.t_fact_hga_sales_per_day.payment_type_id     
,core.t_fact_hga_sales_per_day.hga_product_cat_id  
,core.t_fact_hga_sales_per_day.sale_tm             
,core.t_fact_hga_sales_per_day.product_sale_cnt    
,core.t_fact_hga_sales_per_day.sale_price
FROM 
CORE.T_FACT_HGA_SALES_PER_DAY
;