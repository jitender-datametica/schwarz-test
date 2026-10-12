/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_warranty_type
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_warranty_type (
nfpo_warranty_type_cd STRING(100) NOT NULL
OPTIONS(description='NFPO warranty type code.            CBX: CNT_CODELIST.CODE (code list "LIDL_WARRANTY_ART")            LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE_TYPE.GUARANTEE_TYPE_CD            CORE_REL: T_NFPO_WARRANTY_TYPE.NFPO_WARRANTY_TYPE_CD'),
nfpo_warranty_type_name STRING(100)
OPTIONS(description='NFPO warranty type description.            CBX: CNT_CODELIST.NAME (code list "LIDL_WARRANTY_ART")            LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE_TYPE.GUARANTEE_TYPE_DESCR            CORE_REL: T_NFPO_WARRANTY_TYPE.NFPO_WARRANTY_TYPE_NAME'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_warranty_type_cd) NOT ENFORCED
)
OPTIONS(description='NFPO guarantee types of items.             CBX: CNT_CODELIST (code list "LIDL_WARRANTY_ART")             LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE_TYPE             CORE_REL: T_NFPO_WARRANTY_TYPE');