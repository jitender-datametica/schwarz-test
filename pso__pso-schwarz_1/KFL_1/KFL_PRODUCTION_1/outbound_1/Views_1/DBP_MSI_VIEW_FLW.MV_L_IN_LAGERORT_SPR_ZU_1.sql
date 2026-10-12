CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_lagerort_spr_zu_1 (mandant_id, werk_id, lagerort_id,
lagerort_bez) AS SELECT mandant_id,
 werk_id,
 lagerort_id,
 lagerort_bez
FROM kfl_production_dbp_view.v_flw_lagerort_spr_zu_1;