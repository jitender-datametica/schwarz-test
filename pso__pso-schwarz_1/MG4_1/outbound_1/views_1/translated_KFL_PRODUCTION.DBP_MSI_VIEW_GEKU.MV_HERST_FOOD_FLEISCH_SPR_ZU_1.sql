-- 30.10.2015 twie: Sprachzuordnung für Zusatzinfo 'Hersteller Food/Fleischwaren' zum Ticket

-- da sich die zusatzinfo_id ändern kann, muss man über die zusatzinfo_bez filtern, um die zugehörigen zusatzinfo_sel_ids zu finden

-- man muss _id nehmen auch wenn sie sich bei Beladung ändern kann, weil _bez ist sprachabhängig und kann nicht als Schlüssel genommen werden

-- standard=deutsch
 -- 03.03.2017 twie: SPEC0019359 Umstellung spaltenbasiert

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_herst_food_fleisch_spr_zu_1 (hersteller_food_fleisch_id,
hersteller_food_fleisch_bez, hersteller_food_fleisch_bez_cz, hersteller_food_fleisch_bez_pl,
hersteller_food_fleisch_bez_sk, hersteller_food_fleisch_bez_hr, hersteller_food_fleisch_bez_ro,
hersteller_food_fleisch_bez_bg) AS SELECT v01.zusatzinfo_sel_id AS hersteller_food_fleisch_id,
 MAX(CASE
   WHEN v03.spr_id = 22
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_food_fleisch_bez,
 MAX(CASE
   WHEN v03.spr_id = 124
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_food_fleisch_bez_cz,
 MAX(CASE
   WHEN v03.spr_id = 90
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_food_fleisch_bez_pl,
 MAX(CASE
   WHEN v03.spr_id = 108
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_food_fleisch_bez_sk,
 MAX(CASE
   WHEN v03.spr_id = 65
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_food_fleisch_bez_hr,
 MAX(CASE
   WHEN v03.spr_id = 95
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_food_fleisch_bez_ro,
 MAX(CASE
   WHEN v03.spr_id = 18
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_food_fleisch_bez_bg
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu_1 AS v02 ON v01.zusatzinfo_id = v02.zusatzinfo_id
  -- zusatzinfo_sel_bez zu selektierten zusatzinfo_sel_id finden

 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_sel_spr_zu_1 AS v03 ON v01.zusatzinfo_sel_id = v03.zusatzinfo_sel_id
  
WHERE v02.spr_id = 22 -- fix

 AND v02.zusatzinfo_bez = 'Hersteller Food/Fleischwaren'
GROUP BY hersteller_food_fleisch_id
UNION ALL
SELECT - 1 AS hersteller_food_fleisch_id,
 '' AS hersteller_food_fleisch_bez,
 '' AS hersteller_food_fleisch_bez_cz,
 '' AS hersteller_food_fleisch_bez_pl,
 '' AS hersteller_food_fleisch_bez_sk,
 '' AS hersteller_food_fleisch_bez_hr,
 '' AS hersteller_food_fleisch_bez_ro,
 '' AS hersteller_food_fleisch_bez_bg
FROM kfl_production_dbp_view.v_mandant_1
WHERE mandant_id = 1;