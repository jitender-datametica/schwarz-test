-- 2024-03-28, dknop, AP0179753, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_diff_spr_zu (mandant_id, diff_id, spr_id,
diff_bez) AS SELECT mandant_id,
 diff_id,
 spr_id,
 diff_bez
FROM kfl_production_dbp_view.v_diff_spr_zu AS V01
WHERE mandant_id = 1;