CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_zek_2 (zek_id, mandant_id, wbl_id, zek_name, zek_lang_bez,
zek_eltern_sec_id, zek_eltern_mandant_id) AS SELECT zek_id,
 mandant_id,
 wbl_id,
 zek_name,
  CASE
  WHEN zek_id = '-99'
  THEN '-099' || ' ' || zek_name
  WHEN zek_id = '-2'
  THEN '-002' || ' ' || zek_name
  WHEN zek_id = '0'
  THEN '000' || ' ' || zek_name
  ELSE zek_id || ' ' || zek_name
  END AS zek_lang_bez,
 zek_id AS zek_eltern_sec_id,
 mandant_id AS zek_eltern_mandant_id
FROM kfl_production_dbp_view.v_zek_2
WHERE mandant_id = 1
 AND zek_id <> '-1';