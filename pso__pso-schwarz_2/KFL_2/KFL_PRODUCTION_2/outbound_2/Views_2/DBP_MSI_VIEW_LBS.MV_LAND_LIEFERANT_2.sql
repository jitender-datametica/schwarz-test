CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_land_lieferant_2 (mandant_id, land_id, land_bez) AS SELECT
 mandant_id,
 land_id,
 land_bez
FROM kfl_production_dbp_view.v_land_2 AS V01;