-- Dummywert

-- 31.08.2015 twie: Umbenennung von 'Hersteller Purland-Fleisch/Wurst' auf 'Hersteller Fleischwaren/Handelswaren'

-- da sich die zusatzinfo_id bei jeder Beladung ändern kann, wird die Zusatzinfo über die deutsche Bezeichnung identifiziert

-- 13.03.2015 twie: Lookup für Zusatzinfo 'Hersteller Purland-Fleisch/Wurst' zum Ticket

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_l_hersteller_purland_2 (hersteller_purland_id) AS SELECT v01.zusatzinfo_sel_id
  AS hersteller_purland_id
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu_2 AS v01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu_2 AS v02 ON v01.zusatzinfo_id = v02.zusatzinfo_id
WHERE v02.spr_id = 22 -- fix

 AND v02.zusatzinfo_bez = 'Hersteller Fleischwaren/Handelswaren'
UNION ALL
SELECT - 1 AS hersteller_purland_id
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id = 1;