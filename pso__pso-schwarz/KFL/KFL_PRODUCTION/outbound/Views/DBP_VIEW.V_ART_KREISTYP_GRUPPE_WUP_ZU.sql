CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_kreistyp_gruppe_wup_zu AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 kreistyp_gruppe_id
FROM kfl_production_dbp_data.art_kreistyp_gruppe_wup_zu;