-- 31.08.2015 twie: Umbenennung von 'Hersteller' auf 'Hersteller Non-Food'

-- da sich die zusatzinfo_id bei jeder Beladung ändern kann, wird die Zusatzinfo über die deutsche Bezeichnung identifiziert

-- 21.11.2014 twie: Lookup für Zusatzinfo 'Hersteller' zum Ticket
 -- Dummywert

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_l_hersteller_1 (hersteller_id) AS SELECT v01.zusatzinfo_sel_id AS
 hersteller_id
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu_1 AS v02 ON v01.zusatzinfo_id = v02.zusatzinfo_id
WHERE v02.spr_id = 22 -- fix

 AND v02.zusatzinfo_bez = 'Hersteller Non-Food'
UNION ALL
SELECT - 1 AS hersteller_id
FROM kfl_production_dbp_view.v_mandant_1
WHERE mandant_id = 1;