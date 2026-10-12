TRUNCATE TABLE szd_production_core.t_dim_line_of_business_1;


INSERT INTO szd_production_core.t_dim_line_of_business_1 (lob_cd, lob_name, dwh_created_tmsp, dwh_updated_tmsp)
(SELECT *
 FROM szd_production_etl.t_dim_line_of_business_temp_1);


COMMIT TRANSACTION;