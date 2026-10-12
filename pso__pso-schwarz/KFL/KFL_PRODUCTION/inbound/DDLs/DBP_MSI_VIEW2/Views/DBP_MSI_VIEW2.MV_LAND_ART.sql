CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_LAND_ART
-- Artikel/Lieferant mit allen Regionen/Land_Ids und Mandant = 1
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
   WHERE mandant_id = 1;