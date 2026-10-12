/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_sup_ship_terms_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:47:33
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_SUP_SHIP_TERMS_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   sup_ship_terms_cd                   VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'NFPO supplier_1 related shipping term codes
            CBX: CNT_CODELIST.CODE (codelist ''LDL_WBP_CAL_PROFILE'')',
   sup_ship_terms                      VARCHAR(100)     COLLATE 'en-ci' COMMENT 'NFPO supplier_1 related shipping term names
            CBX: CNT_CODELIST.NAME (codelist ''LDL_WBP_CAL_PROFILE'')',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_SUP_SHIP_TERMS PRIMARY KEY (sup_ship_terms_cd) NOT ENFORCED 
)  COMMENT = 'NFPO supplier_1 related shipping terms
             CBX: CNT_CODELIST_1 (code list "LDL_WBP_CAL_PROFILE")';
