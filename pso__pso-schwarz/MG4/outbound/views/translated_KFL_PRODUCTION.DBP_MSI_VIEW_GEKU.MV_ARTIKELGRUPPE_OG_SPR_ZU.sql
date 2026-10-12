-- 29.01.2014 twie: Sprachzuordnung für Zusatzinfo 'Artikelgruppen O&G' zum Ticket

-- da sich die zusatzinfo_id ändern kann, muss man über die zusatzinfo_bez filtern, um die zugehörigen zusatzinfo_sel_ids zu finden

-- man muss _id nehmen auch wenn sie sich bei Beladung ändern kann, weil _bez ist sprachabhängig und kann nicht als Schlüssel genommen werden

-- 13.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert
 -- standard=deutsch

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_artikelgruppe_og_spr_zu (artikelgruppe_og_id,
artikelgruppe_og_bez, artikelgruppe_og_bez_cz, artikelgruppe_og_bez_pl, artikelgruppe_og_bez_sk, artikelgruppe_og_bez_hr
, artikelgruppe_og_bez_ro, artikelgruppe_og_bez_bg) AS SELECT v01.zusatzinfo_sel_id AS artikelgruppe_og_id,
 MAX(CASE
   WHEN v03.spr_id = 22
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS artikelgruppe_og_bez,
 MAX(CASE
   WHEN v03.spr_id = 124
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS artikelgruppe_og_bez_cz,
 MAX(CASE
   WHEN v03.spr_id = 90
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS artikelgruppe_og_bez_pl,
 MAX(CASE
   WHEN v03.spr_id = 108
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS artikelgruppe_og_bez_sk,
 MAX(CASE
   WHEN v03.spr_id = 65
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS artikelgruppe_og_bez_hr,
 MAX(CASE
   WHEN v03.spr_id = 95
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS artikelgruppe_og_bez_ro,
 MAX(CASE
   WHEN v03.spr_id = 18
   THEN v03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS artikelgruppe_og_bez_bg
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu AS v01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu AS v02 ON v01.zusatzinfo_id = v02.zusatzinfo_id
  -- zusatzinfo_sel_bez zu selektierten zusatzinfo_sel_id finden

 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_sel_spr_zu AS v03 ON v01.zusatzinfo_sel_id = v03.zusatzinfo_sel_id
  
WHERE v02.spr_id = 22 -- fix

 AND v02.zusatzinfo_bez = 'Artikelgruppen O&G'
GROUP BY artikelgruppe_og_id
UNION ALL
SELECT - 1 AS artikelgruppe_og_id,
 '' AS artikelgruppe_og_bez,
 '' AS artikelgruppe_og_bez_cz,
 '' AS artikelgruppe_og_bez_pl,
 '' AS artikelgruppe_og_bez_sk,
 '' AS artikelgruppe_og_bez_hr,
 '' AS artikelgruppe_og_bez_ro,
 '' AS artikelgruppe_og_bez_bg
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id = 1;