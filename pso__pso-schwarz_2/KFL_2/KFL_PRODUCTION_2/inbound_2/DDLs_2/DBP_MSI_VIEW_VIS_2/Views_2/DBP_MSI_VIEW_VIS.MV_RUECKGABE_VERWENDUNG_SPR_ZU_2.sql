CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_RUECKGABE_VERWENDUNG_SPR_ZU_2(
    RUECKGABE_VERWENDUNG_KZ,
    RUECKGABE_VERWENDUNG_BEZ_DE,
    RUECKGABE_VERWENDUNG_BEZ,
    RUECKGABE_VERWENDUNG_BEZ_CZ,
    RUECKGABE_VERWENDUNG_BEZ_SK,
    RUECKGABE_VERWENDUNG_BEZ_HR,
    RUECKGABE_VERWENDUNG_BEZ_PL,
    RUECKGABE_VERWENDUNG_BEZ_RO,
    RUECKGABE_VERWENDUNG_BEZ_BG
) AS 
/* 
   2024-10-01 muellerpatri : Initiale Erstellung der View, AP0212768
*/
SELECT 
    rueck.rueckgabe_verwendung_kz
    , MAX(CASE WHEN spr_id =  22 THEN rueckgabe_verwendung_bez ELSE TRIM(rueckgabe_verwendung_kz) END)      AS rueckgabe_verwendung_bez_de
    , rueckgabe_verwendung_bez_de                                                                           AS reklamationsgrund_bez       -- DE
    , COALESCE(MAX(CASE WHEN spr_id = 124 THEN rueckgabe_verwendung_bez END), rueckgabe_verwendung_bez_de)  AS rueckgabe_verwendung_bez_cz    -- CZ
    , COALESCE(MAX(CASE WHEN spr_id = 108 THEN rueckgabe_verwendung_bez END), rueckgabe_verwendung_bez_de)  AS rueckgabe_verwendung_bez_sk    -- SK
    , COALESCE(MAX(CASE WHEN spr_id =  65 THEN rueckgabe_verwendung_bez END), rueckgabe_verwendung_bez_de)  AS rueckgabe_verwendung_bez_hr    -- HR
    , COALESCE(MAX(CASE WHEN spr_id =  90 THEN rueckgabe_verwendung_bez END), rueckgabe_verwendung_bez_de)  AS rueckgabe_verwendung_bez_pl    -- PL
    , COALESCE(MAX(CASE WHEN spr_id =  95 THEN rueckgabe_verwendung_bez END), rueckgabe_verwendung_bez_de)  AS rueckgabe_verwendung_bez_ro    -- RO
    , COALESCE(MAX(CASE WHEN spr_id =  18 THEN rueckgabe_verwendung_bez END), rueckgabe_verwendung_bez_de)  AS rueckgabe_verwendung_bez_bg    -- BG
FROM 
dbp_view.v_rueckgabe_verwendung_spr_zu_2 rueck
GROUP BY ALL
;