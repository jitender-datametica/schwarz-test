CREATE OR REPLACE VIEW kfl_production_dbp_view.v_problemcode_spr_zu_2 (system_id, mandant_id, problemcode_id, spr_id,
problemcode_bez, problemcode_bez_kurz, problemcode_bez_lang, td_update, td_insert) AS SELECT system_id,
 mandant_id,
 problemcode_id,
 spr_id,
 problemcode_bez,
 problemcode_bez_kurz,
 problemcode_bez_lang,
 td_update,
 td_insert
FROM kfl_production_dbp_data.problemcode_spr_zu_2;