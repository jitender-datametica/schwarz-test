TRUNCATE TABLE szd_production_core.t_dim_deposit_outpayment_type_2;


INSERT INTO szd_production_core.t_dim_deposit_outpayment_type_2 (deposit_outpayment_type_cd, deposit_outpayment_type_descr
 , deposit_outpayment_type_descr_en, deposit_outpayment_type_descr_de, dwh_created_tmsp, dwh_updated_tmsp)
(SELECT *
 FROM szd_production_etl.t_dim_deposit_outpayment_type_temp_2);


COMMIT TRANSACTION;