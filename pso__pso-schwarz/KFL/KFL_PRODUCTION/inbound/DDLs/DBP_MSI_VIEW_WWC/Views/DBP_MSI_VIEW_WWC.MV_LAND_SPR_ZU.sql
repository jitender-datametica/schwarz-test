CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_LAND_SPR_ZU
(
land_id
,land_bez
,land_iso
,eu_land_fg
)
AS
   SELECT v01.land_id, v01.land_bez, v01.land_iso, v01.eu_land_fg
   FROM dbp_view.v_land v01
   WHERE v01.mandant_id = 1  -- Deutschland
;