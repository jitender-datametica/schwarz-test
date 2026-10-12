/* --------------------------------------------------------------------------------
   DDL for table: t_ref_warehouse_process_type_2
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 15:57:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_warehouse_process_type_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
wh_loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse; FK auf LOCATION_2'),
wh_process_nr STRING(100) NOT NULL OPTIONS(description='Identifier for the process in the WH.'),
wh_activity_type_cd STRING(100)
OPTIONS(description='Activity type of the work task, like pick, replenishment, stock change, internal move or putaway.'),
wh_process_descr STRING(250) OPTIONS(description='Description of the process type in the WH.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (wh_loc_sid, wh_process_nr) NOT ENFORCED
) OPTIONS(description='Reference table for all the process types for a task performed in WH.');