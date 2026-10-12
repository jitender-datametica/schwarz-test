/* --------------------------------------------------------------------------------
   DDL for table: t_ref_planned_cycle_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:16 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_PLANNED_CYCLE_2 (
   cycle_id                            NUMBER(38,0)     NOT NULL COMMENT 'id of the cycle to derive stock correction requests from a plan',
   cycle_descr                         VARCHAR(100)     NOT NULL COMMENT 'description of the cycle to derive stock correction requests from a plan',
   cycle_descr_en                      VARCHAR(100)     NOT NULL COMMENT 'english description of the cycle to derive stock correction requests from a plan',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_PLANNED_CYCLE PRIMARY KEY (cycle_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Table contains the cycles to create requests from a plan;
             Source: static reference';

