CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_grund_fehlmengen (grund_id, grund_bez) AS SELECT 0 AS
 grund_id,
 'Leer / Empty' AS grund_bez
UNION ALL
SELECT 1 AS grund_id,
 'Auslistung / Räumen / Löschen' AS grund_bez
UNION ALL
SELECT 2 AS grund_id,
 'Gesperrter Bestand' AS grund_bez
UNION ALL
SELECT 3 AS grund_id,
 'Lieferprobleme / Lieferboykott' AS grund_bez
UNION ALL
SELECT 4 AS grund_id,
 'Fehlartikel trotz Bestand' AS grund_bez
UNION ALL
SELECT 5 AS grund_id,
 'Neuer Artikel' AS grund_bez;