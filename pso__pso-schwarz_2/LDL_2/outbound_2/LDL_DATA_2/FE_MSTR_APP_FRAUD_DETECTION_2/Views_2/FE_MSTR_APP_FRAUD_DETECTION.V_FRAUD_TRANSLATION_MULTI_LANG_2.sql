CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_fraud_translation_multi_lang_2 (country_org_sid
OPTIONS(description='The identifier for the organization country_2'), ref_txt
OPTIONS(description='The reference text in receipt print in German'), lang_cd
OPTIONS(description='The Language code of the translation'), translated_txt
OPTIONS(description='The translated text for reference text in language code'))
OPTIONS(DESCRIPTION = `HOLDS THE TRANSLATION FOR ZKP RECEIPTS, DOCUMENTS, REPORTS ETC.`) AS SELECT O.int_org_sid AS
 country_org_sid,
 MAIN.ref_txt,
 MAIN.lang_cd,
 MAIN.translated_txt
FROM ldl_data_core_app_fraud_detection.t_fraud_translation_2 AS MAIN
 INNER JOIN ldl_data_core_dim.t_dim_internal_organization_2 AS O ON MAIN.lang_cd = O.official_lang_cd
WHERE O.is_country_org_fg
 AND O.dwh_valid_fg;