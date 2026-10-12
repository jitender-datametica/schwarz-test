/* --------------------------------------------------------------------------------
   DDL for table: t_ref_work_package_status_2
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 16:03:58
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_WORK_PACKAGE_STATUS_2 (
   work_package_status_cd              VARCHAR(100)     NOT NULL COMMENT 'Status_2 of the work package_2: , A, B, C and D.',
   work_package_status_descr           VARCHAR(250)     COMMENT 'Warehouse work package_2 status_2 description: open, cancelled, confirmed, etc.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_WORK_PACKAGE_STATUS PRIMARY KEY (work_package_status_cd) NOT ENFORCED 
)  COMMENT = 'Static order (work package_2) status_2 that exists in EWM: open, in progress, cancel, complete and locked.';
