/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_list_type
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_list_type (
nfpo_list_type_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO codes for list types of items.
            CBX: CNT_CODELIST.CODE (code list \'LIDL_ASSORTMENT_TYPE\')
            LDL: P_LEW_CORE.T_REF_MDM_LIST_TYPE.MDM_LIST_TYPE_CD'''),
nfpo_list_type_name STRING(100)
OPTIONS(description='''NFPO names for list types of items.
            CBX: CNT_CODELIST.NAME (code list \'LIDL_ASSORTMENT_TYPE\')
            LDL: P_LEW_CORE.T_REF_MDM_LIST_TYPE.MDM_LIST_TYPE_NAME'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_CREATED'''),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_UPDATED'''),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_list_type_cd) NOT ENFORCED
) OPTIONS(description='Comment 2Do');