/* --------------------------------------------------------------------------------
   DDL for table: t_replenish_order_wh_record_pos_changelog
   generated from Powerdesigner on Donnerstag, 19. Januar 2023 17:11:53
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REPLENISH_ORDER_WH_RECORD_POS_CHANGELOG (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'Unique identifier of the DWH client / slice.',
   loc_sid                             NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key LOCATION (unique across all countries / clients).',
   order_record_id                     VARCHAR(20)     NOT NULL COMMENT 'Order number: src_orig_supplier_nr (4 digits), date (DDMMYY, 6 digits) and counting version number (2 digits) for supllier - Date combination; Wawi: PO_NR',
   change_seq                          NUMBER(38,0)    NOT NULL COMMENT 'Number of the version of the order position. Counts up, whenever a change is made to the delivery position.',
   item_sid                            NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key ITEM (unique across all countries / clients).',
   old_order_qty                       NUMBER(38,5)    COMMENT 'Order quantity of the article before the change.',
   new_order_qty                       NUMBER(38,5)    COMMENT 'Order quantity of the article after the change.',
   old_order_deliv_dt                  DATE            COMMENT 'Date of the delivery before the change.',
   new_order_deliv_dt                  DATE            COMMENT 'Date of the delivery after the change.',
   old_order_deliv_tm                  TIME(0)         COMMENT 'Time of the delivery before the change',
   new_order_deliv_tm                  TIME(0)         COMMENT 'Time of the delivery after the change',
   mod_dt                              DATE            COMMENT 'Date of the modification',
   order_change_type_id                NUMBER(38,0)    COMMENT 'ID of the change type: 1 = Changed item in order (quantity, date, time); 2 = Added item, 3 = deleted item',
   order_change_src_id                 NUMBER(38,0)    COMMENT 'ID of the order change source: 1 = Internal change; 2 = External change; 3 = Other change',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier of the last loading, which added or updated the record.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the first insert of the record into the dwh.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the las update of the record in the dwh.',   
   CONSTRAINT PK_T_REPLENISH_ORDER_WH_RECORD_POS_CHANGELOG PRIMARY KEY (loc_sid, order_record_id, change_seq, item_sid) NOT ENFORCED 
)  COMMENT = 'Changes of orders from a supplier to the warehouse on item / order position level.Wawi: T129_orderchangeslog';