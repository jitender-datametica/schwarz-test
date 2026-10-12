CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_warehouse_zone (client_id
OPTIONS(description='DWH-Mandant; FK auf CLIENT'), wh_loc_sid OPTIONS(description='Warehouse; FK auf LOCATION'),
wh_zone_nr OPTIONS(description='Code for the WH area of activity.'), wh_zone_descr
OPTIONS(description='Description of the WH area of activity.'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `TABLE CONTAINS THE WAREHOUSE AREA WHERE THE ACTIVITY IS TO BE PERFORMED.`) AS SELECT client_id,
 wh_loc_sid,
 wh_zone_nr,
 wh_zone_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_warehouse_zone;