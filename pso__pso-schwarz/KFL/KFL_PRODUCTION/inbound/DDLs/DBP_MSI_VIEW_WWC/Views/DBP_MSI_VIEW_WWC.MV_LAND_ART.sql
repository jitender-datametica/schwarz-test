CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_LAND_ART
-- 24.08.2020, AP0033327, SPEC0067448, srom0404, Neuanlage
(
 land_bez
,land_iso
,eu_land_fg
,land_id
)
AS 
SELECT
 v01.land_bez
,v01.land_iso
,v01.eu_land_fg
,v01.land_id

FROM DBP_VIEW.v_land v01
WHERE mandant_id = 1;