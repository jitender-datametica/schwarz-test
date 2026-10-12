CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.mv_l_lifecycle_rvm_deposit_article (deposit_item_cat_cd, ean) AS
SELECT deposit_item_cat_cd,
 ean
FROM szd_production_core.t_dim_deposit_item;