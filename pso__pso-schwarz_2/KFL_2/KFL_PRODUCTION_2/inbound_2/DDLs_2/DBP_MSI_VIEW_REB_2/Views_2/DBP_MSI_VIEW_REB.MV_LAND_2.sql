CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_LAND_2
(
land_bez
,land_iso
,eu_land_fg
,land_id
)
AS
   SELECT
  land_bez, land_iso, eu_land_fg, land_id

   FROM dbp_view.v_land_2
   WHERE mandant_id = 1
   AND land_id = 'DE';