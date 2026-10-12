CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_AKT_GP
(
  mandant_id
, akt_gp_id
, akt_gp_name
, akt_land_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
SELECT
v01.mandant_id,
v01.gp_id akt_gp_id,
v01.gp_name akt_gp_name,
v01.land_id akt_land_id
FROM dbp_view.v_gp v01;


