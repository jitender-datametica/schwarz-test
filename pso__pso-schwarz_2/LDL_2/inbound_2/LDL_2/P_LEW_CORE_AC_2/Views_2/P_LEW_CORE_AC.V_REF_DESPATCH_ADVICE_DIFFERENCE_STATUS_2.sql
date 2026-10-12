CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_DESPATCH_ADVICE_DIFFERENCE_STATUS_2 (
   despatch_advice_diff_status_id           COMMENT 'Status_2 ID of the despatch advice differences check, such as open, resolved, deleted.'
  ,despatch_advice_diff_status_descr        COMMENT 'description of status_2 of despatch advice differences check'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'Static status_2 values for despatch advice difference check like open, resolved, deleted.'
AS SELECT
   despatch_advice_diff_status_id
  ,despatch_advice_diff_status_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_DESPATCH_ADVICE_DIFFERENCE_STATUS_2
;