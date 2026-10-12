/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_item_class_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:37:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_ITEM_CLASS_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   item_class_cd                       VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'NFPO item_1 classification code related to item_1 creation and usage over time
            CBX: CNT_CODELIST.CODE (codelist ''LIDL_ARTICLETYPE'')',
   item_class                          VARCHAR(100)     COLLATE 'en-ci' COMMENT 'NFPO item_1 classification description related to item_1 creation and usage over time
            CBX: CTM_CODELIST_BOOK.CUST_TEXT1 (codelist ''LIDL_ARTICLETYPE'')',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_ITEM_CLASS PRIMARY KEY (client_id, item_class_cd) NOT ENFORCED 
)  COMMENT = 'NFPO item_1 classification related to item_1 creation and usage over time
             CBX: CNT_CODELIST_1 (code list "LIDL_ARTICLETYPE")';
