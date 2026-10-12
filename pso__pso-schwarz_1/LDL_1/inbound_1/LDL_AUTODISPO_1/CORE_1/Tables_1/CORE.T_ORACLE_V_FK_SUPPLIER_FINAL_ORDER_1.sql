--==============================================================
-- Table: t_oracle_v_fk_supplier_final_order_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_fk_supplier_final_order_1
   generated from Powerdesigner on Donnerstag, 13. Juni 2024 15:59:08
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_ORACLE_V_FK_SUPPLIER_FINAL_ORDER_1 (
   COUNTRY_1                             VARCHAR(2)      NOT NULL COMMENT 'Country_1; sourcefield: COUNTRY_1',
   WH                                  NUMBER(38,0)    NOT NULL COMMENT 'Number of a Warehouse; sourcefield: FO_SUPPLIER_WH',
   SUPPLIER_NR                         VARCHAR(16777216) NOT NULL COMMENT 'Identification number of supplier_1 of an warehouse; sourcefield: FO_SUPPLIER_NR',
   ITEM_NR                             VARCHAR(16777216) NOT NULL COMMENT 'Global item_1 number, item_nr is equal to other xx_item_nr from other tables; sourcefield: FO_ITEM_NR',
   ITEM_PACKAGECAPACITY                NUMBER(38,3)    NOT NULL COMMENT 'Amount of salesitems that can be placed in one case; sourcefield: FO_ITEM_PACKAGECAPACITY',
   CALCULATION_NUMBER                  VARCHAR(30)     NOT NULL COMMENT 'Number of an order; sourcefield: FO_CALCULATION_NUMBER',
   IS_SENT_FG                          NUMBER(38,0)    NOT NULL COMMENT 'Check if order was sent to supplier_1 (No = 0, Yes = 1); sourcefield: FO_IS_SENT',
   ORDER_SENT_DATE                     TIMESTAMP_LTZ(9)   NOT NULL COMMENT 'Date when an order was sent to a supplier_1; sourcefield: FO_SENDING_TIME',
   ORDERS_ARRIVAL_DATE                 DATE            NOT NULL COMMENT 'Date when an order will be delivered to a warehouse; sourcefield: FO_DELIVERY_DATE',
   GENERATION_DATE                     TIMESTAMP_LTZ(9)   NOT NULL COMMENT 'Date of the creation of an order; sourcefield: FO_GENERATION_DATE',
   ORDER_UNIT_ID                       NUMBER(38,0)    COMMENT 'Packaging unit_1 that was used for an order (piece, colli = 0, layer = 1, DD = 2, EP = 3); sourcefield: FO_ORDER_UNIT_ID',
   ORDER_UNIT_QUANTITY                 NUMBER(38,0)    COMMENT 'Amount of pieces used in a packaging unit_1 (Field ORDER_UNIT_ID); sourcefield: FO_ORDER_UNIT_QUANTITY',
   CORRECTED_ORDER_UNIT_QUANTITY       NUMBER(38,0)    COMMENT 'Correction of amount of purchase order quantity unit_1 by a user in UI-Panel; sourcefield: FO_CORRECTED_ORDER_UNIT_QUANTITY',
   CORRECTED_ORDER_UNIT_ID             NUMBER(38,0)    COMMENT 'Correction of purchase order quantity unit_1 by a user in UI-Panel; sourcefield: FO_CORRECTED_ORDER_UNIT_ID',
   MOD_DATE                            TIMESTAMP_LTZ(9)   NOT NULL COMMENT 'Timestamp of altering entries inside the table, is usually null. Sourcefield: mod_date',
   SOURCE_EXTRACTION_TMSP              TIMESTAMP_LTZ(9)   NOT NULL COMMENT 'Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.',
   SNFLK_INSERT_TMSP                   TIMESTAMP_LTZ(9)   NOT NULL COMMENT 'Date/Time combination added in the Snowflake loading process.',
   SNFLK_UPDATE_TMSP                   TIMESTAMP_LTZ(9)   NOT NULL COMMENT 'Date/Time combination added in the Snowflake table update process.',   
   CONSTRAINT PK_T_ORACLE_V_FK_SUPPLIER_FINAL_ORDER PRIMARY KEY (country_1, wh, supplier_nr, item_nr, item_packagecapacity, calculation_number, is_sent_fg, order_sent_date, orders_arrival_date, generation_date) NOT ENFORCED 
)  COMMENT = 'Orders created via ADL-System; Sourcetable FO_SUPPLIER_FINAL_ORDER';
