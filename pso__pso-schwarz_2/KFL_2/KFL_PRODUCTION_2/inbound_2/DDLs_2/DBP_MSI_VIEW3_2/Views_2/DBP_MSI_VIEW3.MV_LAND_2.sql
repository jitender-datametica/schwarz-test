CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LAND_2
(
land_id
,mandant_id
,land_bez
,land_iso
,eu_land_fg
)
AS
   SELECT
   land_id, mandant_id, land_bez, land_iso, eu_land_fg

   FROM dbp_view.v_land_2;