CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_DESPATCH_ADVICE_DIFFERENCE_1 (
   client_id                                COMMENT 'DWH-Mandant_1; FK auf CLIENT'
  ,wh_loc_sid                               COMMENT 'Surrogate Key warehouse, foreign key on location.'
  ,despatch_advice_diff_sid                 COMMENT 'Surrogate Key based on difference per despatch advice (and warehouse). Usually one line for all differences per item.
C0025_despatch_adviceid and C0025_id'
  ,despatch_advice_id                       COMMENT 'Reference to a despatch advice, if a despatch advice technically has been used in the counting process.'
  ,despatch_advice_diff_nr                  COMMENT 'Number of the individual item_1 difference entered for a despatch advice delivered. It is the row number of the difference in the source system, the natural key.'
  ,src_orig_wh_nr                           COMMENT 'Techn. identifier of warehouses in WAWI source system.'
  ,diff_create_dt                           COMMENT 'Date on which the despatch advice difference item_1 was entered.'
  ,diff_create_tmsp                         COMMENT 'Point in time at which the despatch advice difference item_1 was entered.'
  ,diff_change_dt                           COMMENT 'Date on which the despatch advice difference item_1 was modified.'
  ,diff_change_tmsp                         COMMENT 'Point in time at which the despatch advice difference item_1 was modified.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'Differences between despatch advices and purchase orders, checked at the warehouse.
Source: WAWI table: T0025_DESPATCH_ADVICE_DIFFERENCES'
AS SELECT
   client_id
  ,wh_loc_sid
  ,despatch_advice_diff_sid
  ,despatch_advice_id
  ,despatch_advice_diff_nr
  ,src_orig_wh_nr
  ,diff_create_dt
  ,diff_create_tmsp
  ,diff_change_dt
  ,diff_change_tmsp
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_DESPATCH_ADVICE_DIFFERENCE_1
;