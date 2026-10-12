CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_ZEK_GP(
	MANDANT_ID,
	ZEK_ID,
	WBL_ID,
	ZEK_ID_LANG,
	ZEK_NAME,
	ZEK_ID_LANG_NAME
) AS SELECT
    v01.mandant_id
    ,v01.zek_id
    ,v01.wbl_id
    -- Anpassung bisherige Logik mit FM000 aufgrund Änderung Spalte zek_id zu Textfeld - AP0172759/SPEC0207789 sschuecke 01.09.2023
    ,CASE WHEN (TRY_TO_NUMBER(zek_id)::VARCHAR) IS NULL OR TRY_TO_NUMBER(zek_id)::VARCHAR != zek_id  THEN zek_id
                            ELSE TO_VARCHAR(TRY_TO_NUMBER(zek_id), 'FM000')
                            END AS zek_id_lang
    ,CASE WHEN v01.zek_id <> '-1' THEN v01.zek_name ELSE ' ' END AS zek_name
    ,CASE WHEN v01.zek_id <> '-1' THEN zek_id_lang || ' ' || v01.zek_name ELSE ' ' END AS zek_id_lang_name
FROM dbp_view.v_zek v01;