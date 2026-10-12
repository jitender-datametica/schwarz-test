TRUNCATE TABLE szd_production_core.t_dim_rvm_winding_1;


INSERT INTO szd_production_core.t_dim_rvm_winding_1 (rvm_winding_cd, rvm_winding_descr, rvm_winding_descr_de,
 rvm_winding_descr_en, dwh_created_tmsp, dwh_updated_tmsp)
(SELECT *
 FROM szd_production_etl.t_dim_rvm_winding_temp_1);


COMMIT TRANSACTION;