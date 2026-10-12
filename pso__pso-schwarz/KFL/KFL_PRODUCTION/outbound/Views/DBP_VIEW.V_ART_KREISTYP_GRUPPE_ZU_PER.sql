CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_kreistyp_gruppe_zu_per AS SELECT art_id,
 mandant_id,
 kreistyp_id,
 dat_von,
 kreistyp_gruppe_id,
 dat_bis
FROM kfl_production_dbp_data.art_kreistyp_gruppe_zu_per;