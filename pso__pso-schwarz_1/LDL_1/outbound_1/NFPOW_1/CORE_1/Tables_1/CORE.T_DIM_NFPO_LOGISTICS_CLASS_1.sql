/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_logistics_class_1
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_logistics_class_1 (
nfpo_logistics_class_cd STRING(100) NOT NULL
OPTIONS(description='Code to classify the way the items will be transported from the central warehouse of OWIM into the countries.            CBX: CNT_CODELIST.CODE (code list "LIDL_DELIVERYTYPE")            LDL: P_LEW_CORE.T_REF_MDM_LOGISTICS_CLASS.MDM_LOGISTICS_CLASS_CD            CORE_REL: T_NFPO_LOGISTICS_CLASS.NFPO_LOGISTICS_CLASS_CD'),
nfpo_logistics_class_name STRING(100)
OPTIONS(description='Name to classify the way the items will be transported from the central warehouse of OWIM into the countries.            CBX: CNT_CODELIST.NAME (code list "LIDL_DELIVERYTYPE")            LDL: P_LEW_CORE.T_REF_MDM_LOGISTICS_CLASS.MDM_LOGISTICS_CLASS_NAME            CORE_REL: T_NFPO_LOGISTICS_CLASS.NFPO_LOGISTICS_CLASS_NAME'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_logistics_class_cd) NOT ENFORCED
)
OPTIONS(description='NFPO classification of the way the items will be transported from the central warehouse of OWIM into the countries.             CBX: CNT_CODELIST_1 (code list "LIDL_DELIVERYTYPE")             LDL: P_LEW_CORE.T_REF_MDM_LOGISTICS_CLASS_1             CORE_REL: T_NFPO_LOGISTICS_CLASS_1');