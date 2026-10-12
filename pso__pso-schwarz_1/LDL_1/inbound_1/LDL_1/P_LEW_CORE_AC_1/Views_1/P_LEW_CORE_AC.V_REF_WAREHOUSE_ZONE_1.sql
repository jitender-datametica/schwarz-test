CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_WAREHOUSE_ZONE_1 (
   client_id                                COMMENT 'DWH-Mandant_1; FK auf CLIENT'
  ,wh_loc_sid                               COMMENT 'Warehouse; FK auf LOCATION_1'
  ,wh_zone_nr                               COMMENT 'Code for the WH area of activity.'
  ,wh_zone_descr                            COMMENT 'Description of the WH area of activity.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated                              COMMENT 'The point in time when this record was last updated.'
)
COMMENT = 'Table contains the warehouse area where the activity is to be performed.'
AS SELECT
   client_id
  ,wh_loc_sid
  ,wh_zone_nr
  ,wh_zone_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_WAREHOUSE_ZONE_1;