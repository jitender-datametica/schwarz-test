CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SOK_ART_WG_ZU_2(
    MANDANT_ID,
    ART_ID,
    SOK_WG_ID
) AS 
/* 
   2024-05-21 muellerpatri : Initiale Erstellung der View, AP0186508
*/
SELECT
   v01.mandant_id 
   , v01.art_id
   , v01.wg_id AS SOK_WG_ID
FROM dbp_view.v_art_wg_zu_per_2 v01
WHERE v01.arthiertyp_id = 2
AND   v01.dat_bis = '9999-12-31';