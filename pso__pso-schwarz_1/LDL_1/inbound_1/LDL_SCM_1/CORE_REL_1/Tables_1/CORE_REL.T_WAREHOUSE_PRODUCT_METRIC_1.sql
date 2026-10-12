
CREATE TABLE CORE_REL.T_WAREHOUSE_PRODUCT_METRIC_1 (
   client_id                           NUMBER(38, 0)   NOT NULL COMMENT 'Unique identifier of Lidl Country_1',
   src_wh_id                           NUMBER(38, 0)   NOT NULL COMMENT 'The warehouse number ',
   orig_item_nr                        NUMBER(38, 0)   NOT NULL COMMENT 'Wawi Item_1 short number',
   case_size                           NUMBER(38, 5)   NOT NULL COMMENT 'Wawi Case size',
   bus_dt                              DATE            NOT NULL COMMENT 'Business Date ',
   metric_type_cd                      VARCHAR(20)     NOT NULL COMMENT 'The code identifying the type of metric which is collected for internal companies.',
   metric_qty                          NUMBER(38, 5)   COMMENT 'Metric quantity',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   CONSTRAINT PK_T_WAREHOUSE_PRODUCT_METRIC PRIMARY KEY (client_id, src_wh_id, orig_item_nr, case_size, bus_dt, metric_type_cd) NOT ENFORCED
 )  COMMENT= 'A table that stores KPI on the warehouse and products level on daily level';
