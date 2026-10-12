CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_dispomerkmal_2 (mandant_id, dispomerkmal) AS SELECT mandant_id
 ,
 dispomerkmal
FROM kfl_production_dbp_view.v_l_dispomerkmal_2 AS V01;