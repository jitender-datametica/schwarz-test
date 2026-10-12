CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_GRUND_FEHLMENGEN_2(
	GRUND_ID,
	GRUND_BEZ
) AS
--2024-04-22, AP0179753, dknop, initial
SELECT
0 AS grund_id,
'Leer / Empty' AS grund_bez
UNION
SELECT
1 AS grund_id,
'Auslistung / Räumen / Löschen' AS grund_bez
UNION
SELECT
2 AS grund_id,
'Gesperrter Bestand' AS grund_bez
UNION
SELECT
3 AS grund_id,
'Lieferprobleme / Lieferboykott' AS grund_bez
UNION
SELECT
4 AS grund_id,
'Fehlartikel trotz Bestand' AS grund_bez
UNION
SELECT
5 AS grund_id,
'Neuer Artikel_2' AS grund_bez
 
 
;