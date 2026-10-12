CREATE TABLE CORE_APP_FRAUD_DETECTION.T_FRAUD_TRANSLATION (
   ref_txt                             VARCHAR(1000)   NOT NULL COMMENT 'The reference text in receipt print in German',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The Language code of the translation',
   translated_txt                      VARCHAR(1000) COMMENT 'The translated text for reference text in language code',
   CONSTRAINT PK_T_FRAUD_TRANSLATION PRIMARY KEY (ref_txt, lang_cd) NOT ENFORCED
)  COMMENT= 'Holds the translation for ZKP Receipts, documents, reports etc.';