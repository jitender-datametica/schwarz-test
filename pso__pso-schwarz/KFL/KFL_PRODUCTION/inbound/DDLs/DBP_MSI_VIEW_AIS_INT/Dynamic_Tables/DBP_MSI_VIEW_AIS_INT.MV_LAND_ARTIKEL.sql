CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_LAND_ARTIKEL
(
land_id
, mandant_id
, land_bez
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
   v02.land_id, v02.mandant_id, v02.land_bez
   FROM dbp_view.v_land v02
   WHERE (v02.land_id,v02.mandant_id) IN
   (
   SELECT
   v01.land_id, v01.mandant_id
   FROM dbp_view.v_art v01
   );