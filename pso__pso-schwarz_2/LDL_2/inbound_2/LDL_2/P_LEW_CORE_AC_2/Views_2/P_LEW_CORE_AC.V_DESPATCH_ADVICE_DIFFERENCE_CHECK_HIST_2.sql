CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_DESPATCH_ADVICE_DIFFERENCE_CHECK_HIST_2 (
   client_id                                COMMENT 'DWH-Mandant_2; FK auf CLIENT'
  ,wh_loc_sid                               COMMENT 'Surrogate Key warehouse, foreign key on location.'
  ,despatch_advice_diff_sid                 COMMENT 'Surrogate Key based on difference per despatch advice (and warehouse).
C0025_despatch_adviceid and C0025_id'
  ,despatch_advice_check_type_id            COMMENT 'Code of the despatch advice difference check type.'
  ,despatch_advice_check_type_fg            COMMENT 'Flag: Set if difference exists.'
  ,despatch_advice_check_type_value_id      COMMENT 'Code of the check type value for differences checked'
  ,deleted_fg                               COMMENT 'Attribute set was not delivered by source system (anymore), if deleted_fg=1.'
  ,dwh_valid_from                           COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'
  ,dwh_valid_to                             COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'Table with all the checks and its changes during the checks. Each difference can have multiple checks.
Source: WAWI table: T0025_DESPATCH_ADVICE_DIFFERENCE'
AS SELECT
   client_id
  ,wh_loc_sid
  ,despatch_advice_diff_sid
  ,despatch_advice_check_type_id
  ,despatch_advice_check_type_fg
  ,despatch_advice_check_type_value_id
  ,deleted_fg
  ,dwh_valid_from
  ,dwh_valid_to
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_DESPATCH_ADVICE_DIFFERENCE_CHECK_HIST_2
;