CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ZEK_1
   (
   ZEK_ID,
	MANDANT_ID,
	WBL_ID,
	ZEK_ID_LANG,
	ZEK_NAME,
	ZEK_ID_LANG_NAME
   )
   AS
    --2025-01,23, dknop, removing wbl_id > 0
    --2025-01-24, adding Union
   SELECT
    zek_id
   ,mandant_id
   ,MAX(wbl_id) AS wbl_id
-- Anpassung bisherige Logik mit FM000 aufgrund Änderung Spalte zek_id zu Textfeld - AP0172759/SPEC0207789 sschuecke 01.09.2023
   ,MAX(CASE WHEN (TRY_TO_NUMBER(zek_id)::VARCHAR) IS NULL OR TRY_TO_NUMBER(zek_id)::VARCHAR != zek_id  THEN zek_id
                            ELSE TO_VARCHAR(TRY_TO_NUMBER(zek_id), 'FM000')
                            END) AS zek_id_lang
   ,MAX(zek_name) AS zek_name_
   ,zek_id_lang || ' ' || zek_name_ AS zek_id_lang_name
   FROM dbp_view.v_zek_1
   WHERE zek_id <> '-1'
   --AND wbl_id > 0
   GROUP BY 1,2
   UNION
    SELECT zek_vat_id AS ZEK_ID,
	MANDANT_ID,
	0 AS WBL_ID,
	zek_vat_id AS ZEK_ID_LANG,
	'system generated, missing in SAP T024_1' AS ZEK_NAME,
	TRIM(zek_vat_id || ' system generated, missing in SAP T024_1') AS ZEK_ID_LANG_NAME 
    FROM  dbp_view.v_art_1 WHERE (mandant_id ,zek_vat_id) NOT IN (SELECT mandant_id, zek_id FROM DBP_VIEW.V_zek_1) 
    GROUP BY 1,2
   ;