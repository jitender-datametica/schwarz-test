CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_belegart (mandant_id, system_id, blart) AS SELECT mandant_id
 ,
 system_id,
 belegart_id AS blart
FROM kfl_production_dbp_view.v_l_belegart AS V01;