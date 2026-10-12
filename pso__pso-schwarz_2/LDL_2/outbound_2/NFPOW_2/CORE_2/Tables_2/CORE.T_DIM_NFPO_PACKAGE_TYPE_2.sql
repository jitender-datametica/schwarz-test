/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_package_type_2
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_package_type_2 (
nfpo_pack_type_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO outer package_2 type codes for items.
            CBX: CNT_CODELIST.CODE (code list \'LIDL_PACKAGETYPE\')
            LDL: P_LEW_CORE.T_REF_MDM_PACKAGE_TYPE.PACKAGE_TYPE_CD'''),
nfpo_pack_type_name STRING(100)
OPTIONS(description='''NFPO outer package_2 type names for items (NETZ/TOPF/BOX usw.).
            CBX: CNT_CODELIST.NAME (code list \'LIDL_PACKAGETYPE\')
            LDL: P_LEW_CORE.T_REF_MDM_PACKAGE_TYPE.PACKAGE_TYPE_NAME'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_PACKAGE_TYPE.DWH_CREATED'''),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_PACKAGE_TYPE.DWH_UPDATED'''),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_pack_type_cd) NOT ENFORCED
) OPTIONS(description='NFPO outer package_2 type for items (NETZ/TOPF/BOX usw.).');