TRUNCATE TABLE szd_production_core.t_dim_rvm_cleaning_status_1;


INSERT INTO szd_production_core.t_dim_rvm_cleaning_status_1 (cleaning_status_cd, cleaning_status_descr,
 cleaning_status_descr_en, cleaning_status_descr_de, dwh_created_tmsp, dwh_updated_tmsp)
(SELECT *
 FROM szd_production_etl.t_dim_rvm_cleaning_status_temp_1);


COMMIT TRANSACTION;