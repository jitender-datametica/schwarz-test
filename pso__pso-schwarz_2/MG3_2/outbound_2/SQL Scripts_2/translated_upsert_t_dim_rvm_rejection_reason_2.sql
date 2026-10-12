TRUNCATE TABLE szd_production_core.t_dim_rvm_rejection_reason_2;


INSERT INTO szd_production_core.t_dim_rvm_rejection_reason_2 (reject_reason_id, deposit_item_cat_cd,
 reject_reason_group_id, reject_reason_descr, reject_reason_descr_en, reject_reason_descr_de, reject_reason_source_nr,
 reject_reason_source_name, dwh_created_tmsp, dwh_updated_tmsp)
(SELECT *
 FROM szd_production_etl.t_dim_rvm_rejection_reason_temp_2);


COMMIT TRANSACTION;