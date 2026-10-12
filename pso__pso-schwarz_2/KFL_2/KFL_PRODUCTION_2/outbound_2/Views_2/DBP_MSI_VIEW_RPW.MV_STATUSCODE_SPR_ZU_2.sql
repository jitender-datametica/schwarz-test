CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_statuscode_spr_zu_2 (mandant_id, statuscode_id, spr_id,
statuscode_bez, statuscode_bez_kurz, statuscode_bez_lang, system_id) AS SELECT mandant_id,
 statuscode_id,
 spr_id,
 statuscode_bez,
 statuscode_bez_kurz,
 statuscode_bez_lang,
 7 AS system_id
FROM kfl_production_dbp_view.v_statuscode_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;