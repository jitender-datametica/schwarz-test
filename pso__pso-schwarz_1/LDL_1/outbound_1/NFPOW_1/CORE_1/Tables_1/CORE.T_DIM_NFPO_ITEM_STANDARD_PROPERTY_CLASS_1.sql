/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_standard_property_class_1
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_item_standard_property_class_1 (
nfpo_item_standard_property_class_cd STRING(100) NOT NULL
OPTIONS(description='Class of the standardized item_1 properties: So far "TX" for textile item_1 properties and "HG" for hard goods item_1 properties.            LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY_CLASS.MDM_ITEM_STANDARD_PROPERTY_CLASS_CD            CORE_REL: T_NFPO_ITEM_STANDARD_PROPERTY_CLASS.NFPO_ITEM_STANDARD_PROPERTY_CLASS_CD'),
nfpo_item_standard_property_class_descr STRING(250)
OPTIONS(description='Description of the class of standardized item_1 properties.            LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY_CLASS.MDM_ITEM_STANDARD_PROPERTY_CLASS_DESCR            CORE_REL: T_NFPO_ITEM_STANDARD_PROPERTY_CLASS.NFPO_ITEM_STANDARD_PROPERTY_CLASS_DESCR'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_standard_property_class_cd) NOT ENFORCED
)
OPTIONS(description='Classes of item_1 standard properties. So far "TX" for textile item_1 properties and "HG" for hard goods item_1 properties.             Manually filled values derived from:             CBX: LDL_ITEM_CERTIFICATION column names LDL_CERTIFICATION_PROPERTY_TX and LDL_CERTIFICATION_PROPERTY_HG             or from the CNT_CODELIST_BOOK.CODELISTNAME entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX"             LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY_CLASS_1             CORE_REL: T_NFPO_ITEM_STANDARD_PROPERTY_CLASS_1');