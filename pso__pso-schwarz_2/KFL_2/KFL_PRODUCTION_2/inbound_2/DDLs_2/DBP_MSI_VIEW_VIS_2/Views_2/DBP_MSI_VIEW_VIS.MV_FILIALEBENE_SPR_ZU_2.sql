CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FILIALEBENE_SPR_ZU_2 as

   SELECT
   filialebene_id, MAX(CASE WHEN spr_id =  22 THEN filialebene_bez END) AS filialebene_bez                 -- standard == DE
   , MAX(CASE WHEN spr_id =  22 THEN filialebene_bez END) AS filialebene_bez_de                          -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN filialebene_bez END), filialebene_bez_de) AS filialebene_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN filialebene_bez END), filialebene_bez_de) AS filialebene_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN filialebene_bez END), filialebene_bez_de) AS filialebene_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN filialebene_bez END), filialebene_bez_de) AS filialebene_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN filialebene_bez END), filialebene_bez_de) AS filialebene_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN filialebene_bez END), filialebene_bez_de) AS filialebene_bez_bg    -- BG


   FROM dbp_view.v_filialebene_spr_zu_2
   GROUP BY filialebene_id
   ;