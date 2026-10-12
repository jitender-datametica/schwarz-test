CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WETTERZUSTAND_SPR_ZU as
   SELECT
   v01.wetterzustand_id, MAX(CASE WHEN v01.spr_id =  22 THEN v01.wetterzustand_bez END) AS wetterzustand_bez                    --standard=deutsch
   , MAX(CASE WHEN v01.spr_id =  22 THEN v01.wetterzustand_bez END) AS wetterzustand_bez_de             --DE
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.wetterzustand_bez END), wetterzustand_bez_de) AS wetterzustand_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.wetterzustand_bez END), wetterzustand_bez_de) AS wetterzustand_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.wetterzustand_bez END), wetterzustand_bez_de) AS wetterzustand_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.wetterzustand_bez END), wetterzustand_bez_de) AS wetterzustand_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.wetterzustand_bez END), wetterzustand_bez_de) AS wetterzustand_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.wetterzustand_bez END), wetterzustand_bez_de) AS wetterzustand_bez_bg    -- BG
   FROM dbp_view.v_wetterzustand_spr_zu v01
   GROUP BY
   v01.wetterzustand_id;