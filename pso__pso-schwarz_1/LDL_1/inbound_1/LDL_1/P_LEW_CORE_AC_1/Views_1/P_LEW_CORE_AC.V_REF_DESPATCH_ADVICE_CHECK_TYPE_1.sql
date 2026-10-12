CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_DESPATCH_ADVICE_CHECK_TYPE_1 (
   despatch_advice_check_type_id            COMMENT 'Identification of the despatch advice difference check type.'
  ,despatch_advice_check_type_descr         COMMENT 'Description of the despatch advice difference check type.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The timestamp when the row was inserted.'
  ,dwh_updated                              COMMENT 'The timestamp when the row was updated the last time.'
)
COMMENT = 'List of all despatch advice difference check types, like missing article, difference in qty, etc.'
AS SELECT
   despatch_advice_check_type_id
  ,despatch_advice_check_type_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_DESPATCH_ADVICE_CHECK_TYPE_1
;