CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_DESPATCH_ADVICE_STATUS_2 (
   despatch_advice_status_id                COMMENT 'Status_2 ID of the despatch advice such as open, booked, invalid, differences, deleted.'
  ,despatch_advice_status_descr             COMMENT 'Description of status_2 for despatch advice.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The timestamp when the row was inserted.'
  ,dwh_updated                              COMMENT 'The timestamp when the row was updated the last time.'
)
COMMENT = 'Static status_2 values for despatch advice like open, booked, invalid, differences, deleted.'
AS SELECT
   despatch_advice_status_id
  ,despatch_advice_status_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_DESPATCH_ADVICE_STATUS_2
;