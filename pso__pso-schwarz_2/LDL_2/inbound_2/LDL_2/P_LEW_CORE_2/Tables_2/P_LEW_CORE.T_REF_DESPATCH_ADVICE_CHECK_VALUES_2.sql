/* --------------------------------------------------------------------------------
   DDL for table: t_ref_despatch_advice_check_values_2
   generated from Powerdesigner on Tuesday, February 4, 2025 12:17:56 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_DESPATCH_ADVICE_CHECK_VALUES_2 (
   despatch_advice_check_type_value_id NUMBER(38,0)     NOT NULL COMMENT 'Code value for differences check outcome.',
   despatch_advice_check_type_value_descr VARCHAR(250)     COMMENT 'Description for the code value of the difference check outcome.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_DESPATCH_ADVICE_CHECK_VALUES PRIMARY KEY (despatch_advice_check_type_value_id) NOT ENFORCED 
)  COMMENT = 'List of all possible status_2 values for despatch advice differences classifying the check outcome.';