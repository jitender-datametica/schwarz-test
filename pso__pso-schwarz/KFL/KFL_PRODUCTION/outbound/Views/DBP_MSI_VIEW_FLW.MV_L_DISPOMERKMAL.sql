CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_dispomerkmal (mandant_id, dispomerkmal) AS SELECT mandant_id
 ,
 dispomerkmal
FROM kfl_production_dbp_view.v_l_dispomerkmal AS V01;