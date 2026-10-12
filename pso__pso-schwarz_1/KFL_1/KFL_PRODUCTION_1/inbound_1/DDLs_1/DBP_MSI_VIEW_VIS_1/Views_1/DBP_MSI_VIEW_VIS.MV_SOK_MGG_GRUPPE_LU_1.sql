CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SOK_MGG_GRUPPE_LU_1(
    MANDANT_ID,
    SOK_MGG_GRUPPE_ID,
    SOK_MGG_ABTEILUNG_ID,
    SOK_MGG_GRUPPE_BEZ_DE,
    SOK_MGG_GRUPPE_BEZ,
    SOK_MGG_GRUPPE_BEZ_CZ,
    SOK_MGG_GRUPPE_BEZ_SK,
    SOK_MGG_GRUPPE_BEZ_HR,
    SOK_MGG_GRUPPE_BEZ_PL,
    SOK_MGG_GRUPPE_BEZ_RO,
    SOK_MGG_GRUPPE_BEZ_BG
) AS 
/* 
   2024-07-01 muellerpatri : Initiale Erstellung der View, AP0186508
*/
SELECT 
    grp.mandant_id
    , grp.mgg_gruppe_id AS sok_mgg_gruppe_id
    , grp.mgg_abteilung_id AS sok_mgg_abteilung_id
    , MAX(CASE WHEN spr_id =  22 THEN mgg_gruppe_bez ELSE TRIM(grps.mgg_gruppe_id) END)     AS sok_mgg_gruppe_bez_de
    , sok_mgg_gruppe_bez_de                                                                    AS sok_mgg_gruppe_bez       -- DE
    , COALESCE(MAX(CASE WHEN spr_id = 124 THEN mgg_gruppe_bez END), sok_mgg_gruppe_bez_de) AS sok_mgg_gruppe_bez_cz    -- CZ
    , COALESCE(MAX(CASE WHEN spr_id = 108 THEN mgg_gruppe_bez END), sok_mgg_gruppe_bez_de) AS sok_mgg_gruppe_bez_sk    -- SK
    , COALESCE(MAX(CASE WHEN spr_id =  65 THEN mgg_gruppe_bez END), sok_mgg_gruppe_bez_de) AS sok_mgg_gruppe_bez_hr    -- HR
    , COALESCE(MAX(CASE WHEN spr_id =  90 THEN mgg_gruppe_bez END), sok_mgg_gruppe_bez_de) AS sok_mgg_gruppe_bez_pl    -- PL
    , COALESCE(MAX(CASE WHEN spr_id =  95 THEN mgg_gruppe_bez END), sok_mgg_gruppe_bez_de) AS sok_mgg_gruppe_bez_ro    -- RO
    , COALESCE(MAX(CASE WHEN spr_id =  18 THEN mgg_gruppe_bez END), sok_mgg_gruppe_bez_de) AS sok_mgg_gruppe_bez_bg    -- BG
FROM dbp_view.v_l_mgg_gruppe_1 grp
JOIN dbp_view.v_mgg_gruppe_spr_zu_1 grps
ON grp.mandant_id = grps.mandant_id AND grp.mgg_gruppe_id = grps.mgg_gruppe_id
GROUP BY 
    grp.mandant_id
    , grp.mgg_gruppe_id
    , grp.mgg_abteilung_id
;