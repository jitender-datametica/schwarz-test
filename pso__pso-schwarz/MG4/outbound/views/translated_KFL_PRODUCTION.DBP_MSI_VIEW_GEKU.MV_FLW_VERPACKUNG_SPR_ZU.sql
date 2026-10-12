-- 29.01.2014 twie: Sprachzuordnung für Zusatzinfo 'FLW Verpackung' zum Ticket

-- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

-- man muss _id nehmen auch wenn sie sich bei Beladung ändern kann, weil _bez ist sprachabhängig und kann nicht als Schlüssel genommen werden

-- da sich die zusatzinfo_id ändern kann, muss man über die zusatzinfo_bez filtern, um die zugehörigen zusatzinfo_sel_ids zu finden

-- standard=deutsch
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_flw_verpackung_spr_zu (flw_verpackung_id
, flw_verpackung_bez, flw_verpackung_bez_cz, flw_verpackung_bez_pl, flw_verpackung_bez_sk, flw_verpackung_bez_hr,
flw_verpackung_bez_ro, flw_verpackung_bez_bg) AS SELECT v01.zusatzinfo_sel_id AS flw_verpackung_id,
 MAX(CASE
   WHEN v03.spr_id = 22
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_verpackung_bez,
 MAX(CASE
   WHEN v03.spr_id = 124
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_verpackung_bez_cz,
 MAX(CASE
   WHEN v03.spr_id = 90
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_verpackung_bez_pl,
 MAX(CASE
   WHEN v03.spr_id = 108
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_verpackung_bez_sk,
 MAX(CASE
   WHEN v03.spr_id = 65
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_verpackung_bez_hr,
 MAX(CASE
   WHEN v03.spr_id = 95
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_verpackung_bez_ro,
 MAX(CASE
   WHEN v03.spr_id = 18
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_verpackung_bez_bg
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu AS v01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu AS v02 ON v01.zusatzinfo_id = v02.zusatzinfo_id
  -- zusatzinfo_sel_bez zu selektierten zusatzinfo_sel_id finden

 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_sel_spr_zu AS v03 ON v01.zusatzinfo_sel_id = v03.zusatzinfo_sel_id
  
WHERE v02.spr_id = 22 -- fix

 AND v02.zusatzinfo_bez = 'FLW Verpackung'
GROUP BY flw_verpackung_id
UNION ALL
SELECT - 1 AS flw_verpackung_id,
 '' AS flw_verpackung_bez,
 '' AS flw_verpackung_bez_cz,
 '' AS flw_verpackung_bez_pl,
 '' AS flw_verpackung_bez_sk,
 '' AS flw_verpackung_bez_hr,
 '' AS flw_verpackung_bez_ro,
 '' AS flw_verpackung_bez_bg
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id = 1;