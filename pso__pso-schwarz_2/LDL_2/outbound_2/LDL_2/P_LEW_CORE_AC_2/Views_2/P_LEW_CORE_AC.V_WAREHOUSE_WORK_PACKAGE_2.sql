CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_warehouse_work_package_2 (client_id
OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'), work_package_sid
OPTIONS(description='Surrogate identifier to be created (country_2, warehouse and warehouse work package_2 (WHO)).'),
wh_loc_sid OPTIONS(description='Warehouse; FK auf LOCATION_2'), work_package_nr
OPTIONS(description='Identifier in EWM for WH work package_2 (WHO).'), wh_nr
OPTIONS(description='Identifier of warehouses in the WAWI source system.'), work_package_process_nr
OPTIONS(description='Identifier for the process the work package_2 is for.'), work_package_activity_type_cd
OPTIONS(description='Activity type of the work package_2 like pick, replenishment, stock change, internal move or putaway. Denormalized from t_ref_warehouse_process_type.'),
work_package_grp_nr
OPTIONS(description='WHO Queue identifier, which is the basis for grouping the work task in a work package.'),
work_package_status_cd OPTIONS(description='Status_2 of the work package_2: open, confirmed, in progress, etc.'),
tgt_store_loc_sid OPTIONS(description='Location_2 SID of the target store for which the work package_2 is.'), tgt_wh_loc_sid
OPTIONS(description='Location_2 SID of the target warehouse for which the work package_2 is.'), tgt_sup_sid
OPTIONS(description='Target supplier_2 for which the work package_2 is.'), work_package_create_dt
OPTIONS(description='Date when the work package_2 was created.'), work_package_create_tmsp
OPTIONS(description='The point in time when the work package_2 was created.'), work_package_start_dt
OPTIONS(description='Date when the work package_2 was started to be worked on.'), work_package_start_tmsp
OPTIONS(description='The point in time when the work package_2 was started to be worked on.'), work_package_confirm_dt
OPTIONS(description='Date when the work package_2 was confirmed.'), work_package_confirm_tmsp
OPTIONS(description='The point in time when the work package_2 was confirmed.'), wh_zone_nr
OPTIONS(description='Zone in the WH, split based on activity, inventory, layout, etc.'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `SAP EWM DATA FOR WH ORDERS. WHICH ARE THE WORK PACKAGES FOR WH PROCESSING (PICKING, PUTAWAY, ETC.).`)
AS SELECT client_id,
 work_package_sid,
 wh_loc_sid,
 work_package_nr,
 wh_nr,
 work_package_process_nr,
 work_package_activity_type_cd,
 work_package_grp_nr,
 work_package_status_cd,
 tgt_store_loc_sid,
 tgt_wh_loc_sid,
 tgt_sup_sid,
 work_package_create_dt,
 work_package_create_tmsp,
 work_package_start_dt,
 work_package_start_tmsp,
 work_package_confirm_dt,
 work_package_confirm_tmsp,
 wh_zone_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_warehouse_work_package_2;