CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_ZEK_2
(
	MANDANT_ID,
	ZEK_ID,
	WBL_ID,
	ZEK_ID_LANG,
	ZEK_NAME,
	ZEK_ID_LANG_NAME
)
AS
SELECT 
 v01.mandant_id
,zek_id
,v01.wbl_id
-- Anpassung bisherige Logik mit FM000 aufgrund Änderung Spalte zek_id zu Textfeld - AP0172759/SPEC0207789 sschuecke 01.09.2023
,CASE WHEN v01.zek_id = '-99'	THEN '099'
	  WHEN v01.zek_id = '-2'	THEN '002'
      WHEN v01.zek_id = '-1'    THEN '001'
	  WHEN v01.zek_id = '0'		THEN '000'
	  ELSE v01.zek_id
      END AS zek_id_lang
,v01.zek_name
,zek_id_lang || ' ' || v01.zek_name AS zek_id_lang_name
FROM dbp_view.v_zek_2 v01;