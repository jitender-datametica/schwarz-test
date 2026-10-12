/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_assortment_area_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 09:33:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_assortment_area_1 (
nfpo_assortment_area_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''code of the NFPO assortment area
            CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT5  (code list \'REPORT_AF_PILLAR_PRODUCTCATEGORY\')
            LDL: P_LEW_CORE.T_REF_MDM_ASSORTMENT_AREA.MDM_ASSORTMENT_AREA_ID'''),
nfpo_assortment_area_name STRING(100)
OPTIONS(description='''name of the NFPO asortment area
            CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT3  (code list \'REPORT_AF_PILLAR_PRODUCTCATEGORY\')
            LDL: P_LEW_CORE.T_REF_MDM_ASSORTMENT_AREA.MDM_ASSORTMENT_AREA_NAME'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_assortment_area_id) NOT ENFORCED
) OPTIONS(description='''codes for NFPO assortment area
             CBX:  CNT_CODELIST_1 (code list \'\'REPORT_AF_PILLAR_PRODUCTCATEGORY \'\')
             LDL-DWH: P_LEW_CORE.T_REF_MDM_ASSORTMENT_AREA_1
             CORE_REL: T_NFPO_ASSORTMENT_AREA_1''');