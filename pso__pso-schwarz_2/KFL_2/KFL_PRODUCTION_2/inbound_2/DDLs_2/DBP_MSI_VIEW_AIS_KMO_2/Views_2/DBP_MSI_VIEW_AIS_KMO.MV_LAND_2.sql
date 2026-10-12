CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_LAND_2
(
mandant_id
, land_id
, land_bez
)
AS

   SELECT v01.mandant_id,
   v01.land_id,
   v01.land_bez

  FROM dbp_view.v_land_2 v01

   WHERE v01.mandant_id <> 1;