CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_PRUEF_PROZESS_TYP_LU_2(
    PRUEF_PROZESS_TYP_KZ,
    PRUEF_PROZESS_TYP_BEZ
) AS 
/* 
   2024-10-01 muellerpatri : Initiale Erstellung der View, AP0212768
*/
SELECT 
    pruef_prozess_typ_kz
    , pruef_prozess_typ_bez
FROM 
DBP_VIEW.v_l_pruef_prozess_typ_2
GROUP BY ALL
;