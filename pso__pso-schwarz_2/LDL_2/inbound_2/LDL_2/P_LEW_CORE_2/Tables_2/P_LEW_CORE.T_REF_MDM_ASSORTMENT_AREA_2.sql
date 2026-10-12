/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_assortment_area_2
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:19:35
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_ASSORTMENT_AREA_2 (
   mdm_assortment_area_id              NUMBER(38,0)     NOT NULL COMMENT 'code of the NFPO assortment area
            CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT5  (code list ''REPORT_AF_PILLAR_PRODUCTCATEGORY'')',
   mdm_assortment_area_name            VARCHAR(100)     NOT NULL COMMENT 'name of the NFPO asortment area
            CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT3  (code list ''REPORT_AF_PILLAR_PRODUCTCATEGORY'')',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_ASSORTMENT_AREA PRIMARY KEY (mdm_assortment_area_id) NOT ENFORCED 
)  COMMENT = 'codes for NFPO assortment area
             CBX: CNT_CODELIST_2 (code list "REPORT_AF_PILLAR_PRODUCTCATEGORY")';
