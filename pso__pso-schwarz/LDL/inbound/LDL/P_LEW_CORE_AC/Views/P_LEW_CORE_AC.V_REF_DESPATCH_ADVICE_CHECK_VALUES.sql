CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_DESPATCH_ADVICE_CHECK_VALUES (
   despatch_advice_check_type_value_id      COMMENT 'Code value for differences check outcome.'
  ,despatch_advice_check_type_value_descr   COMMENT 'Description for the code value of the difference check outcome.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'List of all possible status values for despatch advice differences classifying the check outcome.'
AS SELECT
   despatch_advice_check_type_value_id
  ,despatch_advice_check_type_value_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_DESPATCH_ADVICE_CHECK_VALUES
;