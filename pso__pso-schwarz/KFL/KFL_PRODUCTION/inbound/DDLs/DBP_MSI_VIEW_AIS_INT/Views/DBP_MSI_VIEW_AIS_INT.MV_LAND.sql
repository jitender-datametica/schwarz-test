CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_LAND
(
mandant_id
, land_id
, land_bez
)
AS
   SELECT
   v01.mandant_id, v01.land_id, v01.land_bez

   FROM dbp_view.v_land v01;