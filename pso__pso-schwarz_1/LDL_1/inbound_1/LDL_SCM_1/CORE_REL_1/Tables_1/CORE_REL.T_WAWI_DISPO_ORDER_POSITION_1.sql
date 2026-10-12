CREATE TABLE CORE_REL.T_WAWI_DISPO_ORDER_POSITION_1 (
   client_id                           NUMBER(38, 0)   NOT NULL COMMENT 'Unique identifier of Lidl Country_1',
   country_cd                          VARCHAR(160),
   wh_nr                               VARCHAR(20),
   dispo_order_nr                      VARCHAR(200)    NOT NULL COMMENT 'Order number',
   seq_nr                              VARCHAR(20)     NOT NULL COMMENT 'Consecutive numbers that are assigned by the dispo module when the order is generated',
   orig_item_nr                        NUMBER(38, 0),
   orig_supplier_nr                    VARCHAR(20),
   case_size                           NUMBER(38, 5),
   uom_cd                              VARCHAR(20)     COMMENT 'Unit_1 of measurement for the quantity of an item_1 that is ordered or purchased',
   order_qty                           NUMBER(38, 5)   COMMENT 'Ordered product quantity',
   deliv_dt                            DATE            COMMENT 'Delivery Date',
   posted_dt                           DATE            COMMENT 'The date when the delivery was recorded in the system.',
   order_status_cd                     VARCHAR(20)     COMMENT 'Order status_1 code ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   CONSTRAINT PK_T_WAWI_DISPO_ORDER_POSITION PRIMARY KEY (client_id, dispo_order_nr, seq_nr) NOT ENFORCED
 )  COMMENT= 'A table that stores  detailed information about dispo orders';