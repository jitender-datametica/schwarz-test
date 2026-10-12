CREATE TABLE IF NOT EXISTS ldl_data_core_app_fraud_detection.t_fraud_translation_1 (
ref_txt STRING(1000) NOT NULL OPTIONS(description='The reference text in receipt print in German'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The Language code of the translation'),
translated_txt STRING(1000) OPTIONS(description='The translated text for reference text in language code'),
PRIMARY KEY (ref_txt, lang_cd) NOT ENFORCED
) OPTIONS(description='Holds the translation for ZKP Receipts, documents, reports etc.');