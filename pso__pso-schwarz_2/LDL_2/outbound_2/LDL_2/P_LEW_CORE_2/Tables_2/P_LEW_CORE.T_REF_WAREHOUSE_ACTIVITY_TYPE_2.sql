/* --------------------------------------------------------------------------------
   DDL for table: t_ref_warehouse_activity_type_2
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 15:56:22
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_warehouse_activity_type_2 (
wh_activity_type_cd STRING(100) NOT NULL
OPTIONS(description='Activity type of the work task, like pick, replenishment, stock change, internal move or putaway.'),
wh_activity_type_descr STRING(250) OPTIONS(description='Description of the activity type in the WH.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (wh_activity_type_cd) NOT ENFORCED
) OPTIONS(description='The table holds the activity types in SAP EWM. The values are PTWY, PICK, INTL, STCH and REPL.');