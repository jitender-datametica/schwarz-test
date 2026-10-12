CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.V_F_Lifecycle_HGA_SALES 
AS
SELECT
 core.t_fact_hga_sales.hga_sid             
,core.t_fact_hga_sales.sale_dt             
,core.t_fact_hga_sales.payment_type_id     
,core.t_fact_hga_sales.hga_product_cat_id  
,core.t_fact_hga_sales.curr_cd
,core.t_fact_hga_sales.mug_type_id
,core.t_fact_hga_sales.sale_tm                
,core.t_fact_hga_sales.sale_price
,core.t_fact_hga_sales.sale_eur_price
,core.t_fact_hga_sales.lid_fg
FROM 
CORE.T_FACT_HGA_SALES
;