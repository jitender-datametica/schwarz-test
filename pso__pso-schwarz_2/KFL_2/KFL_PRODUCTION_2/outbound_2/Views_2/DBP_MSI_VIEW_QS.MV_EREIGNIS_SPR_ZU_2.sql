CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_ereignis_spr_zu_2 (ereignis_id, ereignis_bez_lang, ereignistyp_id
, mandant_id, ereignis_bez_mittel, ereignis_bez_kurz) AS SELECT ereignis_id,
 ereignis_bez_lang,
 ereignistyp_id,
 mandant_id,
 ereignis_bez_mittel,
 ereignis_bez_kurz
FROM kfl_production_dbp_view.v_ereignis_spr_zu_2 AS V01
WHERE spr_id = 22;