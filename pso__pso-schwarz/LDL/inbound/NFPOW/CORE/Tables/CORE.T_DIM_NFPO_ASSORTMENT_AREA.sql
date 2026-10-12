/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_assortment_area
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 09:33:39
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_ASSORTMENT_AREA DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_assortment_area_id             NUMBER(38,0)     NOT NULL COMMENT 'code of the NFPO assortment area
            CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT5  (code list ''REPORT_AF_PILLAR_PRODUCTCATEGORY'')
            LDL: P_LEW_CORE.T_REF_MDM_ASSORTMENT_AREA.MDM_ASSORTMENT_AREA_ID',
   nfpo_assortment_area_name           VARCHAR(100)     COMMENT 'name of the NFPO asortment area
            CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT3  (code list ''REPORT_AF_PILLAR_PRODUCTCATEGORY'')
            LDL: P_LEW_CORE.T_REF_MDM_ASSORTMENT_AREA.MDM_ASSORTMENT_AREA_NAME',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_ASSORTMENT_AREA PRIMARY KEY (nfpo_assortment_area_id) NOT ENFORCED 
)  COMMENT = 'codes for NFPO assortment area
             CBX:  CNT_CODELIST (code list ''''REPORT_AF_PILLAR_PRODUCTCATEGORY'''')
             LDL-DWH: P_LEW_CORE.T_REF_MDM_ASSORTMENT_AREA
             CORE_REL: T_NFPO_ASSORTMENT_AREA';
