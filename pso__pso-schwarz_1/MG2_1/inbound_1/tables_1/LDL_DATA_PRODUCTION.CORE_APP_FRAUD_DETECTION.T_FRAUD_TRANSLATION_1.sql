create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_TRANSLATION_1 (
	REF_TXT VARCHAR(1000) NOT NULL COMMENT 'The reference text in receipt print in German',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The Language code of the translation',
	TRANSLATED_TXT VARCHAR(1000) COMMENT 'The translated text for reference text in language code',
	constraint PK_T_FRAUD_TRANSLATION primary key (REF_TXT, LANG_CD)
)COMMENT='Holds the translation for ZKP Receipts, documents, reports etc.'
;