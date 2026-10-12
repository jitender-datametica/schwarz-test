/* --------------------------------------------------------------------------------
   DDL for table: t_ref_despatch_advice_difference_status
   generated from Powerdesigner on Tuesday, February 4, 2025 12:21:55 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_DESPATCH_ADVICE_DIFFERENCE_STATUS (
   despatch_advice_diff_status_id      NUMBER(38,0)     NOT NULL COMMENT 'Status ID of the despatch advice differences check, such as open, resolved, deleted.',
   despatch_advice_diff_status_descr   VARCHAR(250)     COMMENT 'description of status of despatch advice differences check',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_DESPATCH_ADVICE_DIFFERENCE_STATUS PRIMARY KEY (despatch_advice_diff_status_id) NOT ENFORCED 
)  COMMENT = 'Static status values for despatch advice difference check like open, resolved, deleted.';