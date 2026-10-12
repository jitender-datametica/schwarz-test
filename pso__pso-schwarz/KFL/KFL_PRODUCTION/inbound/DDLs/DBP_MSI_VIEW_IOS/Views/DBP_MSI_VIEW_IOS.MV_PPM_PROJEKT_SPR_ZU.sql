CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_PPM_PROJEKT_SPR_ZU as
   SELECT
   v02.mandant_id, v01.in_budget_typ_id, MAX(CASE WHEN v01.spr_id =  22 THEN v01.in_budget_typ_bez ELSE NULL END) AS in_budget_typ_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.in_budget_typ_bez ELSE NULL END), MAX(CASE WHEN v01.spr_id =  22 THEN v01.in_budget_typ_bez ELSE NULL END)) AS in_budget_typ_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.in_budget_typ_bez ELSE NULL END), MAX(CASE WHEN v01.spr_id =  22 THEN v01.in_budget_typ_bez ELSE NULL END)) AS in_budget_typ_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN v01.spr_id = 65 THEN v01.in_budget_typ_bez ELSE NULL END), MAX(CASE WHEN v01.spr_id =  22 THEN v01.in_budget_typ_bez ELSE NULL END)) AS in_budget_typ_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v01.spr_id = 90 THEN v01.in_budget_typ_bez ELSE NULL END), MAX(CASE WHEN v01.spr_id =  22 THEN v01.in_budget_typ_bez ELSE NULL END)) AS in_budget_typ_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v01.spr_id = 95 THEN v01.in_budget_typ_bez ELSE NULL END), MAX(CASE WHEN v01.spr_id =  22 THEN v01.in_budget_typ_bez ELSE NULL END)) AS in_budget_typ_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.in_budget_typ_bez ELSE NULL END), MAX(CASE WHEN v01.spr_id =  22 THEN v01.in_budget_typ_bez ELSE NULL END)) AS in_budget_typ_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN v01.spr_id = 18 THEN v01.in_budget_typ_bez ELSE NULL END), MAX(CASE WHEN v01.spr_id =  22 THEN v01.in_budget_typ_bez ELSE NULL END)) AS in_budget_typ_bez_bg    -- BG

   FROM dbp_view.v_in_budget_typ_spr_zu v01
   CROSS JOIN dbp_view.v_mandant v02 -- Cross Join weil FE-Attribut aus einem Compound-Key besteht, in_budget_typ_id und mandant_id
   GROUP BY
   v02.mandant_id
   ,v01.in_budget_typ_id;