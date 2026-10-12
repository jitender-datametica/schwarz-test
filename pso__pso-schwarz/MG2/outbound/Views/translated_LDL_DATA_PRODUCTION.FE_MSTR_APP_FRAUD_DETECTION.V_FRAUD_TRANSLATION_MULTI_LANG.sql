CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_fraud_translation_multi_lang (country_org_sid
OPTIONS(description='The identifier for the organization country'), ref_txt
OPTIONS(description='The reference text in receipt print in German'), lang_cd
OPTIONS(description='The Language code of the translation'), translated_txt
OPTIONS(description='The translated text for reference text in language code'))
OPTIONS(DESCRIPTION = `HOLDS THE TRANSLATION FOR ZKP RECEIPTS, DOCUMENTS, REPORTS ETC.`) AS SELECT o.int_org_sid AS
 country_org_sid,
 main.ref_txt,
 main.lang_cd,
 main.translated_txt
FROM ldl_data_production_core_app_fraud_detection.t_fraud_translation AS main
 INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization AS o ON main.lang_cd = o.official_lang_cd
WHERE o.is_country_org_fg
 AND o.dwh_valid_fg;