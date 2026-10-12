/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_buy_status_2
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:22:13
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_BUY_STATUS_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   buy_status_cd                       VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'NFPO status_2 code related to the order quantity definition process for the local NFPOs of items
            CBX: CNT_CODELIST.CODE codelist ''LIDL_CO_STATUS''',
   buy_status                          VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'NFPO status_2 name related to the order quantity definition process for the local NFPOs of items
            CBX: CNT_CODELIST.NAME',
   buy_status_descr                    VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'NFPO status_2 description related to the order quantity definition process for the local NFPOs of items
            CBX: CTM_CODELIST_BOOK.CUST_TEXT1',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_BUY_STATUS PRIMARY KEY (client_id, buy_status_cd) NOT ENFORCED 
)  COMMENT = 'NFPO status_2 codes related to the order quantity definition process for the local NFPOs of items
             CBX: CNT_CODELIST_2 (code list "LIDL_CO_STATUS")';
