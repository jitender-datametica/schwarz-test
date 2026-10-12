create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_FRAUD_TRANSLATION_MULTI_LANG(
	COUNTRY_ORG_SID COMMENT 'The identifier for the organization country',
	REF_TXT COMMENT 'The reference text in receipt print in German',
	LANG_CD COMMENT 'The Language code of the translation',
	TRANSLATED_TXT COMMENT 'The translated text for reference text in language code'
) COMMENT='Holds the translation for ZKP Receipts, documents, reports etc.'
 as SELECT 
o.int_org_sid
,main.ref_txt
,main.lang_cd
,main.translated_txt
FROM CORE_APP_FRAUD_DETECTION.T_FRAUD_TRANSLATION main
INNER JOIN CORE_DIM.T_DIM_INTERNAL_ORGANIZATION o
ON main.lang_cd = o.official_lang_cd
WHERE o.is_country_org_fg
AND o.dwh_valid_fg ;