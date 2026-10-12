CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_LAND_ART_2
-- Artikel_2/Lieferant mit allen Regionen/Land_Ids und Mandant_2 = 1
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
   WHERE mandant_id = 1;