TRUNCATE TABLE szd_production_core.t_dim_deposit_item_category;


INSERT INTO szd_production_core.t_dim_deposit_item_category (deposit_item_cat_cd, deposit_item_cat_descr,
 deposit_item_cat_descr_de, deposit_item_cat_descr_en, dwh_created_tmsp, dwh_updated_tmsp)
(SELECT *
 FROM szd_production_etl.t_dim_deposit_item_category_temp);


COMMIT TRANSACTION;