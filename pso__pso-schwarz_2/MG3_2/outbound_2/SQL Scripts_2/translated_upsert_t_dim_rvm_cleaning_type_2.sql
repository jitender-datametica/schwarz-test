TRUNCATE TABLE szd_production_core.t_dim_rvm_cleaning_type_2;


INSERT INTO szd_production_core.t_dim_rvm_cleaning_type_2 (cleaning_type_cd, cleaning_type_descr, cleaning_type_descr_en,
 cleaning_type_descr_de, dwh_created_tmsp, dwh_updated_tmsp)
(SELECT *
 FROM szd_production_etl.t_dim_rvm_cleaning_type_temp_2);


COMMIT TRANSACTION;