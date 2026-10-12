CREATE OR REPLACE VIEW kfl_production_dbp_view.v_land_1 AS SELECT land_id,
 mandant_id,
 land_bez,
 land_iso,
 eu_land_fg
FROM kfl_production_dbp_data.land_1;