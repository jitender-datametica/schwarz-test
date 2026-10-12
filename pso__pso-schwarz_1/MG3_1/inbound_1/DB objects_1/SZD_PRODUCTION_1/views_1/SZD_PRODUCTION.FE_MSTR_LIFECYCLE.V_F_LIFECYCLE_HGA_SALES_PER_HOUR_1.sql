create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.V_F_LIFECYCLE_HGA_SALES_PER_HOUR_1(
	HGA_SID,
	SALE_DT,
	SALE_HOUR,
	HGA_PRODUCT_CAT_ID,
	PRODUCT_SALE_CNT
) as
SELECT
 core.t_fact_hga_sales_per_hour.hga_sid             
,core.t_fact_hga_sales_per_hour.sale_dt             
,core.t_fact_hga_sales_per_hour.sale_hour
,core.t_fact_hga_sales_per_hour.hga_product_cat_id      
,core.t_fact_hga_sales_per_hour.product_sale_cnt    
FROM 
CORE.T_FACT_HGA_SALES_PER_HOUR_1
;