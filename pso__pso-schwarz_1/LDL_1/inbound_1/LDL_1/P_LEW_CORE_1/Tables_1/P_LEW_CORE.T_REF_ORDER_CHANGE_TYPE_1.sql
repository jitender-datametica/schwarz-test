/* --------------------------------------------------------------------------------
   DDL for table: t_ref_order_change_type_1
   generated from Powerdesigner on Donnerstag, 19. Januar 2023 17:14:43
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_ORDER_CHANGE_TYPE_1 (
   order_change_type_id                NUMBER(38,0)    NOT NULL COMMENT 'ID of the change type: 1 = Changed item_1 in order (quantity, date, time); 2 = Added item_1, 3 = deleted item.',
   order_change_type_descr             VARCHAR(250)    COMMENT 'Description of the change type',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier of the last loading, which added or updated the record.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the first insert of the record into the dwh.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the las update of the record in the dwh.',   
   CONSTRAINT PK_T_REF_ORDER_CHANGE_TYPE PRIMARY KEY (order_change_type_id) NOT ENFORCED 
)  COMMENT = 'This minor dimension defines the values of the order change types.';