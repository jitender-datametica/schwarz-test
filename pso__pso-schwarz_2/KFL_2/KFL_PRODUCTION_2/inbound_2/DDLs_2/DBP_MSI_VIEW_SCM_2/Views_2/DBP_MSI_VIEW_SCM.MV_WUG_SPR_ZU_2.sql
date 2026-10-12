CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WUG_SPR_ZU_2 as
   SELECT
   v01.mandant_id, v01.arthiertyp_id, v01.wg_id, v01.wug_id, MAX(CASE WHEN v01.spr_id =  22 THEN v01.wug_bez END) AS wug_bez                 -- standard == DE
   , MAX(CASE WHEN v01.spr_id =  22 THEN v01.wug_bez END) AS wug_bez_de                                    -- DE
   , COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN wug_bez END), wug_bez_de) AS wug_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN wug_bez END), wug_bez_de) AS wug_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN wug_bez END), wug_bez_de) AS wug_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN wug_bez END), wug_bez_de) AS wug_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN wug_bez END), wug_bez_de) AS wug_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN wug_bez END), wug_bez_de) AS wug_bez_bg    -- BG
   FROM dbp_view.v_wug_spr_zu_2 v01
   WHERE v01.arthiertyp_id = 2
   GROUP BY
   v01.mandant_id
   , v01.arthiertyp_id
   , v01.wg_id
   , v01.wug_id;