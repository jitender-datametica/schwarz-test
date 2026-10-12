CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_LAND
-- Filter auf land_id, da SAP-Daten fehlerhaft - sschuecke 10.09.2015
(
land_bez
,land_iso
,eu_land_fg
,land_id
)
AS
   SELECT
  land_bez, land_iso, eu_land_fg, land_id

   FROM dbp_view.v_land
   WHERE mandant_id = 1
   AND land_id = 'DE';