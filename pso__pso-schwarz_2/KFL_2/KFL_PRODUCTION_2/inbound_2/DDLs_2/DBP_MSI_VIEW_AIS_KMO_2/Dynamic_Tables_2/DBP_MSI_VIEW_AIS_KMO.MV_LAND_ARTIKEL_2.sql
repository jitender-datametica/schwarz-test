CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_LAND_ARTIKEL_2
--- MR 21.02.2012  erstellt
(
 land_id
,mandant_id
,land_bez
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS

   SELECT
   v02.land_id,
   v02.mandant_id,
   v02.land_bez
   FROM dbp_view.v_land_2 v02
   WHERE
   mandant_id <> 1
   AND
   (v02.land_id,v02.mandant_id) IN
   (
   SELECT
   v01.land_id,
   v01.mandant_id
   FROM dbp_view.v_art_2 v01
   WHERE
   v01.mandant_id <> 1
   );