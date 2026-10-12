CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_mandant_kunde_spr_zu_2 AS SELECT mandant_id,
 mandant_bez,
 mandant_kbez,
 mandant_sort_id
FROM kfl_production_dbp_view.v_mandant_2 AS V01;