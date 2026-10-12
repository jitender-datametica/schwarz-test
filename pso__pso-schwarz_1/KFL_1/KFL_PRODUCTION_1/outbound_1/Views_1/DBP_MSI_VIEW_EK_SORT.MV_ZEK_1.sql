CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_zek_1 (mandant_id, zek_id, wbl_id, zek_id_lang, zek_name,
zek_id_lang_name) AS SELECT mandant_id,
 zek_id,
 wbl_id,
  CASE
  WHEN zek_id = '-99'
  THEN '099'
  WHEN zek_id = '-2'
  THEN '002'
  WHEN zek_id = '-1'
  THEN '001'
  WHEN zek_id = '0'
  THEN '000'
  ELSE zek_id
  END AS zek_id_lang,
 zek_name,
    CASE
    WHEN zek_id = '-99'
    THEN '099'
    WHEN zek_id = '-2'
    THEN '002'
    WHEN zek_id = '-1'
    THEN '001'
    WHEN zek_id = '0'
    THEN '000'
    ELSE zek_id
    END || ' ' || zek_name AS zek_id_lang_name
FROM kfl_production_dbp_view.v_zek_1 AS V01;