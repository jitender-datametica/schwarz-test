
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_warehouse_activity_type
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 15:56:22
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_WAREHOUSE_ACTIVITY_TYPE (
   wh_activity_type_cd                 VARCHAR(100)     NOT NULL COMMENT 'Activity type of the work task, like pick, replenishment, stock change, internal move or putaway.',
   wh_activity_type_descr              VARCHAR(250)     COMMENT 'Description of the activity type in the WH.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_WAREHOUSE_ACTIVITY_TYPE PRIMARY KEY (wh_activity_type_cd) NOT ENFORCED 
)  COMMENT = 'The table holds the activity types in SAP EWM. The values are PTWY, PICK, INTL, STCH and REPL.';
