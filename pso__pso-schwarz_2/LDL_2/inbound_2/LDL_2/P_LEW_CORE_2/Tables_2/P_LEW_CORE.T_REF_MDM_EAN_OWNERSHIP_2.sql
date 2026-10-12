/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_ean_ownership_2
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:30:53
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_EAN_OWNERSHIP_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   ean_ownership_cd                    VARCHAR(100)     NOT NULL COMMENT 'NFPO GTIN assignement responisbility code
            CBX: CNT_CODELIST.CODE (codelist ''LIDL_GTIN_OUTPUT'')',
   ean_ownership                       VARCHAR(100)     COLLATE 'en-ci' COMMENT 'NFPO GTIN assignement responisbility description
            CBX: CNT_CODELIST.NAME (codelist ''LIDL_GTIN_OUTPUT'')',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_EAN_OWNERSHIP PRIMARY KEY (ean_ownership_cd) NOT ENFORCED 
)  COMMENT = 'NFPO responsibilty of GTIN assignement to items
             CBX: CNT_CODELIST_2 (code list "LIDL_GTIN_OUTPUT")';
