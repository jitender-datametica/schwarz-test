/* --------------------------------------------------------------------------------
   DDL for table: t_ref_despatch_advice_check_type
   generated from Powerdesigner on Tuesday, February 4, 2025 12:13:25 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_DESPATCH_ADVICE_CHECK_TYPE (
   despatch_advice_check_type_id       NUMBER(38,0)     NOT NULL COMMENT 'Identification of the despatch advice difference check type.',
   despatch_advice_check_type_descr    VARCHAR(250)     COMMENT 'Description of the despatch advice difference check type.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_REF_DESPATCH_ADVICE_CHECK_TYPE PRIMARY KEY (despatch_advice_check_type_id) NOT ENFORCED 
)  COMMENT = 'List of all despatch advice difference check types, like missing article, difference in qty, etc.';