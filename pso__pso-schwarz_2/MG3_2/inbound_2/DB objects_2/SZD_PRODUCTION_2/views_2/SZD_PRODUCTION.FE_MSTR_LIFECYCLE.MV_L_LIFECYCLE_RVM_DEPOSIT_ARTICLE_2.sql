create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_DEPOSIT_ARTICLE_2(
	DEPOSIT_ITEM_CAT_CD,
	EAN_2
) as 
SELECT 
 core.t_dim_deposit_item.deposit_item_cat_cd
,core.t_dim_deposit_item.ean_2
FROM 
core.t_dim_deposit_item_2
;