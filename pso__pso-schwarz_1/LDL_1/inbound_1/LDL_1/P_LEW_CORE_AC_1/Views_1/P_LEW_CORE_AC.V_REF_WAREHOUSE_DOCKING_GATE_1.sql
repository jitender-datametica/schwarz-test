CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_WAREHOUSE_DOCKING_GATE_1 (
   client_id                                COMMENT 'DWH-Mandant_1; FK auf CLIENT.'
  ,wh_loc_sid                               COMMENT 'Warehouse; FK auf LOCATION.'
  ,wh_docking_gate_nr                       COMMENT 'Identifier of the docking gate at the warehouse where the transportaion vehicle docks for loading and unloading.'
  ,wh_staging_area_cd                       COMMENT 'Code for the warehouse staging area to which the docking gate belongs.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated                              COMMENT 'The point in time when this record was last updated.'
)
COMMENT = 'Table contains docking gate numbers in warehouse, which are where the transportation vehicle docks for loading and unloading, and the connection to the respective staging area.
Source:
WAWI table T171_GINGATES_1
EWM table /SCWM/TDOOR_STA'
AS SELECT
   client_id
  ,wh_loc_sid
  ,wh_docking_gate_nr
  ,wh_staging_area_cd
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_WAREHOUSE_DOCKING_GATE_1
;