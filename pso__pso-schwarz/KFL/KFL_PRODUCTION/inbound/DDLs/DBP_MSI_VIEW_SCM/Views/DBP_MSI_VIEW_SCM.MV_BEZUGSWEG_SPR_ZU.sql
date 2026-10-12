CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_BEZUGSWEG_SPR_ZU as
   SELECT
   v01.mandant_id, v01.bezugsweg_id, MAX(CASE WHEN spr_id =  22 THEN bezugsweg_bez END) AS bezugsweg_bez                 -- standard == DE
   , MAX(CASE WHEN spr_id =  22 THEN bezugsweg_bez END) AS bezugsweg_bez_de                          -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_bg    -- BG
   FROM dbp_view.v_bezugsweg_spr_zu  v01
   GROUP BY
   v01.mandant_id
   , v01.bezugsweg_id;