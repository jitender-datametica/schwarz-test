--==============================================================
-- Table: t_oracle_v_fk_supplier_order
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_fk_supplier_order
   generated from Powerdesigner on Donnerstag, 13. Juni 2024 15:47:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_ORACLE_V_FK_SUPPLIER_ORDER (
   COUNTRY                             VARCHAR(2)      NOT NULL COMMENT 'Country; sourcefield: COUNTRY',
   WH                                  NUMBER(38,0)    NOT NULL COMMENT 'Number of a Warehouse; sourcefield: SUPPLIER_WH',
   SUPPLIER_NR                         VARCHAR(16777216) NOT NULL COMMENT 'Identification number of supplier of an warehouse; sourcefield: SUPPLIER_NR',
   ITEM_NR                             VARCHAR(16777216) NOT NULL COMMENT 'Global item number, item_nr is equal to other xx_item_nr from other tables; sourcefield: ITEM_NR',
   ITEM_PACKAGECAPACITY                NUMBER(38,3)    NOT NULL COMMENT 'Amount of salesitems that can be placed in one case; sourcefield: ITEM_PACKAGECAPACITY',
   ORDER_NR                            NUMBER(38,0)    NOT NULL COMMENT 'Number of an order; sourcefield: ORDER_NR',
   ORDER_SENT_DATE                     DATE            NOT NULL COMMENT 'Date when an order was sent to a supplier; sourcefield: ORDER_SENT',
   ORDERS_ARRIVAL_DATE                 DATE            NOT NULL COMMENT 'Date when an order will be delivered to a warehouse; sourcefield: ORDERS_ARRIVAL_DATE',
   ORDER_UNIT_ID                       NUMBER(38,0)    COMMENT 'Packaging unit that was used for an order (piece, colli = 0, layer = 1, DD = 2, EP = 3); sourcefield: ORDER_UNIT_ID',
   ORDERS_OUTSTANDING                  NUMBER(38,0)    COMMENT 'Open orders for a specific item (past view); sourcefield: ORDERS_OUTSTANDING',
   ORDERS_FUTURE                       NUMBER(38,0)    COMMENT 'Open orders for a specific item (future view); sourcefield: ORDERS_FUTURE',
   ORDERS_TOTAL                        NUMBER(38,0)    COMMENT 'Sum of open orders (outstanding + total); sourcefield: ORDERS_TOTAL',
   MOD_DATE                            TIMESTAMP_NTZ(9)   NOT NULL COMMENT 'Timestamp of altering entries inside the table, is usually null. Sourcefield: mod_date',
   SOURCE_EXTRACTION_TMSP              TIMESTAMP_LTZ(9)   NOT NULL COMMENT 'Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.',
   SNFLK_INSERT_TMSP                   TIMESTAMP_LTZ(9)   NOT NULL COMMENT 'Date/Time combination added in the Snowflake loading process.',
   SNFLK_UPDATE_TMSP                   TIMESTAMP_LTZ(9)   NOT NULL COMMENT 'Date/Time combination added in the Snowflake table update process.',   
   CONSTRAINT PK_T_ORACLE_V_FK_SUPPLIER_ORDER PRIMARY KEY (country, wh, supplier_nr, order_nr, item_nr, item_packagecapacity, orders_arrival_date, order_sent_date) NOT ENFORCED 
)  COMMENT = 'Orders created via DIS-System; Sourcetable FO_SUPPLIER_ORDER';