CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wg_auslieferungsgruppe_per_2 AS SELECT mandant_id,
 auslieferungsgruppe_id,
 wg_id,
 sortimentslistenart_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_data.wg_auslieferungsgruppe_per_2;