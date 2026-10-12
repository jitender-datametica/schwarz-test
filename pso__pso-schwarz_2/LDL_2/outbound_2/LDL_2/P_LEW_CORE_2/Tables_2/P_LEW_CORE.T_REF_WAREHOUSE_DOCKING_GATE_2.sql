/* --------------------------------------------------------------------------------
   DDL for table: t_ref_warehouse_docking_gate_2
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 11:47:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_warehouse_docking_gate_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT.'),
wh_loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse; FK auf LOCATION.'),
wh_docking_gate_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the docking gate at the warehouse where the transportaion vehicle docks for loading and unloading.'),
wh_staging_area_cd STRING(100)
OPTIONS(description='Code for the warehouse staging area to which the docking gate belongs.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (wh_loc_sid, wh_docking_gate_nr) NOT ENFORCED
)
OPTIONS(description='Table contains docking gate numbers in warehouse, which are where the transportation vehicle docks for loading and unloading, and the connection to the respective staging area.             Source:             WAWI table T171_GINGATES_2             EWM table /SCWM/TDOOR_STA');