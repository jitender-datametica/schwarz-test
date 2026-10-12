CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_warehouse_docking_gate (client_id
OPTIONS(description='DWH-Mandant; FK auf CLIENT.'), wh_loc_sid OPTIONS(description='Warehouse; FK auf LOCATION.'),
wh_docking_gate_nr
OPTIONS(description='Identifier of the docking gate at the warehouse where the transportaion vehicle docks for loading and unloading.'),
wh_staging_area_cd OPTIONS(description='Code for the warehouse staging area to which the docking gate belongs.'),
dwh_load_id OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `TABLE CONTAINS DOCKING GATE NUMBERS IN WAREHOUSE, WHICH ARE WHERE THE TRANSPORTATION VEHICLE DOCKS FOR LOADING AND UNLOADING, AND THE CONNECTION TO THE RESPECTIVE STAGING AREA.SOURCE:WAWI TABLE T171_GINGATESEWM TABLE /SCWM/TDOOR_STA`)
AS SELECT client_id,
 wh_loc_sid,
 wh_docking_gate_nr,
 wh_staging_area_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_warehouse_docking_gate;