/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_guarantee_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:31:47
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_GUARANTEE_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   guarantee_cd                        VARCHAR(100)     NOT NULL COMMENT 'NFPO warranty duration code
            CBX: CNT_CODELIST.CODE (codelist ''LIDL_WARRANTY'')',
   guarantee_descr                     VARCHAR(100)     COMMENT 'NFPO warranty duration name
            CBX: CNT_CODELIST.NAME (codelist ''LIDL_WARRANTY'')',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_GUARANTEE PRIMARY KEY (client_id, guarantee_cd) NOT ENFORCED 
)  COMMENT = 'NFPO guarantee length types of items
             CBX: CNT_CODELIST_1 (code list "LIDL_WARRANTY")';
