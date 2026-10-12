CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SOK_PLATZIERUNGSWG_LU_1(
    MANDANT_ID,
    SOK_PLATZIERUNGSWG_ID,
    SOK_PLATZIERUNGSWG_NR,
    SOK_PRIMAERE_PLATZIERUNGSWG_NR,
    SOK_PRIMAERE_RELEVANT_FG,
    SOK_MGG_GRUPPE_ID,
    SOK_KATEGORIE_ID,
    SOK_PLATZIERUNGSWG_BEZ_DE,
    SOK_PLATZIERUNGSWG_BEZ,
    SOK_PLATZIERUNGSWG_BEZ_CZ,
    SOK_PLATZIERUNGSWG_BEZ_SK,
    SOK_PLATZIERUNGSWG_BEZ_HR,
    SOK_PLATZIERUNGSWG_BEZ_PL,
    SOK_PLATZIERUNGSWG_BEZ_RO,
    SOK_PLATZIERUNGSWG_BEZ_BG
) AS 
/* 
   2024-07-01 muellerpatri : Initiale Erstellung der View, AP0186508
   2025-05-23 muellerpatri : Anpassungen primäre_1 PWG
*/
SELECT 
    pwg.mandant_id
    , pwg.platzierungswg_id                                                                         AS sok_platzierungswg_id
    , pwg.platzierungswg_nr                                                                         AS sok_platzierungswg_nr
    , pwg.primaere_platzierungswg_nr                                                                AS sok_primaere_platzierungswg_nr 
    , pwg.primaere_relevant_fg                                                                      AS sok_primaere_relevant_fg
    , pwg.mgg_gruppe_id                                                                             AS sok_mgg_gruppe_id
    , pwg.sok_kategorie_id                                                                                  
    , MAX(CASE WHEN spr_id =  22 THEN platzierungswg_bez ELSE TRIM(pwgs.platzierungswg_id) END)     AS sok_platzierungswg_bez_de
    , sok_platzierungswg_bez_de                                                                     AS sok_platzierungswg_bez       -- DE
    , COALESCE(MAX(CASE WHEN spr_id = 124 THEN platzierungswg_bez END), sok_platzierungswg_bez_de)  AS sok_platzierungswg_bez_cz    -- CZ
    , COALESCE(MAX(CASE WHEN spr_id = 108 THEN platzierungswg_bez END), sok_platzierungswg_bez_de)  AS sok_platzierungswg_bez_sk    -- SK
    , COALESCE(MAX(CASE WHEN spr_id =  65 THEN platzierungswg_bez END), sok_platzierungswg_bez_de)  AS sok_platzierungswg_bez_hr    -- HR
    , COALESCE(MAX(CASE WHEN spr_id =  90 THEN platzierungswg_bez END), sok_platzierungswg_bez_de)  AS sok_platzierungswg_bez_pl    -- PL
    , COALESCE(MAX(CASE WHEN spr_id =  95 THEN platzierungswg_bez END), sok_platzierungswg_bez_de)  AS sok_platzierungswg_bez_ro    -- RO
    , COALESCE(MAX(CASE WHEN spr_id =  18 THEN platzierungswg_bez END), sok_platzierungswg_bez_de)  AS sok_platzierungswg_bez_bg    -- BG
FROM dbp_view.v_l_platzierungswg_1 pwg
JOIN dbp_view.v_platzierungswg_spr_zu_1 pwgs
ON pwg.mandant_id = pwgs.mandant_id AND pwg.platzierungswg_id = pwgs.platzierungswg_id
GROUP BY ALL
;