CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_problemcode_spr_zu_1 (mandant_id, problemcode_id, spr_id,
problemcode_bez, problemcode_bez_kurz, problemcode_bez_lang, system_id) AS SELECT mandant_id,
 problemcode_id,
 spr_id,
 problemcode_bez,
 problemcode_bez_kurz,
 problemcode_bez_lang,
 7 AS system_id
FROM kfl_production_dbp_view.v_problemcode_spr_zu_1
WHERE mandant_id = 1
 AND spr_id = 22;