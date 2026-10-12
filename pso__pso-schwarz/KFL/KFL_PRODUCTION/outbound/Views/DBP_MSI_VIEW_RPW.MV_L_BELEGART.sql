CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_belegart (mandant_id, belegart_id, system_id) AS SELECT
 mandant_id,
 belegart_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_belegart
WHERE mandant_id = 1;