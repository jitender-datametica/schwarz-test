/* --------------------------------------------------------------------------------
   DDL for table: t_warehouse_work_package_2
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 16:10:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_warehouse_work_package_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
work_package_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate identifier to be created (country_2, warehouse and warehouse work package_2 (WHO)).'),
wh_loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse; FK auf LOCATION_2'),
work_package_nr STRING(100) NOT NULL OPTIONS(description='Identifier in EWM for WH work package_2 (WHO).'),
wh_nr STRING(100) OPTIONS(description='Identifier of warehouses in the WAWI source system.'),
work_package_process_nr STRING(100) OPTIONS(description='Identifier for the process the work package_2 is for.'),
work_package_activity_type_cd STRING(100)
OPTIONS(description='Activity type of the work package_2 like pick, replenishment, stock change, internal move or putaway. Denormalized from t_ref_warehouse_process_type.'),
work_package_grp_nr STRING(100)
OPTIONS(description='WHO Queue identifier, which is the basis for grouping the work task in a work package.'),
work_package_status_cd STRING(100) OPTIONS(description='Status_2 of the work package_2: open, confirmed, in progress, etc.'),
tgt_store_loc_sid BIGNUMERIC(38,0)
OPTIONS(description='Location_2 SID of the target store for which the work package_2 is.'),
tgt_wh_loc_sid BIGNUMERIC(38,0)
OPTIONS(description='Location_2 SID of the target warehouse for which the work package_2 is.'),
tgt_sup_sid BIGNUMERIC(38,0) OPTIONS(description='Target supplier_2 for which the work package_2 is.'),
work_package_create_dt DATE OPTIONS(description='Date when the work package_2 was created.'),
work_package_create_tmsp DATETIME OPTIONS(description='The point in time when the work package_2 was created.'),
work_package_start_dt DATE OPTIONS(description='Date when the work package_2 was started to be worked on.'),
work_package_start_tmsp DATETIME
OPTIONS(description='The point in time when the work package_2 was started to be worked on.'),
work_package_confirm_dt DATE OPTIONS(description='Date when the work package_2 was confirmed.'),
work_package_confirm_tmsp DATETIME OPTIONS(description='The point in time when the work package_2 was confirmed.'),
wh_zone_nr STRING(100) OPTIONS(description='Zone in the WH, split based on activity, inventory, layout, etc.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (work_package_sid) NOT ENFORCED
)
OPTIONS(description='SAP EWM data for WH orders. which are the work packages for WH processing (picking, putaway, etc.).');