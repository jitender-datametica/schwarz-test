CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_WAREHOUSE_STAGING_AREA (
   client_id                                COMMENT 'DWH-Mandant; FK auf CLIENT.'
  ,wh_loc_sid                               COMMENT 'Warehouse; FK auf LOCATION.'
  ,wh_staging_area_cd                       COMMENT 'Code for the warehouse staging area to which the docking gate belongs.'
  ,wh_staging_area_descr                    COMMENT 'Description of the warehouse staging area to which the docking area belongs.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated                              COMMENT 'The point in time when this record was last updated.'
)
COMMENT = 'Table contains the staging areas in a warehouse. Staging areas connect docking gates with the warehouse. They are an intermediate storage and processing area.
Source:
WAWI table T170_GINGATETYPES
EWM table T301'
AS SELECT
   client_id
  ,wh_loc_sid
  ,wh_staging_area_cd
  ,wh_staging_area_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_WAREHOUSE_STAGING_AREA
;