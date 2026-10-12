CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_zek (zek_id, mandant_id, zek_name, zek_lang_bez) AS SELECT
 zek_id,
 mandant_id,
 zek_name,
  CASE
  WHEN zek_id = '-99'
  THEN '-099' || ' ' || zek_name
  WHEN zek_id = '-2'
  THEN '-002' || ' ' || zek_name
  WHEN zek_id = '0'
  THEN '000' || ' ' || zek_name
  ELSE zek_id || ' ' || zek_name
  END AS zek_lang_bez
FROM kfl_production_dbp_view.v_zek
WHERE zek_id <> '-1';