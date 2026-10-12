/* --------------------------------------------------------------------------------
   DDL for table: t_store_order_area_time_range_hist_1
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_STORE_ORDER_AREA_TIME_RANGE_HIST_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1',
   loc_sid_store                       NUMBER(38,0)     NOT NULL COMMENT 'store that wants to order',
   order_area_sid                      NUMBER(38,0)     NOT NULL COMMENT 'order area that is relevant for the order',
   loc_sid_wh                          NUMBER(38,0)     NOT NULL COMMENT 'warehouse, at which the order is placed',
   wh_order_time_range_sid             NUMBER(38,0)     NOT NULL COMMENT 'time range relevant for the Store, if items of the specified order area at the WH are ordered',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'indication, whether the relationship is still active (deleted_fg = 0) or inactive (deleted_fg = 1)',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_STORE_ORDER_AREA_TIME_RANGE_HIST PRIMARY KEY (loc_sid_store, loc_sid_wh, order_area_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Definition of which order times are relevant for a store that orders items of a specific order area of a WH in order to guarantee a delivery in time';

