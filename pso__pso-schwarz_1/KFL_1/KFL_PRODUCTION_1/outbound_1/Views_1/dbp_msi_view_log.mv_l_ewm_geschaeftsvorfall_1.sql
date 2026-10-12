CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_ewm_geschaeftsvorfall_1 (mandant_id, lagernummer_id,
ewm_gv_grp_id, ewm_gv_id, gv_einheit_id) AS SELECT mandant_id,
 lagernummer_id,
 ewm_gv_grp_id,
 ewm_gv_id,
 gv_einheit_id
FROM kfl_production_dbp_view.v_l_ewm_geschaeftsvorfall_1
WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
 AND LENGTH(TRIM(lagernummer_id)) = 4;