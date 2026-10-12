CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SOK_PLATZIERUNGSWG_WGLISTE_1(
    MANDANT_ID,
    SOK_PLATZIERUNGSWG_ID,
    SOK_WG_LISTE
) AS 
/* 
   2024-07-01 muellerpatri : Initiale Erstellung der View, AP0186508
   2024-11-22 muellerpatri : Anpassung Listagg mit order by
*/
SELECT
    mandant_id
    , platzierungswg_id AS sok_platzierungswg_id
    , Listagg(wg_id, ',') WITHIN GROUP (ORDER BY wg_id) AS sok_wg_liste
FROM 
(
    SELECT 
        pwg.mandant_id
        , pwg.platzierungswg_id
        , wg.wg_id
    FROM
    dbp_view.v_wg_per_1 wg
    JOIN dbp_view.v_l_platzierungswg_1 pwg
    ON pwg.mandant_id = wg.mandant_id AND pwg.platzierungswg_id = wg.platzierungswg_id
    WHERE wg.arthiertyp_id = 2 AND wg.dat_bis = '9999-12-31'
    GROUP BY 
        pwg.mandant_id
        , pwg.platzierungswg_id
        , wg.wg_id
)
GROUP BY 
    mandant_id
    , platzierungswg_id
;