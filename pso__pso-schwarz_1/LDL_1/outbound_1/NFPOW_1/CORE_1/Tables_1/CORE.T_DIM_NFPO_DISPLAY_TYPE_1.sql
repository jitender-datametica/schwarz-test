/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_display_type_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_display_type_1 (
nfpo_display_type_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO display type code.
            CBX: CNT_CODELIST.CODE (code list \'LIDL_DISPLAYTYPE\')
            LDL: P_LEW_CORE.T_REF_MDM_DISPLAY_TYPE.DISPLAY_TYPE_CD'''),
nfpo_display_type_name STRING(100)
OPTIONS(description='''NFPO display type description.
            CBX: CNT_CODELIST.NAME (code list \'LIDL_DISPLAYTYPE\')
            LDL: P_LEW_CORE.T_REF_MDM_DISPLAY_TYPE.DISPLAY_TYPE'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_DISPLAY_TYPE.DWH_CREATED'''),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_DISPLAY_TYPE.DWH_UPDATED'''),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_display_type_cd) NOT ENFORCED
) OPTIONS(description='NFPO display types of items.');