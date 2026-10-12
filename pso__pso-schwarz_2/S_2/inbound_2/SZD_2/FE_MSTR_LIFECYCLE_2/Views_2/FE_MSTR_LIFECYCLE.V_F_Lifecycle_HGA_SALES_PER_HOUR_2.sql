CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.V_F_Lifecycle_HGA_SALES_PER_HOUR_2
AS
SELECT
 core.t_fact_hga_sales_per_hour.hga_sid             
,core.t_fact_hga_sales_per_hour.sale_dt             
,core.t_fact_hga_sales_per_hour.sale_hour
,core.t_fact_hga_sales_per_hour.hga_product_cat_id      
,core.t_fact_hga_sales_per_hour.product_sale_cnt    
FROM 
CORE.T_FACT_HGA_SALES_PER_HOUR_2
;         

