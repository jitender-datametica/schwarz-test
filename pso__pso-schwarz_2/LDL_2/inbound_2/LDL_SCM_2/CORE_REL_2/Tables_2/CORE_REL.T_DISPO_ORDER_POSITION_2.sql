/* --------------------------------------------------------------------------------
   DDL for table: t_dispo_order_position_2
   generated from Powerdesigner on Donnerstag, 28. August 2025 15:19:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_DISPO_ORDER_POSITION_2 (
   client_id                           NUMBER(38, 0)   NOT NULL COMMENT 'Unique identifier of Lidl Country_2',
   country_cd                          VARCHAR(160)    COMMENT 'The code identifying the country_2 according to ISO 3166.',
   wh_nr                               VARCHAR(20)     COMMENT 'The number of a warehouse in WAWI',
   dispo_order_nr                      VARCHAR(200)    NOT NULL COMMENT 'Order number in dource system WAWI/LeXXI',
   dispo_order_pos_nr                  VARCHAR(20)     NOT NULL COMMENT 'Consecutive numbers that are assigned by the dispo module when the order is generated',
   orig_item_nr                        NUMBER(38, 0)   COMMENT 'A short item_2 number from Wawi',
   orig_supplier_nr                    VARCHAR(20)     COMMENT 'A number identifying supplier_2 in Wawi',
   case_size                           NUMBER(38, 5)   COMMENT 'The number of individual items that are contained in the logistic variant. (Note that the individual item_2 represents the smallest sellable unit. E.g. if a packed try of meat contains two slices, the entire tray is considered one sellable unit.)',
   case_per_pallet_cnt                 NUMBER(38, 0)   COMMENT 'The number of cases which can be packed on a standard pallet. ',
   src_ian_nr                          VARCHAR(20)     COMMENT 'International Article Number',
   src_gtin_nr                         VARCHAR(20)     COMMENT 'The Global Trade Item_2 Number (GTIN) that identifies this item_2 variant.',
   uom_cd                              VARCHAR(20)     COMMENT 'Unit_2 of measurement for the quantity of an item_2 that is ordered or purchased',
   order_qty                           NUMBER(38, 5)   COMMENT 'Ordered product quantity',
   deliv_dt                            DATE            COMMENT 'Delivery Date',
   posted_dt                           DATE            COMMENT 'The date when the delivery was recorded in the system.',
   order_status_cd                     VARCHAR(20)     COMMENT 'Order status_2 code ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   CONSTRAINT PK_T_DISPO_ORDER_POSITION PRIMARY KEY (client_id, dispo_order_nr, dispo_order_pos_nr) NOT ENFORCED
 )  COMMENT= 'A table that stores  detailed information about dispo orders';
