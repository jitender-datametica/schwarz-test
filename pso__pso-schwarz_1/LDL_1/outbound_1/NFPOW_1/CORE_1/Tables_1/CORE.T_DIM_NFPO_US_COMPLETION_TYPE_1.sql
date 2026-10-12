/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_us_completion_type_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_us_completion_type_1 (
nfpo_us_completion_type_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO completion types.
            CBX: CNT_CODELIST.CODE (code list \'LIDL_OWIMFH\' and \'LIDL_COMPLTYPE_US\')
            LDL: P_LEW_CORE.T_REF_MDM_COMPLETION_TYPE.MDM_COMPLETION_TYPE_CD'''),
nfpo_us_completion_type_name STRING(100) NOT NULL
OPTIONS(description='''NFPO completion type name.
            CBX: CNT_CODELIST.NAME (code list \'LIDL_OWIMFH\' and \'LIDL_COMPLTYPE_US\')
            LDL: P_LEW_CORE.T_REF_MDM_COMPLETION_TYPE.MDM_COMPLETION_TYPE_NAME'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_COMPLETION_TYPE.DWH_CREATED'''),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_COMPLETION_TYPE.DWH_UPDATED'''),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_us_completion_type_cd) NOT ENFORCED
) OPTIONS(description='NFPO completion type codes, different codes are used for different markets.');