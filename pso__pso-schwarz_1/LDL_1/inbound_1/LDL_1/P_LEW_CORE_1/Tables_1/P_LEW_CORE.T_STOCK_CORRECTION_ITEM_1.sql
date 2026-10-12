/* --------------------------------------------------------------------------------
   DDL for table: t_stock_correction_item_1
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_STOCK_CORRECTION_ITEM_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   loc_sid_wh                          NUMBER(38,0)     NOT NULL COMMENT 'warehouse, foreign key on location_1, in general the initiator of requests ',
   request_id                          NUMBER(38,0)     NOT NULL COMMENT 'Inventory ID',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM_1 (eindeutig ueber alle Laender/Mandanten hinweg)',
   cnt_reason_id                       NUMBER(38,0)     COMMENT 'id of the counting reason for stock correction requests',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_STOCK_CORRECTION_ITEM PRIMARY KEY (loc_sid_wh, request_id, item_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. table contains items for counting requests for stores to correct item_1 related stock information;
             Source: WAWI table T438_PART_INV_DET';

