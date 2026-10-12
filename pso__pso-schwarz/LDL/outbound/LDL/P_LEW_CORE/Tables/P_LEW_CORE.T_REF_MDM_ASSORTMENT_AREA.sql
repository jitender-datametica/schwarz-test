/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_assortment_area
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:19:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_assortment_area (
mdm_assortment_area_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''code of the NFPO assortment area
            CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT5  (code list \'REPORT_AF_PILLAR_PRODUCTCATEGORY\')'''),
mdm_assortment_area_name STRING(100) NOT NULL
OPTIONS(description='''name of the NFPO asortment area
            CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT3  (code list \'REPORT_AF_PILLAR_PRODUCTCATEGORY\')'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_assortment_area_id) NOT ENFORCED
)
OPTIONS(description='''codes for NFPO assortment area
             CBX: CNT_CODELIST (code list "REPORT_AF_PILLAR_PRODUCTCATEGORY")''');