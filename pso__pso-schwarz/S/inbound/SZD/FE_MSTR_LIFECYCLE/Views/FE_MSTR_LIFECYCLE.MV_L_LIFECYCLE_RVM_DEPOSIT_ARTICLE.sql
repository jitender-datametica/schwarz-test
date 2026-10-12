CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_DEPOSIT_ARTICLE
AS 
SELECT 
 core.t_dim_deposit_item.deposit_item_cat_cd
,core.t_dim_deposit_item.ean
FROM 
core.t_dim_deposit_item
;