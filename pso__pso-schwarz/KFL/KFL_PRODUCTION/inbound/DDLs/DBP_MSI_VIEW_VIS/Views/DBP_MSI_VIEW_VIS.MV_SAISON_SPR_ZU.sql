CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SAISON_SPR_ZU as
   SELECT
   mandant_id, saison_id, MAX(CASE WHEN spr_id=22 THEN saison_bez END) AS saison_bez                                              -- standard == DE
   , MAX(CASE WHEN spr_id=22 THEN saison_bez END) AS saison_bez_de                                 -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN saison_bez END), saison_bez_de) AS saison_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN saison_bez END), saison_bez_de) AS saison_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN saison_bez END), saison_bez_de) AS saison_bez_hr     -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN saison_bez END), saison_bez_de) AS saison_bez_pl      -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN saison_bez END), saison_bez_de) AS saison_bez_ro     -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN saison_bez END), saison_bez_de) AS saison_bez_bg    -- BG
   FROM dbp_view.v_saison_spr_zu
   GROUP BY
   mandant_id
   , saison_id;