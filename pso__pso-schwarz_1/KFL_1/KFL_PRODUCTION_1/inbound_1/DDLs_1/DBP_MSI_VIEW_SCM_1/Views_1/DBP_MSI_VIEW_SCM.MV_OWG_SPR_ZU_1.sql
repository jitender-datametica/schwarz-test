CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_OWG_SPR_ZU_1 as
   SELECT DISTINCT
   v01.arthiertyp_id, v01.owg_id, MAX(CASE WHEN spr_id =  22 THEN owg_bez END) AS owg_bez                -- standard == DE
   , MAX(CASE WHEN spr_id =  22 THEN owg_bez END) AS owg_bez_de                         -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN owg_bez END), owg_bez_de) AS owg_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN owg_bez END), owg_bez_de) AS owg_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN owg_bez END), owg_bez_de) AS owg_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN owg_bez END), owg_bez_de) AS owg_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN owg_bez END), owg_bez_de) AS owg_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN owg_bez END), owg_bez_de) AS owg_bez_bg    -- BG
   FROM dbp_view.v_owg_spr_zu_1 v01
   WHERE v01.arthiertyp_id=2
   GROUP BY
   v01.arthiertyp_id
   , v01.owg_id;