CREATE OR REPLACE TABLE ldl_p_lew_core.t_ref_warehouse_docking_gate_1 (
client_id INTEGER NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT.'),
wh_loc_sid INTEGER NOT NULL OPTIONS(description='Warehouse; FK auf LOCATION.'),
wh_docking_gate_nr INTEGER NOT NULL
OPTIONS(description='Identifier of the docking gate at the warehouse where the transportaion vehicle docks for loading and unloading.'),
wh_staging_area_cd STRING(100)
OPTIONS(description='Code for the warehouse staging area to which the docking gate belongs.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (wh_loc_sid, wh_docking_gate_nr) NOT ENFORCED
)
OPTIONS(description='Table contains docking gate numbers in warehouse, which are where the transportation vehicle docks for loading and unloading, and the connection to the respective staging area.\n             Source:\n             WAWI table T171_GINGATES_1\n             EWM table /SCWM/TDOOR_STA');