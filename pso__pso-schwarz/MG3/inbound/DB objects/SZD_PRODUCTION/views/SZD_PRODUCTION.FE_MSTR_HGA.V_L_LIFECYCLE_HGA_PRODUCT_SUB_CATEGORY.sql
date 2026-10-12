create or replace view SZD_PRODUCTION.FE_MSTR_HGA.V_L_LIFECYCLE_HGA_PRODUCT_SUB_CATEGORY(
	HGA_PRODUCT_CAT_ID,
	HGA_PRODUCT_SUB_CAT_ID,
	HGA_PRODUCT_SUB_CAT_NAME
) as 
SELECT
 core.t_dim_hga_product_sub_category.hga_product_cat_id 
,core.t_dim_hga_product_sub_category.hga_product_sub_cat_id 
,core.t_dim_hga_product_sub_category.hga_product_sub_cat_name
FROM 
CORE.T_DIM_HGA_PRODUCT_SUB_CATEGORY
;