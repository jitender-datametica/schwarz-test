/* --------------------------------------------------------------------------------
   DDL for table: t_despatch_advice_difference_hist_2
   generated from Powerdesigner on Tuesday, February 4, 2025 12:09:33 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_DESPATCH_ADVICE_DIFFERENCE_HIST_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   wh_loc_sid                          NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key warehouse, foreign key on location.',
   despatch_advice_diff_sid            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key based on difference per despatch advice (and warehouse).
            C0025_despatch_adviceid and C0025_id',
   ordered_gtin                        VARCHAR(14)      COMMENT 'Global Trade Item_2 Number (GTIN) of the article ordered from the supplier.',
   received_gtin                       VARCHAR(14)      COMMENT 'Global Trade Item_2 Number (GTIN) of the article received from the supplier.',
   ordered_item_sid                    NUMBER(38,0)     COMMENT 'Surrogate key of the article ordered from the supplier.',
   received_item_sid                   NUMBER(38,0)     COMMENT 'Surrogate key of the article received from the supplier.',
   order_record_id                     VARCHAR(100)     COMMENT 'Order number: src_orig_supplier_nr (4 digits), date (DDMMYY, 6 digits) and counting version number (2 digits) for supllier - Date combination; Wawi: PO_NR.',
   despatch_advice_diff_status_id      NUMBER(38,0)     NOT NULL COMMENT 'Status_2 of the despatch advice differences.',
   diff_accepted_fg                    NUMBER(38,0)     COMMENT 'Flag: Set if difference is accepted.',
   remark_fg                           NUMBER(38,0)     COMMENT 'Flag: Set if remark exists.',
   remark_txt                          VARCHAR(1000)    COMMENT 'Remark entered for the despatch advice difference.',
   partial_delivery_fg                 NUMBER(38,0)     COMMENT 'Flag: Set if partial delivery was accepted.',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Attribute set was not delivered by source system (anymore), if deleted_fg=1.',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_DESPATCH_ADVICE_DIFFERENCE_HIST PRIMARY KEY (despatch_advice_diff_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'This table contains historized changes to differences found in despatch advices at the warehouse.
             Source: WAWI table: T0025_DESPATCH_ADVICE_DIFFERENCES';
