-- da sich die zusatzinfo_id ändern kann, muss man über die zusatzinfo_bez filtern, um die zugehörigen zusatzinfo_sel_ids zu finden

-- standard=deutsch
 -- 21.11.2014 twie: Sprachzuordnung für Zusatzinfo 'Hersteller Purland-Fleisch/Wurst' zum Ticket

-- man muss _id nehmen auch wenn sie sich bei Beladung ändern kann, weil _bez ist sprachabhängig und kann nicht als Schlüssel genommen werden

-- 03.03.2017 twie: SPEC0019359 Umstellung spaltenbasiert

-- 31.08.2015 twie: Umbenennung von 'Hersteller Purland-Fleisch/Wurst' auf 'Hersteller Fleischwaren/Handelswaren'

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_hersteller_purlnd_spr_zu_2 (hersteller_purland_id,
hersteller_purland_bez, hersteller_purland_bez_cz, hersteller_purland_bez_pl, hersteller_purland_bez_sk,
hersteller_purland_bez_hr, hersteller_purland_bez_ro, hersteller_purland_bez_bg) AS SELECT v01.zusatzinfo_sel_id AS
 hersteller_purland_id,
 MAX(CASE
   WHEN v03.spr_id = 22
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_purland_bez,
 MAX(CASE
   WHEN v03.spr_id = 124
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_purland_bez_cz,
 MAX(CASE
   WHEN v03.spr_id = 90
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_purland_bez_pl,
 MAX(CASE
   WHEN v03.spr_id = 108
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_purland_bez_sk,
 MAX(CASE
   WHEN v03.spr_id = 65
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_purland_bez_hr,
 MAX(CASE
   WHEN v03.spr_id = 95
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_purland_bez_ro,
 MAX(CASE
   WHEN v03.spr_id = 18
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_purland_bez_bg
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu_2 AS v01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu_2 AS v02 ON v01.zusatzinfo_id = v02.zusatzinfo_id
  -- zusatzinfo_sel_bez zu selektierten zusatzinfo_sel_id finden

 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_sel_spr_zu_2 AS v03 ON v01.zusatzinfo_sel_id = v03.zusatzinfo_sel_id
  
WHERE v02.spr_id = 22 -- fix

 AND v02.zusatzinfo_bez = 'Hersteller Fleischwaren/Handelswaren'
GROUP BY hersteller_purland_id
UNION ALL
SELECT - 1 AS hersteller_purland_id,
 '' AS hersteller_purland_bez,
 '' AS hersteller_purland_bez_cz,
 '' AS hersteller_purland_bez_pl,
 '' AS hersteller_purland_bez_sk,
 '' AS hersteller_purland_bez_hr,
 '' AS hersteller_purland_bez_ro,
 '' AS hersteller_purland_bez_bg
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id = 1;