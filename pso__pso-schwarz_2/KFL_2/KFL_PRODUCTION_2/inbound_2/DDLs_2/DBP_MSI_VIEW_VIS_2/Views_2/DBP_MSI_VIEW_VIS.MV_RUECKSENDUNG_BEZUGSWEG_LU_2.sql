CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_RUECKSENDUNG_BEZUGSWEG_LU_2(
    BEZUGSWEG_ID,
    BEZUGSWEG_BEZ_DE,
    BEZUGSWEG_BEZ,
    BEZUGSWEG_BEZ_CZ,
    BEZUGSWEG_BEZ_SK,
    BEZUGSWEG_BEZ_HR,
    BEZUGSWEG_BEZ_PL,
    BEZUGSWEG_BEZ_RO,
    BEZUGSWEG_BEZ_BG
) AS  
/*	
    2025-05-06 muellerpatri : Initiale Erstellung der View (AP0263148)
*/
SELECT
    bw.bezugsweg_id
    , MAX(CASE WHEN spr_id =  22 THEN bezugsweg_bez ELSE TRIM(bws.bezugsweg_id) END)      	                AS bezugsweg_bez_de
    , bezugsweg_bez_de                                                                                      AS bezugsweg_bez       -- DE
    , COALESCE(MAX(CASE WHEN spr_id = 124 THEN bezugsweg_bez END), bezugsweg_bez_de)                        AS bezugsweg_bez_cz    -- CZ
    , COALESCE(MAX(CASE WHEN spr_id = 108 THEN bezugsweg_bez END), bezugsweg_bez_de)                        AS bezugsweg_bez_sk    -- SK
    , COALESCE(MAX(CASE WHEN spr_id =  65 THEN bezugsweg_bez END), bezugsweg_bez_de)                        AS bezugsweg_bez_hr    -- HR
    , COALESCE(MAX(CASE WHEN spr_id =  90 THEN bezugsweg_bez END), bezugsweg_bez_de)                        AS bezugsweg_bez_pl    -- PL
    , COALESCE(MAX(CASE WHEN spr_id =  95 THEN bezugsweg_bez END), bezugsweg_bez_de)                        AS bezugsweg_bez_ro    -- RO
    , COALESCE(MAX(CASE WHEN spr_id =  18 THEN bezugsweg_bez END), bezugsweg_bez_de)                        AS bezugsweg_bez_bg    -- BG
FROM dbp_view.V_L_BEZUGSWEG_2 bw
JOIN DBP_VIEW.V_BEZUGSWEG_SPR_ZU_2 bws
ON bw.mandant_id = bws.mandant_id AND bw.bezugsweg_id = bws.bezugsweg_id
GROUP BY ALL
;