/* --------------------------------------------------------------------------------
   DDL for table: t_ref_despatch_advice_status_2
   generated from Powerdesigner on Tuesday, February 4, 2025 12:24:54 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_DESPATCH_ADVICE_STATUS_2 (
   despatch_advice_status_id           NUMBER(38,0)     NOT NULL COMMENT 'Status_2 ID of the despatch advice such as open, booked, invalid, differences, deleted.',
   despatch_advice_status_descr        VARCHAR(250)     COMMENT 'Description of status_2 for despatch advice.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_REF_DESPATCH_ADVICE_STATUS PRIMARY KEY (despatch_advice_status_id) NOT ENFORCED 
)  COMMENT = 'Static status_2 values for despatch advice like open, booked, invalid, differences, deleted.';