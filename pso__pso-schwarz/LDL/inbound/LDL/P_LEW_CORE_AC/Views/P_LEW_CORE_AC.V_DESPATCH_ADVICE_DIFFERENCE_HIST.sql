CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_DESPATCH_ADVICE_DIFFERENCE_HIST (
   client_id                                COMMENT 'DWH-Mandant; FK auf CLIENT'
  ,wh_loc_sid                               COMMENT 'Surrogate Key warehouse, foreign key on location.'
  ,despatch_advice_diff_sid                 COMMENT 'Surrogate Key based on difference per despatch advice (and warehouse).
C0025_despatch_adviceid and C0025_id'
  ,ordered_gtin                             COMMENT 'Global Trade Item Number (GTIN) of the article ordered from the supplier.'
  ,received_gtin                            COMMENT 'Global Trade Item Number (GTIN) of the article received from the supplier.'
  ,ordered_item_sid                         COMMENT 'Surrogate key of the article ordered from the supplier.'
  ,received_item_sid                        COMMENT 'Surrogate key of the article received from the supplier.'
  ,order_record_id                          COMMENT 'Order number: src_orig_supplier_nr (4 digits), date (DDMMYY, 6 digits) and counting version number (2 digits) for supllier - Date combination; Wawi: PO_NR.'
  ,despatch_advice_diff_status_id           COMMENT 'Status of the despatch advice differences.'
  ,diff_accepted_fg                         COMMENT 'Flag: Set if difference is accepted.'
  ,remark_fg                                COMMENT 'Flag: Set if remark exists.'
  ,remark_txt                               COMMENT 'Remark entered for the despatch advice difference.'
  ,partial_delivery_fg                      COMMENT 'Flag: Set if partial delivery was accepted.'
  ,deleted_fg                               COMMENT 'Attribute set was not delivered by source system (anymore), if deleted_fg=1.'
  ,dwh_valid_from                           COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'
  ,dwh_valid_to                             COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'This table contains historized changes to differences found in despatch advices at the warehouse.
Source: WAWI table: T0025_DESPATCH_ADVICE_DIFFERENCES'
AS SELECT
   client_id
  ,wh_loc_sid
  ,despatch_advice_diff_sid
  ,ordered_gtin
  ,received_gtin
  ,ordered_item_sid
  ,received_item_sid
  ,order_record_id
  ,despatch_advice_diff_status_id
  ,diff_accepted_fg
  ,remark_fg
  ,remark_txt
  ,partial_delivery_fg
  ,deleted_fg
  ,dwh_valid_from
  ,dwh_valid_to
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_DESPATCH_ADVICE_DIFFERENCE_HIST
;