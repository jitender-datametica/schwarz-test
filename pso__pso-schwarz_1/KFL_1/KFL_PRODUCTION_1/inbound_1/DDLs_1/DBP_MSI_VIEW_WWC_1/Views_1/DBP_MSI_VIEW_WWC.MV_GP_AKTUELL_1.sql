CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_GP_AKTUELL_1
-- 24.08.2020, AP0033327, SPEC0067448, srom0404, Neuanlage
(
 akt_gp_id
,akt_gp_name
)
AS 
SELECT
 v01.gp_id AS akt_gp_id
,v02.gp_name AS akt_gp_name

FROM DBP_VIEW.v_art_gp_zu_per_1 v01
LEFT JOIN DBP_VIEW.v_gp_1 v02
  ON v01.gp_id = v02.gp_id 
 AND v01.mandant_id = v02.mandant_id
WHERE v01.dat_bis = '9999-12-31'
  AND v01.mandant_id = 1
GROUP BY v01.gp_id
        ,v02.gp_name;