CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_BESTELLART_SPR_ZU_2 as
   SELECT
   mandant_id, bestellart_id, MAX(CASE WHEN spr_id=22 THEN bestellart_bez END ) AS bestellart_bez                                         -- standard == DE
   , MAX(CASE WHEN spr_id=22 THEN bestellart_bez END) AS bestellart_bez_de                                 -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN bestellart_bez END), bestellart_bez_de) AS bestellart_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN bestellart_bez END), bestellart_bez_de) AS bestellart_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN bestellart_bez END), bestellart_bez_de) AS bestellart_bez_hr     -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN bestellart_bez END), bestellart_bez_de) AS bestellart_bez_pl      -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN bestellart_bez END), bestellart_bez_de) AS bestellart_bez_ro     -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN bestellart_bez END), bestellart_bez_de) AS bestellart_bez_bg    -- BG
   FROM dbp_view.v_bestellart_spr_zu_2
   GROUP BY
   mandant_id
   , bestellart_id;