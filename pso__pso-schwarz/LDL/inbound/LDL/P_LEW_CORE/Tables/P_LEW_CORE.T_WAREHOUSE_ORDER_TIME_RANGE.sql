/* --------------------------------------------------------------------------------
   DDL for table: t_warehouse_order_time_range
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_WAREHOUSE_ORDER_TIME_RANGE CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'Mandant',
   wh_order_time_range_sid             NUMBER(38,0)     NOT NULL COMMENT 'surrogate key; uniquely identifies a WH Order Time Range',
   src_orig_wh_nr                      VARCHAR(20)      COMMENT 'techn. identifier of the WH within WAWI surce system',
   src_range_zone_id                   VARCHAR(20)      COMMENT 'techn. identifier of the time range within WAWI source system',
   loc_sid_wh                          NUMBER(38,0)     NOT NULL COMMENT 'WH for which the time range is defined',
   order_time_range_name               VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'name that describes the order time range',
   order_time_plan_id                  NUMBER(38,0)     NOT NULL COMMENT 'order time plan to which the specific order time range belongs (master data missing)',
   order_time_from_tm                  TIME(0)          COMMENT 'begin time of the order time range',
   order_time_to_tm                    TIME(0)          COMMENT 'end time of the order time range',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_WAREHOUSE_ORDER_TIME_RANGE PRIMARY KEY (wh_order_time_range_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Time ranges defined by WH. Orders need to be placed within those time ranges, in order to guarantee a shipment in time (e.g. next day). ';

