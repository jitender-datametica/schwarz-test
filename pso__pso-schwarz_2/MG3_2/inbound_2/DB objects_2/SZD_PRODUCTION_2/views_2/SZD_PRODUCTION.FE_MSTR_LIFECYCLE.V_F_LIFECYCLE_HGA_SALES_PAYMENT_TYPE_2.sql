create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.V_F_LIFECYCLE_HGA_SALES_PAYMENT_TYPE_2(
	HGA_SID,
	SALE_DT,
	PAYMENT_TYPE_ID,
	HGA_PRODUCT_CAT_ID,
	CURR_CD,
	MUG_TYPE_ID,
	SALE_TM,
	SALE_PRICE,
	SALE_EUR_PRICE,
	LID_FG,
	SALES_CNT
) as
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
,COUNT (hga_sid) AS sales_cnt
FROM
CORE.t_fact_hga_sales_2
GROUP BY
hga_sid
,sale_dt
,payment_type_id
,hga_product_cat_id
,curr_cd
,mug_type_id
,sale_tm
,sale_price
,sale_eur_price
,lid_fg
;