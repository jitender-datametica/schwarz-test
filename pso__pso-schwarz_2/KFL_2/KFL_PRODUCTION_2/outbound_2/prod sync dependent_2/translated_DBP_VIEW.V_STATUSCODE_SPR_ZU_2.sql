CREATE OR REPLACE VIEW kfl_production_dbp_view.v_statuscode_spr_zu_2 (system_id, mandant_id, statuscode_id, spr_id,
statuscode_bez, statuscode_bez_kurz, statuscode_bez_lang, td_update, td_insert) AS SELECT system_id,
 mandant_id,
 statuscode_id,
 spr_id,
 statuscode_bez,
 statuscode_bez_kurz,
 statuscode_bez_lang,
 td_update,
 td_insert
FROM kfl_production_dbp_data.statuscode_spr_zu_2;