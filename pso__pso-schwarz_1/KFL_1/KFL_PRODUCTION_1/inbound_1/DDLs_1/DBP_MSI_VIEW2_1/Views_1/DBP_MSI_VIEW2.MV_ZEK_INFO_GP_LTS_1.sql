   CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ZEK_INFO_GP_LTS_1(
	mandant_id,
	zek_id,
	wbl_id,
	zek_id_lang,
	zek_name,
	zek_id_lang_name
) AS
   SELECT
   v01.mandant_id, 
   v01.zek_id, 
   v01.wbl_id, 
  -- Anpassung bisherige Logik mit FM000 aufgrund Änderung Spalte zek_id zu Textfeld - AP0172759/SPEC0207789 sschuecke 01.09.2023
  CASE WHEN (TRY_TO_NUMBER(zek_id)::VARCHAR) IS NULL OR TRY_TO_NUMBER(zek_id)::VARCHAR != zek_id  THEN zek_id
                            ELSE TO_VARCHAR(TRY_TO_NUMBER(zek_id), 'FM000')
                            END AS zek_id_lang,
   CASE WHEN zek_id <> '-1' THEN v01.zek_name ELSE ' ' END AS zek_name, 
   CASE WHEN zek_id <> '-1' THEN zek_id_lang || ' ' || v01.zek_name ELSE ' ' END AS zek_id_lang_name
   FROM dbp_view.v_zek_1 v01
   WHERE v01.mandant_id = 1;