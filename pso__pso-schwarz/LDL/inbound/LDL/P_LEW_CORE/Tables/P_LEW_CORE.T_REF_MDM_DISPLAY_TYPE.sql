/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_display_type
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:28:57
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_DISPLAY_TYPE (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   display_type_cd                     VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'NFPO display type code
            CBX: CNT_CODELIST.CODE (codelist ''LIDL_DISPLAYTYPE'')',
   display_type                        VARCHAR(100)     COLLATE 'en-ci' COMMENT 'NFPO display type description
            CBX: CNT_CODELIST.NAME (codelist ''LIDL_DISPLAYTYPE'')',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_DISPLAY_TYPE PRIMARY KEY (client_id, display_type_cd) NOT ENFORCED 
)  COMMENT = 'NFPO display types of items
             CBX: CNT_CODELIST (code list "LIDL_DISPLAYTYPE")';
