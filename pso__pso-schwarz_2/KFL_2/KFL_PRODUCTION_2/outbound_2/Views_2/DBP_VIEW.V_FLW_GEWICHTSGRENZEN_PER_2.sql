CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_gewichtsgrenzen_per_2 AS SELECT flw_art_id,
 dat_von,
 mandant_id,
 system_id,
 dat_bis,
 gewicht_kg_von,
 gewicht_kg_bis,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_gewichtsgrenzen_per_2;