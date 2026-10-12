CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_wg_per (mandant_id, wg_id, arthiertyp_id, abt_id,
wg_id_lang, owg_id) AS SELECT mandant_id,
 wg_id,
 arthiertyp_id,
 abt_id,
 TRIM(CAST(wg_id AS STRING FORMAT '000')) AS wg_id_lang,
 owg_id
FROM kfl_production_dbp_view.v_wg_per AS V01
WHERE mandant_id > 1
 AND dat_bis = DATE '9999-12-31';