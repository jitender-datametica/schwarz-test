CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_RUECKSENDUNG_TYP_LU_2(
    MANDANT_ID,
    RUECKSENDUNG_TYP_KZ,
    RUECKSENDUNG_TYP_BEZ_DE,
    RUECKSENDUNG_TYP_BEZ,
    RUECKSENDUNG_TYP_BEZ_CZ,
    RUECKSENDUNG_TYP_BEZ_SK,
    RUECKSENDUNG_TYP_BEZ_HR,
    RUECKSENDUNG_TYP_BEZ_PL,
    RUECKSENDUNG_TYP_BEZ_RO,
    RUECKSENDUNG_TYP_BEZ_BG
) AS  
/*	
    2025-05-06 muellerpatri : Initiale Erstellung der View (AP0263148)
*/
SELECT
    rt.mandant_id
    , rt.ruecksendung_typ_kz
    , MAX(CASE WHEN spr_id =  22 THEN ruecksendung_typ_bez ELSE TRIM(rts.ruecksendung_typ_kz) END)    AS ruecksendung_typ_bez_de
    , ruecksendung_typ_bez_de                                                                            AS ruecksendung_typ_bez       -- DE
    , COALESCE(MAX(CASE WHEN spr_id = 124 THEN ruecksendung_typ_bez END), ruecksendung_typ_bez_de)    AS ruecksendung_typ_bez_cz    -- CZ
    , COALESCE(MAX(CASE WHEN spr_id = 108 THEN ruecksendung_typ_bez END), ruecksendung_typ_bez_de)    AS ruecksendung_typ_bez_sk    -- SK
    , COALESCE(MAX(CASE WHEN spr_id =  65 THEN ruecksendung_typ_bez END), ruecksendung_typ_bez_de)    AS ruecksendung_typ_bez_hr    -- HR
    , COALESCE(MAX(CASE WHEN spr_id =  90 THEN ruecksendung_typ_bez END), ruecksendung_typ_bez_de)    AS ruecksendung_typ_bez_pl    -- PL
    , COALESCE(MAX(CASE WHEN spr_id =  95 THEN ruecksendung_typ_bez END), ruecksendung_typ_bez_de)    AS ruecksendung_typ_bez_ro    -- RO
    , COALESCE(MAX(CASE WHEN spr_id =  18 THEN ruecksendung_typ_bez END), ruecksendung_typ_bez_de)    AS ruecksendung_typ_bez_bg    -- BG
FROM dbp_view.V_L_RUECKSENDUNG_TYP_2 rt
JOIN DBP_VIEW.V_RUECKSENDUNG_TYP_SPR_ZU_2 rts
ON rt.mandant_id = rts.mandant_id AND rt.ruecksendung_typ_kz = rts.ruecksendung_typ_kz
GROUP BY ALL
;