/* --------------------------------------------------------------------------------
   DDL for table: t_ref_order_change_source
   generated from Powerdesigner on Donnerstag, 19. Januar 2023 17:16:39
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_ORDER_CHANGE_SOURCE (
   order_change_src_id                 NUMBER(38,0)    NOT NULL COMMENT 'ID of the order change source: 1 = Internal change; 2 = External change; 3 = Other change.',
   order_change_src_descr              VARCHAR(250)    COMMENT 'Description of the order change source',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier of the last loading, which added or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the first insert of the record into the dwh.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the las update of the record in the dwh.',   
   CONSTRAINT PK_T_REF_ORDER_CHANGE_SOURCE PRIMARY KEY (order_change_src_id) NOT ENFORCED 
)  COMMENT = 'This minor dimension defines the values of the order change sources.';