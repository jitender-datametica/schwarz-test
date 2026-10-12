CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ABT_SPR_ZU as
   SELECT DISTINCT
   v01.arthiertyp_id, v01.abt_id, MAX(CASE WHEN spr_id =  22 THEN abt_bez END) AS abt_bez                 -- standard == DE
   , MAX(CASE WHEN spr_id =  22 THEN abt_bez END) AS abt_bez_de                          -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN abt_bez END), abt_bez_de) AS abt_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN abt_bez END), abt_bez_de) AS abt_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN abt_bez END), abt_bez_de) AS abt_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN abt_bez END), abt_bez_de) AS abt_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN abt_bez END), abt_bez_de) AS abt_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN abt_bez END), abt_bez_de) AS abt_bez_bg    -- BG
   FROM dbp_view.v_abt_spr_zu  v01

   WHERE v01.arthiertyp_id = 2

   GROUP BY
   v01.arthiertyp_id
   , v01.abt_id;