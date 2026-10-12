/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_assortment_area_2
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 13:12:10
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_ASSORTMENT_AREA_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_assortment_area_id             NUMBER(38,0)     NOT NULL,
   nfpo_assortment_area_name           VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ASSORTMENT_AREA PRIMARY KEY (nfpo_assortment_area_id) NOT ENFORCED 
)  COMMENT = 'codes for NFPO assortment area
             CBX:  CNT_CODELIST_2 (code list ''''REPORT_AF_PILLAR_PRODUCTCATEGORY'''')
             LDL-DWH: P_LEW_CORE.T_REF_MDM_ASSORTMENT_AREA_2';
