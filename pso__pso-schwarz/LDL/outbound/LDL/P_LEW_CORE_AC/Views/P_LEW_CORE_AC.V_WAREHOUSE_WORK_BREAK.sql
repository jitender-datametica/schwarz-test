CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_warehouse_work_break (client_id
OPTIONS(description='DWH-Mandant; FK auf CLIENT'), work_package_sid
OPTIONS(description='Surrogate identifier to be created (client, warehouse and warehouse work package (WHO)).'),
work_break_seq
OPTIONS(description='For each break during work package work (Client+LGNUM+WHO per record) the sequence of breaks is stored (gets generated on data input).'),
wh_loc_sid OPTIONS(description='Warehouse; FK auf LOCATION'), work_break_start_dt
OPTIONS(description='Date when the break was started.'), work_break_start_tmsp
OPTIONS(description='The point in time when the break was started.'), work_break_end_dt
OPTIONS(description='Date when the break was ended.'), work_break_end_tmsp
OPTIONS(description='The point in time when the break was ended.'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `THE TABLE HOLDS THE BREAK TIME FOR WAREHOUSE WORK PACKAGE.`) AS SELECT client_id,
 work_package_sid,
 work_break_seq,
 wh_loc_sid,
 work_break_start_dt,
 work_break_start_tmsp,
 work_break_end_dt,
 work_break_end_tmsp,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_warehouse_work_break;