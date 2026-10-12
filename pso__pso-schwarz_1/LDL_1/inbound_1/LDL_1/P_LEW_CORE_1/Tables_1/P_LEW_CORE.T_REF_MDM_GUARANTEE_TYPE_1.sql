/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_guarantee_type_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:32:43
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_GUARANTEE_TYPE_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   guarantee_type_cd                   VARCHAR(100)     NOT NULL COMMENT 'NFPO warranty type code
            CBX: CNT_CODELIST.CODE (codelist ''LIDL_WARRANTY_ART'')',
   guarantee_type_descr                VARCHAR(100)     COMMENT 'NFPO warranty type description
            CBX: CNT_CODELIST.NAME (codelist ''LIDL_WARRANTY_ART'')',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_GUARANTEE_TYPE PRIMARY KEY (client_id, guarantee_type_cd) NOT ENFORCED 
)  COMMENT = 'NFPO guarantee types of items
             CBX: CNT_CODELIST_1 (code list "LIDL_WARRANTY_ART")';
