-- Dummywert

-- da sich die zusatzinfo_id bei jeder Beladung ändern kann, wird die Zusatzinfo über die deutsche Bezeichnung identifiziert

-- 30.10.2015 twie: Lookup für Zusatzinfo 'Schädlingsart' zum Ticket

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_l_schaedlingsart (schaedlingsart_id) AS SELECT v01.zusatzinfo_sel_id AS
 schaedlingsart_id
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu AS v01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu AS v02 ON v01.zusatzinfo_id = v02.zusatzinfo_id
WHERE v02.spr_id = 22 -- fix

 AND v02.zusatzinfo_bez = 'Schädlingsart'
UNION ALL
SELECT - 1 AS schaedlingsart_id
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id = 1;