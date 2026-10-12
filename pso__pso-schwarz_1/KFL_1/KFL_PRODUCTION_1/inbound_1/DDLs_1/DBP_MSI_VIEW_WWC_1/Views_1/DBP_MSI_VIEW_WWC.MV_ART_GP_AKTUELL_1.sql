CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_GP_AKTUELL_1
-- 24.08.2020, AP0033327, SPEC0067448, srom0404, Neuanlage
(
 art_id
,akt_gp_id
,mandant_id
)
AS
SELECT
 v01.art_id
,v01.gp_id
,v01.mandant_id
FROM DBP_VIEW.v_art_gp_zu_per_1 v01
WHERE v01.mandant_id = 1
AND v01.dat_bis = '9999-12-31';