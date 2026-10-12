/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_client_order
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 13:31:35
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_item_sid                        NUMBER(38,0)     NOT NULL COMMENT 'foreign key NFPO item instance
            CBX: CNT_ITEM.REF_NO',
   client_id_order                     NUMBER(38,0)     NOT NULL COMMENT 'foreign key client (placing order), derived from the identifier of the local NFPO in the NFPO source system
            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE',
   int_org_sid                         NUMBER(38,0)     COMMENT 'surrogate key internal organisation, here the local NFPO the order is related to
            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE',
   client_cd                           VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'identifier of the local NFPO in the NFPO source system, used to identify a representing Lidl client in the set of Lidl ERP clients
            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE',
   client_block_id_order               NUMBER(38,0)     NOT NULL COMMENT 'foreign key Country Block
            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MDM_ITEM_CLIENT_ORDER PRIMARY KEY (mdm_item_sid, client_id_order) NOT ENFORCED 
)  COMMENT = 'order information of NFPO items for the local NFPOs
             CBX: LDL_ITEM_QUANTITY';
