/* --------------------------------------------------------------------------------
   DDL for table: t_ref_warehouse_process_type_1
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 15:57:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_WAREHOUSE_PROCESS_TYPE_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   wh_loc_sid                          NUMBER(38,0)     NOT NULL COMMENT 'Warehouse; FK auf LOCATION_1',
   wh_process_nr                       VARCHAR(100)     NOT NULL COMMENT 'Identifier for the process in the WH.',
   wh_activity_type_cd                 VARCHAR(100)     COMMENT 'Activity type of the work task, like pick, replenishment, stock change, internal move or putaway.',
   wh_process_descr                    VARCHAR(250)     COMMENT 'Description of the process type in the WH.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_WAREHOUSE_PROCESS_TYPE PRIMARY KEY (wh_loc_sid, wh_process_nr) NOT ENFORCED 
)  COMMENT = 'Reference table for all the process types for a task performed in WH.';
