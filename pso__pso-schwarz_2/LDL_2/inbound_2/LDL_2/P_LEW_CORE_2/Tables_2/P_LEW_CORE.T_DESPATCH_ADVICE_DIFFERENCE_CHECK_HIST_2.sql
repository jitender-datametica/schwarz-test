/* --------------------------------------------------------------------------------
   DDL for table: t_despatch_advice_difference_check_hist_2
   generated from Powerdesigner on Tuesday, February 4, 2025 12:04:46 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_DESPATCH_ADVICE_DIFFERENCE_CHECK_HIST_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   wh_loc_sid                          NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key warehouse, foreign key on location.',
   despatch_advice_diff_sid            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key based on difference per despatch advice (and warehouse).
            C0025_despatch_adviceid and C0025_id',
   despatch_advice_check_type_id       NUMBER(38,0)     NOT NULL COMMENT 'Code of the despatch advice difference check type.',
   despatch_advice_check_type_fg       NUMBER(38,0)     COMMENT 'Flag: Set if difference exists.',
   despatch_advice_check_type_value_id NUMBER(38,0)     COMMENT 'Code of the check type value for differences checked',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Attribute set was not delivered by source system (anymore), if deleted_fg=1.',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_DESPATCH_ADVICE_DIFFERENCE_CHECK_HIST PRIMARY KEY (despatch_advice_diff_sid, despatch_advice_check_type_id, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'Table with all the checks and its changes during the checks. Each difference can have multiple checks.
             Source: WAWI table: T0025_DESPATCH_ADVICE_DIFFERENCE';