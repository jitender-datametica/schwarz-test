/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_gtin_ownership_2
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:52:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_gtin_ownership_2 (
nfpo_gtin_ownership_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO GTIN assignment responsibility code.
            CBX: CNT_CODELIST.CODE (code list \'LIDL_GTIN_OUTPUT\')
            LDL: P_LEW_CORE.T_REF_MDM_EAN_OWNERSHIP.EAN_OWNERSHIP_CD'''),
nfpo_gtin_ownership_descr STRING(250)
OPTIONS(description='''NFPO GTIN assignment responsibility descriptions.
            CBX: CNT_CODELIST.NAME (code list \'LIDL_GTIN_OUTPUT\')
            LDL: P_LEW_CORE.T_REF_MDM_EAN_OWNERSHIP.EAN_OWNERSHIP'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_EAN_OWNERSHIP.DWH_CREATED'''),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_EAN_OWNERSHIP.DWH_UPDATED'''),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_gtin_ownership_cd) NOT ENFORCED
)
OPTIONS(description='''NFPO responsibility of GTIN assignment to items.
             CBX: CNT_CODELIST_2, code list \'LIDL_GTIN_OUTPUT\'
             LDL: P_LEW_CORE.T_REF_MDM_EAN_OWNERSHIP_2
             CORE_REL: T_NFPO_GTIN_OWNERSHIP_2''');