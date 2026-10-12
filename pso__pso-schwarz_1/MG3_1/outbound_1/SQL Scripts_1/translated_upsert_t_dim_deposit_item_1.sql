TRUNCATE TABLE szd_production_core.t_dim_deposit_item_1;


INSERT INTO szd_production_core.t_dim_deposit_item_1 (item_grp_nr, deposit_item_name, ean_1, deposit_item_cat_cd,
 rvm_manufacturer_sid, lob_cd, country_pol_cd, item_content_cl_qty, item_material_name, dwh_created_tmsp,
 dwh_updated_tmsp, item_refund)
(SELECT *
 FROM szd_production_etl.t_dim_deposit_item_temp_1);


COMMIT TRANSACTION;