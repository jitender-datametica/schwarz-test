-- 13.03.2015 twie: Lookup für Zusatzinfo 'Hersteller KLM-Food' zum Ticket

-- da sich die zusatzinfo_id bei jeder Beladung ändern kann, wird die Zusatzinfo über die deutsche Bezeichnung identifiziert

-- Dummywert
 -- 31.08.2015 twie: Umbenennung von 'Hersteller KLM-Food' auf 'Hersteller Food'

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_l_hersteller_food (hersteller_food_id) AS SELECT v01.zusatzinfo_sel_id AS
 hersteller_food_id
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu AS v01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu AS v02 ON v01.zusatzinfo_id = v02.zusatzinfo_id
WHERE v02.spr_id = 22 -- fix

 AND v02.zusatzinfo_bez = 'Hersteller Food'
UNION ALL
SELECT - 1 AS hersteller_food_id
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id = 1;