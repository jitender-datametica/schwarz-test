CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_WAREHOUSE_WORK_PACKAGE (
   client_id                                COMMENT 'DWH-Mandant; FK auf CLIENT'
  ,work_package_sid                         COMMENT 'Surrogate identifier to be created (country, warehouse and warehouse work package (WHO)).'
  ,wh_loc_sid                               COMMENT 'Warehouse; FK auf LOCATION'
  ,work_package_nr                          COMMENT 'Identifier in EWM for WH work package (WHO).'
  ,wh_nr                                    COMMENT 'Identifier of warehouses in the WAWI source system.'
  ,work_package_process_nr                  COMMENT 'Identifier for the process the work package is for.'
  ,work_package_activity_type_cd            COMMENT 'Activity type of the work package like pick, replenishment, stock change, internal move or putaway. Denormalized from t_ref_warehouse_process_type.'
  ,work_package_grp_nr                      COMMENT 'WHO Queue identifier, which is the basis for grouping the work task in a work package.'
  ,work_package_status_cd                   COMMENT 'Status of the work package: open, confirmed, in progress, etc.'
  ,tgt_store_loc_sid                        COMMENT 'Location SID of the target store for which the work package is.'
  ,tgt_wh_loc_sid                           COMMENT 'Location SID of the target warehouse for which the work package is.'
  ,tgt_sup_sid                              COMMENT 'Target supplier for which the work package is.'
  ,work_package_create_dt                   COMMENT 'Date when the work package was created.'
  ,work_package_create_tmsp                 COMMENT 'The point in time when the work package was created.'
  ,work_package_start_dt                    COMMENT 'Date when the work package was started to be worked on.'
  ,work_package_start_tmsp                  COMMENT 'The point in time when the work package was started to be worked on.'
  ,work_package_confirm_dt                  COMMENT 'Date when the work package was confirmed.'
  ,work_package_confirm_tmsp                COMMENT 'The point in time when the work package was confirmed.'
  ,wh_zone_nr                               COMMENT 'Zone in the WH, split based on activity, inventory, layout, etc.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated                              COMMENT 'The point in time when this record was last updated.'
)
COMMENT = 'SAP EWM data for WH orders. which are the work packages for WH processing (picking, putaway, etc.).'
AS SELECT
   client_id
  ,work_package_sid
  ,wh_loc_sid
  ,work_package_nr
  ,wh_nr
  ,work_package_process_nr
  ,work_package_activity_type_cd
  ,work_package_grp_nr
  ,work_package_status_cd
  ,tgt_store_loc_sid
  ,tgt_wh_loc_sid
  ,tgt_sup_sid
  ,work_package_create_dt
  ,work_package_create_tmsp
  ,work_package_start_dt
  ,work_package_start_tmsp
  ,work_package_confirm_dt
  ,work_package_confirm_tmsp
  ,wh_zone_nr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_WAREHOUSE_WORK_PACKAGE;