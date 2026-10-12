-- 30.10.2015 twie: Lookup für Zusatzinfo 'Hersteller Food/Fleischwaren' zum Ticket

-- da sich die zusatzinfo_id bei jeder Beladung ändern kann, wird die Zusatzinfo über die deutsche Bezeichnung identifiziert

-- Dummywert
 CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_l_herst_food_fleisch_2 (hersteller_food_fleisch_id) AS SELECT
 v01.zusatzinfo_sel_id AS hersteller_food_fleisch_id
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu_2 AS v01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu_2 AS v02 ON v01.zusatzinfo_id = v02.zusatzinfo_id
WHERE v02.spr_id = 22 -- fix

 AND v02.zusatzinfo_bez = 'Hersteller Food/Fleischwaren'
UNION ALL
SELECT - 1 AS hersteller_food_fleisch_id
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id = 1;