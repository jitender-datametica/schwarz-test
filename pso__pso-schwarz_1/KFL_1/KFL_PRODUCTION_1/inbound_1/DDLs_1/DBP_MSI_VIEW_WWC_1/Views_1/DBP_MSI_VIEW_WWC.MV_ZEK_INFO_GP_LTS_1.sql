CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ZEK_INFO_GP_LTS_1(
	MANDANT_ID,
	ZEK_ID,
	WBL_ID,
	ZEK_ID_LANG,
	ZEK_NAME,
	ZEK_ID_LANG_NAME
) AS
   --08.01.2025, SPEC0285828, prescherad: Neuanlage
   SELECT
    v01.mandant_id
   ,v01.zek_id
   ,v01.wbl_id
   ,CASE WHEN (TRY_TO_NUMBER(zek_id)::VARCHAR) IS NULL OR TRY_TO_NUMBER(zek_id)::VARCHAR != zek_id  THEN zek_id
                            ELSE TO_VARCHAR(TRY_TO_NUMBER(zek_id), 'FM000')
                            END AS zek_id_lang
   ,CASE WHEN v01.zek_id <> '-1' THEN v01.zek_name ELSE ' ' END AS zek_name
   ,CASE WHEN v01.zek_id <> '-1' THEN zek_id_lang || ' ' || v01.zek_name ELSE ' ' END AS zek_id_lang_name
   FROM dbp_view.v_zek_1 v01;