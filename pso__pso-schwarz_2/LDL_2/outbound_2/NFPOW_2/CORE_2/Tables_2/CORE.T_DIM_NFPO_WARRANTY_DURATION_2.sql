/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_warranty_duration_2
   generated from Powerdesigner on Donnerstag, 6. November 2025 15:42:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_warranty_duration_2 (
nfpo_warranty_dur_cd STRING(100) NOT NULL
OPTIONS(description='NFPO warranty duration code.            CBX: CNT_CODELIST.CODE (code list "LIDL_WARRANTY")            LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE.GUARANTEE_CD            CORE_REL: T_NFPO_WARRANTY_DURATION.NFPO_WARRANTY_DUR_CD'),
nfpo_warranty_dur_name STRING(100)
OPTIONS(description='NFPO warranty duration name.            CBX: CNT_CODELIST.NAME (code list "LIDL_WARRANTY")            LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE.GUARANTEE_DESCR            CORE_REL: T_NFPO_WARRANTY_DURATION.NFPO_WARRANTY_DUR_NAME'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_warranty_dur_cd) NOT ENFORCED
)
OPTIONS(description='NFPO guarantee length types of items.             CBX: CNT_CODELIST_2, code list "LIDL_WARRANTY"             LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE_2             CORE_REL: T_NFPO_WARRANTY_DURATION_2');