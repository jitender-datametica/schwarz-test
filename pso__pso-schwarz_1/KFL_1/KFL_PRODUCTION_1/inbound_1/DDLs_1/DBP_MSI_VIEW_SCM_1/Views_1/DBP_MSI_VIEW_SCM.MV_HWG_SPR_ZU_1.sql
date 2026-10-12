CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_HWG_SPR_ZU_1 as
   SELECT  DISTINCT
   v01.arthiertyp_id, v01.hwg_id, MAX(CASE WHEN v01.spr_id =  22 THEN v01.hwg_bez END) AS hwg_bez                -- standard == DE
   , MAX(CASE WHEN v01.spr_id =  22 THEN v01.hwg_bez END) AS hwg_bez_de                                --DE
   , COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.hwg_bez END), hwg_bez_de) AS hwg_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.hwg_bez END), hwg_bez_de) AS hwg_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.hwg_bez END), hwg_bez_de) AS hwg_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.hwg_bez END), hwg_bez_de) AS hwg_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.hwg_bez END), hwg_bez_de) AS hwg_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.hwg_bez END), hwg_bez_de) AS hwg_bez_bg    -- BG
   FROM dbp_view.v_hwg_spr_zu_1  v01
   WHERE v01.arthiertyp_id = 2
   GROUP BY
   v01.arthiertyp_id
   , v01.hwg_id;