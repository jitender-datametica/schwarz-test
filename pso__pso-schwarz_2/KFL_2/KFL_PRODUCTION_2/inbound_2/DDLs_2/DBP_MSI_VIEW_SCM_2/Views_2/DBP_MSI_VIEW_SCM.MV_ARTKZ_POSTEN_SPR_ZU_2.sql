CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ARTKZ_POSTEN_SPR_ZU_2 as
   SELECT
   mandant_id, posten_id, MAX(CASE WHEN (spr_id=22 AND NOT posten_id = '') THEN posten_bez WHEN (spr_id=22 AND posten_id = '') THEN 'Sortimentsartikel' END) AS posten_bez, MAX(CASE WHEN (spr_id=22 AND NOT posten_id = '') THEN posten_bez WHEN (spr_id=22 AND posten_id = '') THEN 'Sortimentsartikel' END) AS posten_bez_de, COALESCE(MAX(CASE WHEN (spr_id=124 AND NOT posten_id = '') THEN posten_bez WHEN (spr_id=124 AND posten_id = '') THEN '' END), posten_bez_de) AS posten_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN (spr_id=108 AND NOT posten_id = '') THEN posten_bez WHEN (spr_id=108 AND posten_id = '') THEN '' END), posten_bez_de) AS posten_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN (spr_id=65 AND NOT posten_id = '') THEN posten_bez WHEN (spr_id=65 AND posten_id = '') THEN '' END), posten_bez_de) AS posten_bez_hr     -- HR
   , COALESCE(MAX(CASE WHEN (spr_id=90 AND NOT posten_id = '') THEN posten_bez WHEN (spr_id=90 AND posten_id = '') THEN '' END), posten_bez_de) AS posten_bez_pl      -- PL
   , COALESCE(MAX(CASE WHEN (spr_id=95 AND NOT posten_id = '') THEN posten_bez WHEN (spr_id=95 AND posten_id = '') THEN '' END), posten_bez_de) AS posten_bez_ro     -- RO
   , COALESCE(MAX(CASE WHEN (spr_id=18 AND NOT posten_id = '') THEN posten_bez WHEN (spr_id=18 AND posten_id = '') THEN '' END), posten_bez_de) AS posten_bez_bg    -- BG
   FROM dbp_view.v_artkz_posten_2
   GROUP BY
   mandant_id
   , posten_id;