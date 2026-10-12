CREATE TABLE CORE_REL.T_STOCK_BY_WAREHOUSE_PRODUCT_MONTH (
   cal_month                           NUMBER(38, 0)   NOT NULL COMMENT 'The identifier of a calendar month in the form YYYYMM. E.g. 202101 für January 2021.',
   client_id                           NUMBER(38, 0)   NOT NULL COMMENT 'Unique identifier of Lidl Country',
   src_wh_id                           NUMBER(38, 0)   NOT NULL COMMENT 'The warehouse number ',
   orig_item_nr                        NUMBER(38, 0)   NOT NULL COMMENT 'Wawi Item short number',
   case_size                           NUMBER(38, 5)   NOT NULL COMMENT 'Wawi Case size',
   stock_qty                           NUMBER(38, 5)   COMMENT 'Stock quantity',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   CONSTRAINT PK_T_STOCK_BY_WAREHOUSE_PRODUCT_MONTH PRIMARY KEY (cal_month, client_id, src_wh_id, orig_item_nr, case_size) NOT ENFORCED
 )  COMMENT= 'A table that stores KPI on the warehouse and products level on weekly and monthly level';
