CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_warehouse_staging_area_2 (client_id
OPTIONS(description='DWH-Mandant_2; FK auf CLIENT.'), wh_loc_sid OPTIONS(description='Warehouse; FK auf LOCATION.'),
wh_staging_area_cd OPTIONS(description='Code for the warehouse staging area to which the docking gate belongs.'),
wh_staging_area_descr
OPTIONS(description='Description of the warehouse staging area to which the docking area belongs.'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `TABLE CONTAINS THE STAGING AREAS IN A WAREHOUSE. STAGING AREAS CONNECT DOCKING GATES WITH THE WAREHOUSE. THEY ARE AN INTERMEDIATE STORAGE AND PROCESSING AREA.SOURCE:WAWI TABLE T170_GINGATETYPESEWM TABLE T301`)
AS SELECT client_id,
 wh_loc_sid,
 wh_staging_area_cd,
 wh_staging_area_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_warehouse_staging_area_2;