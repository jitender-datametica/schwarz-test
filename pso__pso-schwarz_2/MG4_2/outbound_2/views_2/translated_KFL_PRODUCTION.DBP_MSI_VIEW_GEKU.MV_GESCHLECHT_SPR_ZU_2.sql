-- 29.01.2014 twie: Sprachzuordnung für Zusatzinfo 'Geschlecht' zum Ticket

-- man muss _id nehmen auch wenn sie sich bei Beladung ändern kann, weil _bez ist sprachabhängig und kann nicht als Schlüssel genommen werden

-- da sich die zusatzinfo_id ändern kann, muss man über die zusatzinfo_bez filtern, um die zugehörigen zusatzinfo_sel_ids zu finden

-- standard=deutsch
 -- 03.03.2017 twie: SPEC0019359 Umstellung spaltenbasiert

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geschlecht_spr_zu_2 (geschlecht_id, geschlecht_bez,
geschlecht_bez_cz, geschlecht_bez_pl, geschlecht_bez_sk, geschlecht_bez_hr, geschlecht_bez_ro, geschlecht_bez_bg) AS
SELECT v01.zusatzinfo_sel_id AS geschlecht_id,
 MAX(CASE
   WHEN v03.spr_id = 22
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS geschlecht_bez,
 MAX(CASE
   WHEN v03.spr_id = 124
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS geschlecht_bez_cz,
 MAX(CASE
   WHEN v03.spr_id = 90
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS geschlecht_bez_pl,
 MAX(CASE
   WHEN v03.spr_id = 108
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS geschlecht_bez_sk,
 MAX(CASE
   WHEN v03.spr_id = 65
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS geschlecht_bez_hr,
 MAX(CASE
   WHEN v03.spr_id = 95
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS geschlecht_bez_ro,
 MAX(CASE
   WHEN v03.spr_id = 18
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS geschlecht_bez_bg
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu_2 AS v01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu_2 AS v02 ON v01.zusatzinfo_id = v02.zusatzinfo_id
  -- zusatzinfo_sel_bez zu selektierten zusatzinfo_sel_id finden

 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_sel_spr_zu_2 AS v03 ON v01.zusatzinfo_sel_id = v03.zusatzinfo_sel_id
  
WHERE v02.spr_id = 22 -- fix

 AND v02.zusatzinfo_bez = 'Geschlecht'
GROUP BY geschlecht_id
UNION ALL
SELECT - 1 AS geschlecht_id,
 '' AS geschlecht_bez,
 '' AS geschlecht_bez_cz,
 '' AS geschlecht_bez_pl,
 '' AS geschlecht_bez_sk,
 '' AS geschlecht_bez_hr,
 '' AS geschlecht_bez_ro,
 '' AS geschlecht_bez_bg
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id = 1;