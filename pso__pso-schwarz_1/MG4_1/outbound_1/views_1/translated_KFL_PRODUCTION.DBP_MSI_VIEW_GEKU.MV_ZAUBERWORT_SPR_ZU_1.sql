-- 30.10.2015 twie: Sprachzuordnung für Zusatzinfo 'Zauberwort' zum Ticket

-- da sich die zusatzinfo_id ändern kann, muss man über die zusatzinfo_bez filtern, um die zugehörigen zusatzinfo_sel_ids zu finden

-- man muss _id nehmen auch wenn sie sich bei Beladung ändern kann, weil _bez ist sprachabhängig und kann nicht als Schlüssel genommen werden

-- 03.03.2017 twie: SPEC0019359 Umstellung spaltenbasiert
 -- standard=deutsch

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_zauberwort_spr_zu_1 (zauberwort_id, zauberwort_bez,
zauberwort_bez_cz, zauberwort_bez_pl, zauberwort_bez_sk, zauberwort_bez_hr, zauberwort_bez_ro, zauberwort_bez_bg) AS
SELECT v01.zusatzinfo_sel_id AS zauberwort_id,
 MAX(CASE
   WHEN v03.spr_id = 22
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS zauberwort_bez,
 MAX(CASE
   WHEN v03.spr_id = 124
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS zauberwort_bez_cz,
 MAX(CASE
   WHEN v03.spr_id = 90
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS zauberwort_bez_pl,
 MAX(CASE
   WHEN v03.spr_id = 108
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS zauberwort_bez_sk,
 MAX(CASE
   WHEN v03.spr_id = 65
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS zauberwort_bez_hr,
 MAX(CASE
   WHEN v03.spr_id = 95
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS zauberwort_bez_ro,
 MAX(CASE
   WHEN v03.spr_id = 18
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS zauberwort_bez_bg
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu_1 AS v02 ON v01.zusatzinfo_id = v02.zusatzinfo_id
  -- zusatzinfo_sel_bez zu selektierten zusatzinfo_sel_id finden

 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_sel_spr_zu_1 AS v03 ON v01.zusatzinfo_sel_id = v03.zusatzinfo_sel_id
  
WHERE v02.spr_id = 22 -- fix

 AND v02.zusatzinfo_bez = 'Zauberwort'
GROUP BY zauberwort_id
UNION ALL
SELECT - 1 AS zauberwort_id,
 '' AS zauberwort_bez,
 '' AS zauberwort_bez_cz,
 '' AS zauberwort_bez_pl,
 '' AS zauberwort_bez_sk,
 '' AS zauberwort_bez_hr,
 '' AS zauberwort_bez_ro,
 '' AS zauberwort_bez_bg
FROM kfl_production_dbp_view.v_mandant_1
WHERE mandant_id = 1;