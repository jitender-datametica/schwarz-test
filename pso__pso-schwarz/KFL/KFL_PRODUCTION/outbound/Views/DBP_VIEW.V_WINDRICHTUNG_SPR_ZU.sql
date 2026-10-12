CREATE OR REPLACE VIEW kfl_production_dbp_view.v_windrichtung_spr_zu AS SELECT windrichtung_schema_id,
 windrichtung_id,
 spr_id,
 windrichtung_bez_kurz,
 windrichtung_bez_lang
FROM kfl_production_dbp_data.windrichtung_spr_zu;