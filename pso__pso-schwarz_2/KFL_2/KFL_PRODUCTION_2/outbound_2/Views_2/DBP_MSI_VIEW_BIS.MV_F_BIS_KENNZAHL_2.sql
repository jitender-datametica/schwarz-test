CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_f_bis_kennzahl_2 (gjqu, mandant_id, einsparung, volumen,
e_sourcing, anz_vertraege, anz_verhandlungen) AS SELECT gjqu,
 mandant_id,
 SUM(CASE
   WHEN bis_kennzahl_id = 1
   THEN bis_kennzahl_betrag
   ELSE NULL
   END) AS einsparung,
 SUM(CASE
   WHEN bis_kennzahl_id = 2
   THEN bis_kennzahl_betrag
   ELSE NULL
   END) AS volumen,
 SUM(CASE
   WHEN bis_kennzahl_id = 3
   THEN bis_kennzahl_betrag
   ELSE NULL
   END) AS e_sourcing,
 SUM(CASE
   WHEN bis_kennzahl_id = 4
   THEN bis_kennzahl_betrag
   ELSE NULL
   END) AS anz_vertraege,
 SUM(CASE
   WHEN bis_kennzahl_id = 5
   THEN bis_kennzahl_betrag
   ELSE NULL
   END) AS anz_verhandlungen
FROM kfl_production_dbp_msi_view_bis.ts_bis_kennzahl_2 AS V01
GROUP BY gjqu,
 mandant_id
UNION DISTINCT
SELECT gjqu,
 99 AS mandant_id,
 SUM(CASE
   WHEN bis_kennzahl_id = 1
   THEN bis_kennzahl_betrag
   ELSE NULL
   END) AS einsparung,
 SUM(CASE
   WHEN bis_kennzahl_id = 2
   THEN bis_kennzahl_betrag
   ELSE NULL
   END) AS volumen,
 SUM(CASE
   WHEN bis_kennzahl_id = 3
   THEN bis_kennzahl_betrag
   ELSE NULL
   END) AS e_sourcing,
 SUM(CASE
   WHEN bis_kennzahl_id = 4
   THEN bis_kennzahl_betrag
   ELSE NULL
   END) AS anz_vertraege,
 SUM(CASE
   WHEN bis_kennzahl_id = 5
   THEN bis_kennzahl_betrag
   ELSE NULL
   END) AS anz_verhandlungen
FROM kfl_production_dbp_msi_view_bis.ts_bis_kennzahl_int_2 AS V02
GROUP BY gjqu,
 mandant_id;