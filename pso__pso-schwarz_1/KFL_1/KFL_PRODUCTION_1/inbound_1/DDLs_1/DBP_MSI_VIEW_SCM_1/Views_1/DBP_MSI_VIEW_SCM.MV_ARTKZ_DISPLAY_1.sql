CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ARTKZ_DISPLAY_1 as
   SELECT
   mandant_id,  display_id, COALESCE(MAX(CASE WHEN spr_id=22 THEN display_bez END), '0') AS display_bez                                              -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id=22 THEN display_bez END), '0') AS display_bez_de                                 -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN display_bez END), display_bez_de) AS display_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN display_bez END), display_bez_de) AS display_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN display_bez END), display_bez_de) AS display_bez_hr     -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN display_bez END), display_bez_de) AS display_bez_pl      -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN display_bez END), display_bez_de) AS display_bez_ro     -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN display_bez END), display_bez_de) AS display_bez_bg    -- BG
   FROM dbp_view.v_artkz_display_1
   GROUP BY
   mandant_id
   ,  display_id;