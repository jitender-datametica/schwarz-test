/* --------------------------------------------------------------------------------
   DDL for table: t_ref_warehouse_task_status_2
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 15:59:03
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_WAREHOUSE_TASK_STATUS_2 (
   wh_task_status_cd                   VARCHAR(100)     NOT NULL COMMENT 'Status_2 of the work task: , A, B and C.',
   wh_task_status_descr                VARCHAR(250)     NOT NULL COMMENT 'Warehouse work task status_2 description: open, cancelled, confirmed, etc.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_WAREHOUSE_TASK_STATUS PRIMARY KEY (wh_task_status_cd) NOT ENFORCED 
)  COMMENT = 'Static task status_2 that exists in EWM: open, cancel, complete and locked.';