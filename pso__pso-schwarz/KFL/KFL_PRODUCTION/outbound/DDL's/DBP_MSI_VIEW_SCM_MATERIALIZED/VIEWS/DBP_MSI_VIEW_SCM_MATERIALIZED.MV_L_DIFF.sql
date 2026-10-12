CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_l_diff (mandant_id, diff_id) AS SELECT mandant_id
 ,
 diff_id
FROM kfl_production_dbp_view.v_l_kz_differenz
WHERE mandant_id = 1;