CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wg_auslieferungsgruppe_per_1 (mandant_id, auslieferungsgruppe_id
, wg_id, dat_von, dat_bis) AS SELECT mandant_id,
 auslieferungsgruppe_id,
 wg_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_view.v_wg_auslieferungsgruppe_per_1
WHERE dat_bis >= DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY);