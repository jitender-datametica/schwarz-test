/* --------------------------------------------------------------------------------
   DDL for table: t_ref_despatch_advice_difference_status_2
   generated from Powerdesigner on Tuesday, February 4, 2025 12:21:55 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_DESPATCH_ADVICE_DIFFERENCE_STATUS_2 (
   despatch_advice_diff_status_id      NUMBER(38,0)     NOT NULL COMMENT 'Status_2 ID of the despatch advice differences check, such as open, resolved, deleted.',
   despatch_advice_diff_status_descr   VARCHAR(250)     COMMENT 'description of status_2 of despatch advice differences check',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_DESPATCH_ADVICE_DIFFERENCE_STATUS PRIMARY KEY (despatch_advice_diff_status_id) NOT ENFORCED 
)  COMMENT = 'Static status_2 values for despatch advice difference check like open, resolved, deleted.';